@ECHO OFF
CALL %~dp0\InitializeEnvironment.bat || EXIT /b 10
SETLOCAL

IF "%~1"=="" (
    SET CONFIGURATION=Debug
) ELSE (
    SET CONFIGURATION=%1
)

IF "%~2"=="" (
    SET GVFSVERSION=0.2.173.2
) ELSE (
    SET GVFSVERSION=%2
)

IF "%~3"=="" (
    SET VERBOSITY=minimal
) ELSE (
    SET VERBOSITY=%3
)

REM Check MSBuild is on the PATH
where /q msbuild.exe
IF ERRORLEVEL 1 (
    ECHO error: missing MSBuild on the PATH
    EXIT /B 1
)

ECHO Restoring packages...
msbuild.exe %VFS_SRCDIR%\GVFS.sln ^
        /t:Restore ^
        /v:%VERBOSITY% ^
        /p:Configuration=%CONFIGURATION% || GOTO ERROR

ECHO Building solution...
msbuild.exe %VFS_SRCDIR%\GVFS.sln ^
        /t:Build ^
        /v:%VERBOSITY% ^
        /p:Configuration=%CONFIGURATION% || GOTO ERROR

GOTO :EOF

:USAGE
ECHO usage: %~n0%~x0 [^<configuration^>] [^<version^>] [^<verbosity^>]
ECHO.
ECHO   configuration    Solution configuration (default: Debug).
ECHO   version          GVFS version (default: 0.2.173.2).
ECHO   verbosity        MSBuild verbosity (default: minimal).
ECHO.
EXIT 1

:ERROR
ECHO error: build failed with exit code %ERRORLEVEL%
EXIT /B %ERRORLEVEL%
