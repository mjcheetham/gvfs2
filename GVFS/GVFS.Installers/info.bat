@ECHO OFF
SETLOCAL

SET SYS_PRJFLT=C:\Windows\System32\drivers\prjflt.sys
SET SYS_PROJFSLIB=C:\Windows\System32\ProjectedFSLib.dll
SET VFS_PROJFSLIB=C:\Program Files\GVFS\ProjectedFSLib.dll
SET BND_PRJFLT=C:\Program Files\GVFS\Filter\PrjFlt.sys
SET BND_PROJFSLIB=C:\Program Files\GVFS\ProjFS\ProjectedFSLib.dll

ECHO Checking ProjFS Windows feature...
powershell -command "get-windowsoptionalfeature -online -featurename Client-ProjFS"

IF EXIST "%SYS_PRJFLT%" (
    ECHO [ FOUND ] %SYS_PRJFLT%
) ELSE (
    ECHO [MISSING] %SYS_PRJFLT%
)

IF EXIST "%SYS_PROJFSLIB%" (
    ECHO [ FOUND ] %SYS_PROJFSLIB%
) ELSE (
    ECHO [MISSING] %SYS_PROJFSLIB%
)

IF EXIST "%VFS_PROJFSLIB%" (
    ECHO [ FOUND ] %VFS_PROJFSLIB%
) ELSE (
    ECHO [MISSING] %VFS_PROJFSLIB%
)

IF EXIST "%BND_PRJFLT%" (
    ECHO [ FOUND ] %BND_PRJFLT%
) ELSE (
    ECHO [MISSING] %BND_PRJFLT%
)

IF EXIST "%BND_PROJFSLIB%" (
    ECHO [ FOUND ] %BND_PROJFSLIB%
) ELSE (
    ECHO [MISSING] %BND_PROJFSLIB%
)
