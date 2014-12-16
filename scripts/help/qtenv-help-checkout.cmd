@ECHO off
CLS
ECHO. -----------------------------------------------------------------
ECHO.  JTSDK-QT Help Checkout
ECHO. -----------------------------------------------------------------
ECHO. 
ECHO.  To Checkout ^( WSJTX, WSJTXRC, WSPRX or MAP65 ^)
ECHO    Type ..: checkout-wsjtx
ECHO    Type ..: checkout-wsjtxrc
ECHO    Type ..: checkout-wsprx
ECHO    Type ..: checkout-map65
ECHO. 
ECHO   DEVELOPER CHECK-IN INFORMATION
ECHO    If you are a developer with the WSJT Dev Group, you
ECHO    *do not* have to perform dev checkout in order to
ECHO    CHECK-IN commits, simply prefix your commit with your
ECHO    SourceForge User Name:
ECHO.
ECHO    EXAMPLE:
ECHO    cd /d C:\JTSDK\src\wsjtx
ECHO    ^( make your edits ^)
ECHO    svn --username=^<SF User Name^> commit -m ^"Commit Message^"
ECHO.
ECHO    DEV-HINT
ECHO    To automate your SF Username prefix, add the following
ECHO    shortcut to C:\JTSDK\qtenv.cmd
ECHO.
ECHO    DOSKEY commit=^"%svnd%\svn.exe^" --username=^<SF Username^> commit $^*
ECHO.
ECHO    Then simply use: commit -m "Commit Message"
ECHO.
ECHO.
ECHO   ^* Return To The Main-Menu, type .. main-menu 
GOTO EOF

:EOF
EXIT /B 0
