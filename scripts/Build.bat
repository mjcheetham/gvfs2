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

ECHO Restoring packages...
msbuild %VFS_SRCDIR%\GVFS.sln ^
        /t:Restore ^
        /p:Configuration=%CONFIGURATION% || GOTO ERROR

ECHO Building solution...
msbuild %VFS_SRCDIR%\GVFS.sln ^
        /t:Build ^
        /p:Configuration=%CONFIGURATION% || GOTO ERROR

mkdir %VFS_PUBLISHDIR%

ECHO Publishing FastFetch standalone...
dotnet publish ^
    %VFS_SRCDIR%\GVFS\FastFetch ^
    -c %CONFIGURATION% ^
    -o %VFS_PUBLISHDIR%\FastFetch ^
    -r win-x64 ^
    --self-contained || GOTO ERROR

GOTO :EOF

:USAGE
ECHO usage: %~n0%~x0 [^<configuration^>] [^<version^>]
ECHO.
ECHO   configuration    Solution configuration (default: Debug).
ECHO   version          GVFS version (default: 0.2.173.2).
ECHO.
EXIT 1

:ERROR
ECHO error: build failed with exit code %ERRORLEVEL%
EXIT /B %ERRORLEVEL%
