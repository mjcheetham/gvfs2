REM @ECHO OFF
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

IF EXIST %OUTROOT% (
  rmdir /s /q %OUTROOT%
)

ECHO Configuration: %CONFIGURATION%
ECHO Output Directory: %OUTROOT%

dir %VFS_OUTDIR%\GVFS.Installers\bin\%CONFIGURATION%\win-x64\

tree %CD%\..

ECHO Collecting GVFS.Installers...
mkdir %OUTROOT%\GVFS.Installers\
xcopy /S /Y ^
    %VFS_OUTDIR%\GVFS.Installers\bin\%CONFIGURATION%\win-x64\ ^
    %OUTROOT%\GVFS.Installers\ || GOTO ERROR

ECHO Collecting FastFetch...
mkdir %OUTROOT%\FastFetch\
xcopy /S /Y ^
    %VFS_OUTDIR%\FastFetch\bin\%CONFIGURATION%\net461\win-x64\ ^
    %OUTROOT%\FastFetch\ || GOTO ERROR

ECHO Collecting GVFS.FunctionalTests...
mkdir %OUTROOT%\GVFS.FunctionalTests\
xcopy /S /Y ^
    %VFS_OUTDIR%\GVFS.FunctionalTests\bin\%CONFIGURATION%\net461\win-x64\ ^
    %OUTROOT%\GVFS.FunctionalTests\ || GOTO ERROR

ECHO Create installers NuGet package...
mkdir %OUTROOT%\NuGetPackages
PUSHD %VFS_OUTDIR%\GVFS.Installers\bin\%CONFIGURATION%\win-x64
nuget.exe pack GVFS.Installers.nuspec -OutputDirectory %OUTROOT%\NuGetPackages
POPD

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
