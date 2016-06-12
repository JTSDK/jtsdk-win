@ECHO OFF
REM ----------------------------------------------------------------------------
REM  Name .........: jtsdk-help.cmd
REM  Function .....: Provides a unified file for general help messages
REM  Project ......: Part of the JTSDK v2.0 Project
REM  Description ..: JTSDK QT and QY help messages
REM  Project URL ..: http://sourceforge.net/projects/jtsdk 
REM  Usage ........: Called from various JTSDK scripts
REM
REM  Author .......: Greg, Beam, KI7MT, <ki7mt@yahoo.com>
REM  Copyright ....: Copyright (C) 2014-2016 Joe Taylor, K1JT
REM  License ......: GPL-3
REM
REM  jtsdk-help.cmd is free software: you can redistribute it and/or modify it under the
REM  terms of the GNU General Public License as published by the Free Software
REM  Foundation either version 3 of the License, or (at your option) any later
REM  version. 
REM
REM  jtsdk-help.cmd is distributed in the hope that it will be useful, but WITHOUT ANY
REM  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
REM  A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
REM
REM  You should have received a copy of the GNU General Public License
REM  along with this program.  If not, see <http://www.gnu.org/licenses/>.
REM  ---------------------------------------------------------------------------

IF /I [%1]==[listoptions] ( GOTO LIST-OPTIONS )
IF /I [%1]==[helplist] ( GOTO HELP-LIST )
IF /I [%1]==[pymain] ( GOTO PY-MAIN-HELP )
IF /I [%1]==[wsjthelp] ( GOTO WSJT-HELP )
IF /I [%1]==[wsprhelp] ( GOTO WSPR-HELP )
IF /I [%1]==[qtmain] ( GOTO QT-MAIN-HELP )
IF /I [%1]==[map65help] ( GOTO MAP65-HELP )
IF /I [%1]==[wsprxhelp] ( GOTO WSPRX-HELP ) ELSE ( GOTO MISSING )

:PY-MAIN-HELP
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
ECHO.  help-pyenv .....^: Shows this screen
ECHO.  help-checkout ..^: Help with package checkout
ECHO.  help-wsjt ......^: Help with building WSJT
ECHO.  help-wspr ......^: Help with building WSPR
ECHO.  main-menu ......^: Returns user to main menu
ECHO   list-options ...^: Lists all user defined options
ECHO. 
ECHO   ^* Relist Help-Menu, type .....^: help-pyenv
ECHO   ^* Help List, type ............^: help-list
ECHO   ^* Return to Main-Menu, type ..^: main-menu 
ECHO.
GOTO EOF

:WSJT-HELP
CLS
ECHO. -----------------------------------------------------------------
ECHO.  WSJT Build Help
ECHO. -----------------------------------------------------------------
ECHO.
ECHO   Usage: build-wsjt ^( target ^)
ECHO.
ECHO   There are several targets available for WSJT, the main being
ECHO   [ install ] or [ package]. Use one of the following:
ECHO.
ECHO.  Target        Description
ECHO. -----------------------------------------------------------------
ECHO   libjt.a ....^: WSJT Library
ECHO   jt65code ...^: JT65 code test app
ECHO   jt4code ....^: JT4 code test app
ECHO   Audio.pyd ..^: Audio Library for WSJT
ECHO   install ....^: Build and Install WSJT
ECHO   package ....^: Build Win32 Installer
ECHO   docs .......^: Build User Guide
ECHO   clean ......^: Clean SRC directory
ECHO   distclean ..^: Clean SRC, Install and Package Directories
ECHO. 
ECHO   ^* Relist Help-Menu, type .....^: help-wsjt
ECHO   ^* Help List, type ............^: help-list
ECHO   ^* Return to Main-Menu, type ..^: main-menu
GOTO EOF

:WSPR-HELP
CLS
ECHO. -----------------------------------------------------------------
ECHO.  WSPR Build Help
ECHO. -----------------------------------------------------------------
ECHO.
ECHO   Usage: build-wspr ^( target ^)
ECHO.
ECHO   There are several targets available for WSPR, the main being
ECHO   ^[ install ^] or ^[ package ^]. Use one of the following:
ECHO.
ECHO.  Target        Description
ECHO. -----------------------------------------------------------------
ECHO   libwspr ....^: WPSR Library
ECHO   fmtest .....^: FMTest App
ECHO   fmtave .....^: Ave app for FMTest
ECHO   fcal .......^: Cal app for FMTest
ECHO   fmeasure ...^: Measure app for FMTest
ECHO   gmtime2 ....^: Compile gmtime2.c
ECHO   sound ......^: Compile sound.c
ECHO   WSPRcode ...^: WSPR code testing App
ECHO   wspr0 ......^: Command Line WSPR
ECHO   w.pyd ......^: Audio Library for WSPR
ECHO   install ....^: Build and Install WSPR
ECHO   package ....^: Build Win32 Installer
ECHO   clean ......^: Clean SRC directory
ECHO   distclean ..^: Clean SRC, Install and Package Directories
ECHO. 
ECHO   ^* Relist Help-Menu, type .....^: help-wspr
ECHO   ^* Return to Main-Menu, type ..^: main-menu
GOTO EOF

:QT-MAIN-HELP
CLS
ECHO. -----------------------------------------------------------------
ECHO.  JTSDK-QT Help
ECHO. -----------------------------------------------------------------
ECHO. 
ECHO.  The following help screens are available:
ECHO. 
ECHO.  COMMAND           Description
ECHO. -----------------------------------------------------------------
ECHO.  help-qtenv .....^: Shows this screen
ECHO.  help-checkout ..^: Help with branch checkouts
ECHO.  help-wsprx .....^: Help with building WSPR-X
ECHO.  help-map65 .....^: Help with building MAP65
ECHO.  help-wsjtx .....^: Help with building WSJTX
ECHO   wsjtx-list .....^: Help with WSJT-X Menu Lists
ECHO   list-options ...^: Lists all user defines options
ECHO. 
ECHO   ^* Relist Help-Menu, type .....^: help-qtenv
ECHO   ^* Help List, type ............^: help-list
ECHO   ^* Return to Main-Menu, type ..^: main-menu 
ECHO.
GOTO EOF

:MAP65-HELP
CLS
ECHO. -----------------------------------------------------------------
ECHO.  MAP65 Build Help
ECHO. -----------------------------------------------------------------
ECHO.
ECHO   Usage: build-map65 ^( target ^)
ECHO.
ECHO   There are several targets available for MAP65, the main being
ECHO   ^[ rinstall ^] or ^[ package ^]. After checkout-map65, use one of the
ECHO   following:
ECHO.
ECHO   RELEASE TARGETS
ECHO    rconfig ...^: Configure Release Tree
ECHO    rinstall ..^: Build Release Install
ECHO    package ...^: Build Win32 Installer
ECHO.
ECHO   DEBUG TARGETS
ECHO    dconfig ...^: Configure Debug Tree
ECHO    dinstall ..^: Build Debug Insatall
ECHO. 
ECHO.  NOTES
ECHO   ^[1^] Debug targets ^*do not^* have a package targets
ECHO.
ECHO   ^* Relist Help-Menu, type .....^: help-map65
ECHO   ^* Return to Main-Menu, type ..^: main-menu
GOTO EOF

:WSPRX-HELP
CLS
ECHO. -----------------------------------------------------------------
ECHO.  WSPR-X Build Help
ECHO. -----------------------------------------------------------------
ECHO.
ECHO   Usage: build-wsprx ^( target ^)
ECHO.
ECHO   There are several targets available for WSPRX, the main being
ECHO   ^[ rinstall ^] or ^[ package ^]. After checkout-wsprx, use one of the
ECHO   following:
ECHO.
ECHO   RELEASE TARGETS
ECHO    rconfig ...^: Configure Release Tree
ECHO    rinstall ..^: Build Release Insatall
ECHO    package ...^: Build the Win32 InnoSetup Installer
ECHO.
ECHO   DEBUG TARGETS
ECHO    dconfig ...^: Configure Debug Tree
ECHO    dinstall ..^: Build Debug Insatall
ECHO. 
ECHO.  NOTES
ECHO   ^[1^] Debug targets ^*do not^* have a package targets
ECHO.
ECHO   ^* Relist Help-Menu, type .....^: help-wsprx
ECHO   ^* Return to Main-Menu, type ..^: main-menu 
GOTO EOF

:MISSING
CLS
ECHO. -----------------------------------------------------------------
ECHO.  MISSING HELP SCREEN
ECHO. -----------------------------------------------------------------
ECHO.
ECHO  The help screen ^[ %1 ^] is either missing or cannot be read.
ECHO  Check the spelling to ensure is is spelled correctly. If you
ECHO  sure it is corect, report this issue to the development list.
ECHO.
ECHO   ^* All Help Lists .............^: help-list
ECHO   ^* Return to Main-Menu, type ..^: main-menu
ECHO.
GOTO EOF

:HELP-LIST
CLS
ECHO -----------------------------------------------------------------
ECHO  %env-name% HELP SCREENS
ECHO -----------------------------------------------------------------
ECHO.

IF /I [%env-name%]==[JTSDK-PY] (
ECHO  JTSDK-PY Main ..^: help-pyenv
ECHO  WSJT ...........^: help-wsjt
ECHO  WSPR ...........^: help-wspr
)
IF /I [%env-name%]==[JTSDK-QT] (
ECHO  JTSDK-QT Main ..^: help-qtenv
ECHO  WSJT-X .........^: help-wsjtx
ECHO  WSPR-X .........^: help-wsprx
ECHO  MAP65 ..........^: help-map65
ECHO  MAP65 ..........^: wsjtx-list ^-h
)
ECHO.
ECHO  ^* Checkout Help, Type.........^: help-checkout
ECHO  ^* List Options , Type ........^: list-options
ECHO  ^* All Help Lists, Type .......^: help-list
ECHO  ^* Return to Main-Menu, type ..^: main-menu
GOTO EOF


:LIST-OPTIONS
IF EXIST %cfgd%\qt55.txt (
SET qt55=Yes
SET qtv=qt55
) ELSE (
SET qtv=qt52
SET qt55=No
)

IF EXIST %cfgd%\separate.txt ( 
SET separate=Yes
) ELSE (
SET separate=No
)

IF EXIST %cfgd%\quiet.txt (
SET quiet-mode=Yes
) ELSE (
SET quiet-mode=No
)

IF EXIST %cfgd%\autosvn.txt (
SET autosvn=Yes
) ELSE (
SET autosvn=No
)

IF EXIST %cfgd%\skipsvn.txt (
SET skipsvn=Yes
) ELSE (
SET skipsvn=No
)

IF EXIST %cfgd%\clean.txt (
SET clean-first=Yes
) ELSE (
SET clean-first=No
)

IF EXIST %cfgd%\rcfg.txt (
SET rcfg=Yes
) ELSE (
SET rcfg=No
)

IF EXIST %cfgd%\autorun.txt (
SET autorun=Yes
) ELSE (
SET autorun=No
)

CLS
ECHO --------------------------------------------
ECHO  JTSDK OPTION STATUS
ECHO --------------------------------------------
ECHO.
ECHO  USAGE ..^: enable-^[NAME^] or disable-^[NAME^]
IF /I [%env-name%]==[JTSDK-QT] (
ECHO  NAME ...^: separate qt55 quiet skipsvn autosvn clean rcfg autorun
) ELSE (
ECHO  NAME ...^: separate quiet skipsvn autosvn clean autorun
)
ECHO.
ECHO  CURRENT STATUS
ECHO   Separate .....^: %separate%
ECHO   Quiet Mode ...^: %quiet-mode%
ECHO   Skip SVN .....^: %skipsvn%
ECHO   Auto SVN .....^: %autosvn%
ECHO   Clean First ..^: %clean-first%
ECHO   Auto run .....^: %autorun%
IF /I [%env-name%]==[JTSDK-QT] (
ECHO   Reconfigure ..^: %rcfg%
ECHO   Use QT5.5 ....^: %qt55%
)
ECHO.
ECHO  DESCRIPTION
ECHO   ^separate .....^: Separate by App Version ^+ SVN Version
ECHO   ^quiet ........^: Enable or Disable additional on screen messages
ECHO   ^skipsvn ......^: If Enabled, dont ask and dont update from SVN
ECHO   ^autosvn ......^: If Enabled, perform the SVN update without asking
IF /I [%env-name%]==[JTSDK-QT] (
ECHO   ^clean ........^: Clean the build tree before cmake --build .
) ELSE (
ECHO   ^clean ........^: Clean the build tree before mingw32-make ^$*
)
ECHO   ^autorun ......^: Run the build without asking
IF /I [%env-name%]==[JTSDK-QT] (
ECHO   ^rcfg .........^: Re-run cmake configure
ECHO   ^qt55 .........^: Enable or Disable using QT5.5 Tool Chain
ECHO.
ECHO  When QT55 is enabled or disabled, you ^*Must^* restart JTSDK-QT
ECHO  before the change can take affect.
)
ECHO.
ECHO  ^* To Display this message, type ..^:  list-options
ECHO  ^* Return to Main Menu, Type ......^:  main-menu 
ECHO.
GOTO EOF

:EOF
popd
EXIT /B 0