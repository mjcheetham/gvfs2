@ECHO OFF
SETLOCAL

IF "%~1" == "" (
	ECHO error: missing version argument
	ECHO.
	GOTO USAGE
)

IF "%~2" == "" (
	ECHO error: missing output argument
	ECHO.
	GOTO USAGE
)

SET VERSION=%~1
SET OUTPUT=%2
SET VERSION_COMMA=%VERSION:.=,%

ECHO #define GVFS_FILE_VERSION %VERSION_COMMA% > %OUTPUT%
ECHO #define GVFS_FILE_VERSION_STRING "%VERSION%" >> %OUTPUT%
ECHO #define GVFS_PRODUCT_VERSION %VERSION_COMMA% >> %OUTPUT%
ECHO #define GVFS_PRODUCT_VERSION_STRING "%VERSION%" >> %OUTPUT%

GOTO EOF

:USAGE
ECHO usage: %~n0%~x0 ^<version^> [^<output^>]
ECHO.
ECHO   version      GVFS version string.
ECHO   output       File path to write version header file.
ECHO.
EXIT 1

:EOF
