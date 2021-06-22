@ECHO OFF
CALL %~dp0\InitializeEnvironment.bat || EXIT /b 10
SETLOCAL

IF "%~1"=="" (
    SET CONFIGURATION=Debug
) ELSE (
    SET CONFIGURATION=%1
)

IF "%~2"=="" (
    SET OUTROOT=%VFS_PUBLISHDIR%
) ELSE (
    SET OUTROOT=%2
)

REM Check NuGet is on the PATH
where /q nuget.exe
IF ERRORLEVEL 1 (
    ECHO error: missing NuGet on the PATH
    EXIT /B 1
)

IF EXIST %OUTROOT% (
  rmdir /s /q %OUTROOT%
)

ECHO Collecting GVFS.Installers...
mkdir %OUTROOT%\GVFS.Installers
xcopy /S /Y ^
    %VFS_OUTDIR%\GVFS.Installers\bin\%CONFIGURATION%\win-x64 ^
    %OUTROOT%\GVFS.Installers\ || GOTO ERROR

ECHO Collecting FastFetch...
mkdir %OUTROOT%\FastFetch
xcopy /S /Y ^
    %VFS_OUTDIR%\FastFetch\bin\%CONFIGURATION%\net461\win-x64 ^
    %OUTROOT%\FastFetch\ || GOTO ERROR

ECHO Collecting GVFS.FunctionalTests...
mkdir %OUTROOT%\GVFS.FunctionalTests
xcopy /S /Y ^
    %VFS_OUTDIR%\GVFS.FunctionalTests\bin\%CONFIGURATION%\net461\win-x64 ^
    %OUTROOT%\GVFS.FunctionalTests\ || GOTO ERROR

ECHO Create installers NuGet package...
mkdir %OUTROOT%\NuGetPackages
nuget.exe pack ^
    %VFS_OUTDIR%\GVFS.Installers\bin\%CONFIGURATION%\win-x64\GVFS.Installers.nuspec ^
    -BasePath %VFS_OUTDIR%\GVFS.Installers\bin\%CONFIGURATION%\win-x64 ^
    -OutputDirectory %OUTROOT%\NuGetPackages

REM Move the nuspec file to the NuGetPackages artifact directory
move %OUTROOT%\GVFS.Installers\GVFS.Installers.nuspec ^
    %OUTROOT%\NuGetPackages

GOTO :EOF

:USAGE
ECHO usage: %~n0%~x0 [^<configuration^>] [^<destination^>]
ECHO.
ECHO   configuration    Solution configuration (default: Debug).
ECHO   destination      Destination directory to copy artifacts (default: %VFS_PUBLISHDIR%).
ECHO.
EXIT 1

:ERROR
ECHO error: create build artifacts failed with exit code %ERRORLEVEL%
EXIT /B %ERRORLEVEL%
