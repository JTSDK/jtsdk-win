﻿@ECHO off
CLS
ECHO. -----------------------------------------------------------------
ECHO.  JTSDK-PY Help Checkout
ECHO. -----------------------------------------------------------------
ECHO. 
ECHO.  To Checkout Either ^( WSJT or WSPR ^)
ECHO    Type ..: checkout-wsjt
ECHO    Type ..: checkout-wspr
ECHO. 
ECHO   DEVELOPER CHECK-IN INFORMATION
ECHO    If you are a developer with the WSJT Dev Group, you
ECHO    *do not* have to perform dev checkout in order to
ECHO    CHECK-IN commits, simply prefix your commit with your
ECHO    SourceForge User Name:
ECHO.
ECHO    EXAMPLE:
ECHO    cd /d C:\JTSDK\src\trunk
ECHO    ^( make your edits ^)
ECHO    svn --username=^<SF User Name^> commit -m ^"Commit Message^"
ECHO.
ECHO    DEV-HINT
ECHO    To automate your SF Username prefix, add the following
ECHO    shortcut to C:\JTSDK\pyenv.cmd
ECHO.
ECHO    DOSKEY commit=^"%svnd%\svn.exe^" --username=^<SF Username^> commit $^*
ECHO.
ECHO    Then type ..: commit -m "Commit Message"
ECHO.
ECHO.
ECHO   ^* Relist Help-Menu, type .....: help-pyenv
ECHO   ^* Return to Main-Menu, type ..: main-menu
GOTO EOF

:EOF
EXIT /B 0