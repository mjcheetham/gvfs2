@ECHO OFF
SETLOCAL

REM Lookup full paths to Git and VFS for Git installers
FOR /F "tokens=* USEBACKQ" %%F IN ( `where /R %~dp0 Git*.exe` ) DO SET GIT_INSTALLER=%%F
FOR /F "tokens=* USEBACKQ" %%F IN ( `where /R %~dp0 SetupGVFS*.exe` ) DO SET GVFS_INSTALLER=%%F

ECHO Installing Git for Windows...
CALL %GIT_INSTALLER% /DIR"C:\Program Files\Git" /NOICONS /COMPONENTS="ext,ext\shellhere,ext\guihere,assoc,assoc_sh" /GROUP="Git" /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /ALLOWDOWNGRADE=1

ECHO Installing VFS for Git...
CALL %GVFS_INSTALLER% /VERYSILENT /SUPPRESSMSGBOXES /NORESTART
