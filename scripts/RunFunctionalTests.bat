@ECHO OFF
CALL %~dp0\InitializeEnvironment.bat || EXIT /b 10

IF "%1"=="" (SET "CONFIGURATION=Debug") ELSE (SET "CONFIGURATION=%1")

SETLOCAL
SET PATH=C:\Program Files\GVFS;C:\Program Files\Git\cmd;%PATH%

IF NOT "%2"=="--test-gvfs-on-path" GOTO :startFunctionalTests

REM Force GVFS.FunctionalTests.exe to use the installed version of GVFS
DEL %VFS_BUILDDIR%\GVFS.FunctionalTests\bin\%CONFIGURATION%\net461\win-x64\GitHooksLoader.exe
DEL %VFS_BUILDDIR%\GVFS.FunctionalTests\bin\%CONFIGURATION%\net461\win-x64\GVFS.exe
DEL %VFS_BUILDDIR%\GVFS.FunctionalTests\bin\%CONFIGURATION%\net461\win-x64\GVFS.Hooks.exe
DEL %VFS_BUILDDIR%\GVFS.FunctionalTests\bin\%CONFIGURATION%\net461\win-x64\GVFS.ReadObjectHook.exe
DEL %VFS_BUILDDIR%\GVFS.FunctionalTests\bin\%CONFIGURATION%\net461\win-x64\GVFS.VirtualFileSystemHook.exe
DEL %VFS_BUILDDIR%\GVFS.FunctionalTests\bin\%CONFIGURATION%\net461\win-x64\GVFS.PostIndexChangedHook.exe
DEL %VFS_BUILDDIR%\GVFS.FunctionalTests\bin\%CONFIGURATION%\net461\win-x64\GVFS.Mount.exe
DEL %VFS_BUILDDIR%\GVFS.FunctionalTests\bin\%CONFIGURATION%\net461\win-x64\GVFS.Service.exe
DEL %VFS_BUILDDIR%\GVFS.FunctionalTests\bin\%CONFIGURATION%\net461\win-x64\GVFS.Service.UI.exe

ECHO PATH = %PATH%
ECHO gvfs location:
where gvfs
ECHO GVFS.Service location:
where GVFS.Service
ECHO git location:
where git

:startFunctionalTests
%VFS_BUILDDIR%\GVFS.FunctionalTests\bin\%CONFIGURATION%\net461\win-x64\GVFS.FunctionalTests.exe /result:TestResultNetFramework.xml %2 %3 %4 %5 || GOTO :endFunctionalTests

:endFunctionalTests
SET error=%ERRORLEVEL%

CALL %VFS_SCRIPTSDIR%\StopAllServices.bat

EXIT /b %error%
