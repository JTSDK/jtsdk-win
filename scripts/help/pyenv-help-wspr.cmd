@ECHO off
CLS
ECHO. -----------------------------------------------------------------
ECHO.  Help Build WSPR
ECHO. -----------------------------------------------------------------
ECHO.
ECHO   Usage: build-wspr ^( target ^)
ECHO.
ECHO   There are several targets available for WSPR, the main being
ECHO   [ install ] or [ package]. After checkout-wspr, use one of the
ECHO   following:
ECHO.
ECHO.  Target        Description
ECHO. -----------------------------------------------------------------
ECHO   libwspr ....: WPSR Library
ECHO   fmtest .....: FMTest App
ECHO   fmtave .....: Ave app for FMTest
ECHO   fcal .......: Cal app for FMTest
ECHO   fmeasure ...: Measure app for FMTest
ECHO   gmtime2 ....: Compile gmtime2.c
ECHO   sound ......: Compile sound.c
ECHO   WSPRcode ...: WSPR code testing App
ECHO   wspr0 ......: Command Line WSPR
ECHO   w.pyd ......: Audio Library for WSPR
ECHO   install ....: Build and Install WSPR
ECHO   package ....: Build Win32 Installer
ECHO   clean ......: Clean SRC directory
ECHO   distclean ..: Clean SRC, Install and Package Directories
ECHO. 
ECHO   ^* Relist Help-Menu, type .....: help-pyenv
ECHO   ^* Return to Main-Menu, type ..: main-menu
GOTO EOF

:EOF
EXIT /B 0
