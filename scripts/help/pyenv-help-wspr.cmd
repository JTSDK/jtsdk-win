@ECHO off
CLS
ECHO. -----------------------------------------------------------------
ECHO.  JTSDK-PY Help
ECHO. -----------------------------------------------------------------
ECHO. 
ECHO.  The following help screens are available:
ECHO. 
ECHO.  COMMAND           Description
ECHO. -----------------------------------------------------------------
ECHO.  help-pyenv ..... Shows this screen
ECHO.  help-checkout .. Help with package checkout
ECHO.  help-wsjt ...... Help with vuilding WSPT
ECHO.  help-wspr ...... Help with building WSPR
ECHO.  main-menu ...... Returns user to main menu
ECHO. 
ECHO.  ^* At the prompt, type .. ^( command ^)
ECHO   ^* Return to Main-Menu, type .. main-menu 
ECHO.
GOTO EOF

:EOF
EXIT /B 0
