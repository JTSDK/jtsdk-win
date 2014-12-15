@ECHO off
CLS
ECHO. -----------------------------------------------------------------
ECHO.  Help Build WSPR
ECHO. -----------------------------------------------------------------
ECHO.
ECHO   Usage: build-wspr ^( target ^)
ECHO
ECHO   There are several targets available for WSPR, the main being
ECHO   [ install ] or [ package]. After checkout-wspr, use one of the
ECHO   following:
ECHO.
ECHO   libwspr.a  ..... WPSR Library
ECHO   fmtest.exe ..... FMTest App
ECHO   fmtave.exe ..... Ave app for FMTest
ECHO   fcal.exe ....... Cal app for FMTest
ECHO   fmeasure.exe ... Measure app for FMTest
ECHO   gmtime2.o ...... Compile gmtime2.c
ECHO   sound.o ........ Compile sound.c
ECHO   WSPRcode.exe ... WSPR code testing App
ECHO   wspr0.exe  ..... Command Line WSPR
ECHO   WsprMod/w.pyd .. Audio Library for WSPR
ECHO   install ........ Build and Install WSPR
ECHO   package ........ Build Win32 Installer
ECHO. 
ECHO   ^* Return to Main-Menu, type .. main-menu 
GOTO EOF

:EOF
EXIT /B 0
