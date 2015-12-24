@ECHO off
CLS
ECHO. -----------------------------------------------------------------
ECHO.  JTSDK-QT Help
ECHO. -----------------------------------------------------------------
ECHO. 
ECHO.  The following help screens are available:
ECHO. 
ECHO.  COMMAND           Description
ECHO. -----------------------------------------------------------------
ECHO.  help-qtenv .....: Shows this screen
ECHO.  help-checkout ..: Help with package checkout
ECHO.  help-wsjt ......: Help with building WSJT-X 
ECHO.  help-wsjtexp....: Help with building WSJTX (exp)
ECHO.  help-wsjt ......: Help with building WSJTX (devel)
ECHO.  help-wsjtrc ....: Help with building WSJTX (release candidates)
ECHO.  help-wsprx .....: Help with building WSPR-X
ECHO.  help-map65 .....: Help with building MAP65
ECHO.  main-menu ......: Returns user to main menu
ECHO. 
ECHO.  ^* At the prompt, type ........: ^( command ^)
ECHO   ^* Return to Main-Menu, type ..: main-menu 
ECHO.
GOTO EOF

:EOF
EXIT /B 0
