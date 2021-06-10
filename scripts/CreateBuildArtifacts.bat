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

IF EXIST %OUTROOT% (
  rmdir /s /q %OUTROOT%
)

ECHO Collecting Installer...
xcopy /S /Y ^
    %VFS_BUILDDIR%\GVFS.Installer\bin\%CONFIGURATION% ^
    %OUTROOT%\GVFS.Installer\ || GOTO ERROR

ECHO Collecting FastFetch standalone...
xcopy /S /Y ^
    %VFS_BUILDDIR%\FastFetch\bin\%CONFIGURATION%\net461\win-x64 ^
    %OUTROOT%\FastFetch\ || GOTO ERROR

ECHO Collecting GVFS.FunctionalTests standalone...
xcopy /S /Y ^
    %VFS_BUILDDIR%\GVFS.FunctionalTests\bin\%CONFIGURATION%\net461\win-x64 ^
    %OUTROOT%\GVFS.FunctionalTests\ || GOTO ERROR

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
