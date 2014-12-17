@ECHO off
CLS
ECHO. -----------------------------------------------------------------
ECHO.  Help Build WSJT
ECHO. -----------------------------------------------------------------
ECHO.
ECHO   Usage: build-wsjt ^( target ^)
ECHO.
ECHO   There are several targets available for WSJT, the main being
ECHO   [ install ] or [ package]. After checkout-wsjt, use one of the
ECHO   following:
ECHO.
ECHO   libjt ...... WSJT Library
ECHO   jt65code ... JT65 code test app
ECHO   jt4code .... JT4 code test app
ECHO   Audio.pyd .. Audio Library for WSJT
ECHO   install .... Build and Install WSJT
ECHO   package .... Build Win32 Installer
ECHO   clean ...... Clean SRC directory
ECHO   distclean .. Clean SRC, Install and Package Directories
ECHO. 
ECHO   ^* Relist Help-Menu, type ..... help-pyenv
ECHO   ^* Return to Main-Menu, type .. main-menu
GOTO EOF

:EOF
EXIT /B 0
