@ECHO off
CLS
ECHO. -----------------------------------------------------------------
ECHO.  Help Build MAP65
ECHO. -----------------------------------------------------------------
ECHO.
ECHO   Usage: build-map65 ^( target ^)
ECHO.
ECHO   There are several targets available for MAP65, the main being
ECHO   [ rinstall ] or [ package]. After checkout-map65, use one of the
ECHO   following:
ECHO.
ECHO   RELEASE TARGETS
ECHO    rconfig ...... Configure Release Tree
ECHO    rinstall ..... Build Release Insatall
ECHO    package ...... Build the Win32 InnoSetup Installer
ECHO.
ECHO   DEBUG TARGETS
ECHO    dconfig ...... Configure Debug Tree
ECHO    dinstall ..... Build Debug Insatall
ECHO. 
ECHO.  NOTES
ECHO   [1] Debug targets ^*do not^* have a package targets
ECHO.
ECHO   ^* Relist Help-Menu, type ..... help-qtenv
ECHO   ^* Return to Main-Menu, type .. main-menu
GOTO EOF

:EOF
EXIT /B 0
