::-----------------------------------------------------------------------------::
:: Name .........: svn-checkout.cmd
:: Project ......: Part of the JTSDK v2.0 Project
:: Description ..: Batch file to checkout WSPRX, MAP65, WSPR and WSJT
:: Project URL ..: http://sourceforge.net/projects/wsjt/ 
:: Usage ........: This file is run from within qtenv.cmd
:: 
:: Author .......: Greg, Beam, KI7MT, <ki7mt@yahoo.com>
:: Copyright ....: Copyright (C) 2014-2016 Joe Taylor, K1JT
:: License ......: GPL-3
::
:: svn-checkout.cmd is free software: you can redistribute it and/or modify it
:: under the terms of the GNU General Public License as published by the Free
:: Software Foundation either version 3 of the License, or (at your option) any
:: later version. 
::
:: qtenv-checkout.cmd is distributed in the hope that it will be useful, but WITHOUT
:: ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
:: FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
:: details.
::
:: You should have received a copy of the GNU General Public License
:: along with this program.  If not, see <http://www.gnu.org/licenses/>.
::-----------------------------------------------------------------------------::

SETLOCAL
IF /I [%1]==[qtcohelp] ( GOTO QT-CO-HELP )
IF /I [%1]==[pycohelp] ( GOTO PY-CO-HELP )
IF /I [%1]==[wsjtxrc] ( GOTO WSJTX-MSG )
IF /I [%1]==[wsjtxexp] ( GOTO WSJTX-MSG )
IF /I [%1]==[wsjtx] ( GOTO WSJTX-MSG )

IF /I [%1]==[wsprx] (
SET display_name=WSPRX
SET courl=https://svn.code.sf.net/p/wsjt/wsjt/branches/wsprx
GOTO SVN-CO
)
IF /I [%1]==[map65] (
SET display_name=MAP65
SET courl=https://svn.code.sf.net/p/wsjt/wsjt/branches/map65
GOTO SVN-CO
)
IF /I [%1]==[wspr] (
SET display_name=WSPR
SET courl=https://svn.code.sf.net/p/wsjt/wsjt/branches/wspr
GOTO SVN-CO
)
IF /I [%1]==[WSJT] (
SET display_name=WSJT
SET courl=https://svn.code.sf.net/p/wsjt/wsjt/trunk
GOTO SVN-CO
) ELSE (
GOTO UNSUPPORTED
)
GOTO EOF

:SVN-CO
CD /D %srcd%
CLS
ECHO.
ECHO -----------------------------------------------------------------
ECHO Checking Out ^( %display_name% ^) From SVN
ECHO -----------------------------------------------------------------
start /wait svn checkout %courl%
IF ERRORLEVEL 1 ( GOTO SVN-CO-ERROR )
GOTO FINISH

:FINISH
ECHO.
ECHO Checkout complete.
ECHO.
IF /I [%1]==[wsprx] (
ECHO To Build, Type ...........^: build-wsprx
ECHO For build options, type ..^: help-wsprx
GOTO EOF
)
IF /I [%1]==[map65] (
ECHO To Build, Type ...........^: build-map65
ECHO For build options, type ..^: help-map65
GOTO EOF
)
IF /I [%1]==[wspr] (
ECHO To Build, Type ...........^: build-wspr
ECHO For build options, type ..^: help-wspr
GOTO EOF
)
IF /I [%1]==[wsjt] (
ECHO To Build, Type ...........^: build-wsjt
ECHO For build options, type ..^: help-wsjt
GOTO EOF
)

:QT-CO-HELP
CLS
ECHO. -----------------------------------------------------------------
ECHO.  JTSDK-QT Help Checkout
ECHO. -----------------------------------------------------------------
ECHO. 
ECHO.  To Checkout ^( WSPRX or MAP65 ^)
ECHO    Type ..^: checkout-wsprx
ECHO    Type ..^: checkout-map65
ECHO. 
ECHO   NOTE^: WSJT-X branch checkouts are no longer required
ECHO.
ECHO   DEVELOPER CHECK-IN INFORMATION
ECHO    If you are a developer with the WSJT Dev Group, you
ECHO    *do not* have to perform dev checkout in order to
ECHO    CHECK-IN commits, simply prefix your commit with your
ECHO    SourceForge User Name:
ECHO.
ECHO    EXAMPLE:
ECHO    cd /d C:\JTSDK\src\map65
ECHO    ^( make your edits ^)
ECHO    svn --username=^<SF User Name^> commit -m ^"Commit Message^"
ECHO.
ECHO   ^* List Help-Menu, type .......: help-qtenv
ECHO   ^* Return to Main-Menu, type ..: main-menu 
GOTO EOF

:PY-CO-HELP
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
ECHO   ^* Relist Help-Menu, type .....: help-pyenv
ECHO   ^* Return to Main-Menu, type ..: main-menu
GOTO EOF

:WSJTX-MSG
CLS
ECHO.
ECHO --------------------------------------------
ECHO  No Longer Required
ECHO --------------------------------------------
ECHO.
ECHO  You no longer need to checkout %1 before
ECHO  building. The checkouts are done automatically
ECHO  as part of the build process.
ECHO.
ECHO  To see the list of available branch that JTSDK
ECHO  can build, type^: wsjtx-list -a
ECHO.
ECHO  Press any key for WSJT-X build options ...
PAUSE>NUL
CALL %scr%\qtenv-build-wsjtx.cmd -h
GOTO EOF

:UNSUPPORTED
CLS
ECHO.
ECHO --------------------------------------------
ECHO  Unsupported Branch
ECHO --------------------------------------------
ECHO.
ECHO  %1 is an unsupported branch. Choose one of
ECHO  the following branches
ECHO.
ECHO  USAGE ......^: checkout-[NAME]
ECHO  NAMES ......^: map65 wsprx wsjt wspr
ECHO.
GOTO EOF

:SVN-CO-ERROR
ECHO --------------------------------------------
ECHO  Sourceforge Checkout Error
ECHO --------------------------------------------
ECHO.
ECHO  svn-checkout was unable to checkout the
ECHO  branch form Sourceforge. The service
ECHO  may be down or undergoing maintenance.
ECHO  Check the following link for current site
ECHO  status reports^:
ECHO.
ECHO  http://sourceforge.net/blog/category/sitestatus/
ECHO.
ECHO  Other types of errors such as non-existan branchs
ECHO  or tags may alos be the casue.
ECHO.
ECHO  Verify your entry and try again later. If the
ECHO  peoblem presists, contact the wsjt-devel list.
ECHO
GOTO EOF

:: END OF QTENV-CO.BAT
:EOF
ENDLOCAL
popd

EXIT /B 0
