@ECHO off
CLS
ECHO. -----------------------------------------------------------------
ECHO.  Help Build WSJTX Release Candidate
ECHO. -----------------------------------------------------------------
ECHO.
ECHO   Usage: build-wsjtxrc ^( target ^)
ECHO.
ECHO   There are several targets available for WSJTX-RC, the main being
ECHO   [ rinstall ] or [ package]. After checkout-wsjtxrc, use one of the
ECHO   following:
ECHO.
ECHO   RELEASE TARGETS
ECHO    rconfig ...... Configure Release Tree
ECHO    rinstall ..... Build Release Insatall
ECHO    package ...... Build the Win32 NSIS Installer
ECHO. 
ECHO.  NOTES
ECHO   [1] At present, RC builds ^*do not^* include Debug targets
ECHO.
ECHO   ^* Relist Help-Menu, type ..... help-qtenv
ECHO   ^* Return to Main-Menu, type .. main-menu 
GOTO EOF

:EOF
EXIT /B 0
