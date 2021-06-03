@ECHO OFF
SETLOCAL

SET ROOT=%~dp0..

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

msbuild %ROOT%\GVFS.sln ^
        /t:Restore ^
        /p:Configuration=%CONFIGURATION%

msbuild %ROOT%\GVFS.sln ^
        /t:Build ^
        /p:Configuration=%CONFIGURATION%

dotnet publish ^
    %ROOT%\GVFS\FastFetch ^
    -c %CONFIGURATION% ^
    -o %ROOT%\..\out\publish ^
    -r win-x64 ^
    --self-contained

:EOF
