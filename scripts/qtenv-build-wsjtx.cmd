@ECHO OFF
REM  ---------------------------------------------------------------------------
REM  Name .........: qtenv-build-wsjtx.cmd
REM  Project ......: Part of the JTSDK 2.0 Project
REM  Description ..: Build script for WSJTX
REM  Project URL ..: http://sourceforge.net/projects/wsjt/
REM  Usage ........: This file is run from within qtenv.cmd
REM
REM  Author .......: Greg, Beam, KI7MT, <ki7mt@yahoo.com>
REM  Copyright ....: Copyright (C) 2014-2016 Joe Taylor, K1JT
REM  License ......: GPL-3
REM
REM  qtenv-build-wsjtx.cmd is free software: you can redistribute it and/or
REM  modify it under the terms of the GNU General Public License as published
REM  by the Free Software Foundation either version 3 of the License, or
REM  (at your option) any later version.
REM
REM  qtenv-build-wsjtx.cmd is distributed in the hope that it will be useful,
REM  but WITHOUT ANY WARRANTY; without even the implied warranty of
REM  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General
REM  Public License for more details.
REM
REM  You should have received a copy of the GNU General Public License
REM  along with this program.  If not, see <http://www.gnu.org/licenses/>.
REM ----------------------------------------------------------------------------

CLS
SET devurl=http://svn.code.sf.net/p/wsjt/wsjt/branches
SET garurl=http://svn.code.sf.net/p/wsjt/wsjt/tags
SET baseurl=http://svn.code.sf.net/p/wsjt/wsjt
SET devlist=%cfgd%\devlist.txt
SET garlist=%cfgd%\garlist.txt
SET timestamp=%cfgd%\list-update-time-stamp
SET separate=No
SET qt55=No
SET quiet-mode=No
SET autosvn=No
SET skipsvn=No
SET JJ=%NUMBER_OF_PROCESSORS%
GOTO CHECK-OPTIONS

:CHECK-OPTIONS
IF EXIST %cfgd%\qt55-enabled.txt ( 
SET tchain=c:/JTSDK/scripts/wsjtx-toolchain-qt55.cmake
) ELSE (
SET tchain=c:/JTSDK/scripts/wsjtx-toolchain.cmake
)
IF EXIST %cfgd%\separate.txt (
SET separate=Yes
)
IF EXIST %cfgd%\qt55.txt (
SET qt55=Yes
SET qtv=qt55
) ELSE (
SET qtv=qt52
)
IF EXIST %cfgd%\quiet.txt (
SET quiet-mode=Yes
)
IF EXIST %cfgd%\autosvn.txt (
SET autosvn=Yes
)
IF EXIST %cfgd%\skipsvn.txt (
SET skipsvn=Yes
)
GOTO START

:START
IF /I [%1]==[help] (
GOTO HELP-OPTIONS
) ELSE IF /I [%1]==[-h] (
GOTO HELP-OPTIONS
) ELSE IF /I [%1]==[-o] (
GOTO GLOBAL-OPTIONS
) ELSE IF /I [%1]==[rconfig] (
SET bopt=dev
SET nopt=wsjtx
SET copt=Release
SET topt=config
SET folder=devel
SET burl=%baseurl%/branches
GOTO SVN-CHECKOUT
) ELSE IF /I [%1]==[dconfig] (
SET bopt=dev
SET nopt=wsjtx
SET copt=Debug
SET topt=config
SET folder=devel
SET burl=%baseurl%/branches
GOTO SVN-CHECKOUT
) ELSE IF /I [%1]==[rinstall] (
SET bopt=dev
SET nopt=wsjtx
SET copt=Release
SET topt=install
SET folder=devel
SET burl=%baseurl%/branches
GOTO SVN-CHECKOUT
) ELSE IF /I [%1]==[dinstall] (
SET bopt=dev
SET nopt=wsjtx
SET copt=Debug
SET topt=install
SET folder=devel
SET burl=%baseurl%/branches
GOTO SVN-CHECKOUT
) ELSE IF /I [%1]==[package] (
SET bopt=dev
SET nopt=wsjtx
SET copt=Release
SET topt=package
SET folder=devel
SET burl=%baseurl%/branches
GOTO SVN-CHECKOUT
) ELSE IF /I [%1]==[docs] (
SET bopt=dev
SET nopt=wsjtx
SET copt=Release
SET topt=docs
SET folder=devel
SET burl=%baseurl%/branches
GOTO SVN-CHECKOUT
) ELSE ( GOTO LIST-CHECK )

:LIST-CHECK
IF NOT EXIST %devlist% (
SET missing=devlist.txt
GOTO MISSING-LIST
)
IF NOT EXIST %garlist% (
SET missing=garlist.txt
GOTO MISSING-LIST
)
IF NOT EXIST %timestamp% (
SET missing=Update Time Stamp
GOTO MISSING-LIST
)
GOTO ARG-CHECK

:ARG-CHECK
SET /A argcount = 0
FOR %%A IN (%*) DO SET /A argcount += 1
IF %argcount%==8 (
GOTO CUSTOM-PROCSSING
) ELSE (
GOTO MISSING-OPTIONS
)
GOTO EOF

:CUSTOM-PROCSSING
ECHO --------------------------------------------
ECHO  CUSTOM BUILD REQUESTED
ECHO --------------------------------------------
ECHO.
ECHO  Command ..^: build-wsjtx %*
GOTO BOPT

:BOPT
IF /I "%1"=="-b" (
SET bopt=%2
IF /I "%2"=="dev" (
SET burl=%baseurl%/branches
SET checklist=%devlist%
SET folder=devel
) ELSE IF /I "%2"=="gar" (
SET burl=%baseurl%/tags
SET checklist=%garlist%
SET folder=garc
) ELSE ( GOTO CLI-INVALID-OPTION )
SHIFT & SHIFT
)
GOTO NOPT

:NOPT
IF /I "%1"=="-n" (
SET nopt=%2
SHIFT & SHIFT
)
IF /I [%bopt%]==[dev] (
IF /I [%nopt%]==[wsjtx] ( GOTO COPT )
IF /I [%nopt%]==[wsjtx_exp] ( GOTO COPT )
)
grep -Fx "%nopt%" < %checklist% >NUL
IF ERRORLEVEL 1 ( GOTO CLI-BRANCH-NAME-ERROR )
GOTO COPT

:COPT
IF /I "%1"=="-c" (
IF /I "%2"=="release" (
SET copt=Release
) ELSE IF /I "%2"=="debug" (
SET copt=Debug
) ELSE ( GOTO CLI-INVALID-OPTION )
SHIFT & SHIFT
)
GOTO TOPT

:TOPT
IF /I "%1"=="-t" (
IF "%2"=="rconfig" (
SET topt=config
SHIFT & SHIFT
GOTO OPTION-RESULTS
)
IF "%2"=="dconfig" (
SET topt=config
SHIFT & SHIFT
GOTO OPTION-RESULTS
)
IF "%2"=="rinstall" (
SET topt=install
SHIFT & SHIFT
GOTO OPTION-RESULTS
)
IF "%2"=="dinstall" (
SET topt=install
SHIFT & SHIFT
GOTO OPTION-RESULTS
) ELSE (
SET topt=%2
SHIFT & SHIFT
)
) ELSE ( GOTO CLI-INVALID-OPTION )
GOTO OPTION-RESULTS

:OPTION-RESULTS
ECHO  URL ......^: %burl%/%nopt%
ECHO  Name .....^: %nopt%
ECHO  Type .....^: %copt%
ECHO  Target ...^: %topt%
ECHO.
GOTO SVN-CHECKOUT

:SVN-CHECKOUT
ECHO.
ECHO --------------------------------------------
ECHO  SVN Check
ECHO --------------------------------------------
ECHO.
IF NOT EXIST %srcd%\%nopt%\.svn\NUL (
CD /D %srcd%
ECHO  Checking Out New Version ^( %nopt% ^) from SVN
ECHO.
start /wait svn co %burl%/%nopt%
IF ERRORLEVEL 1 ( GOTO SVN_CHECKOUT-ERROR )
GOTO GET-SVER
) ELSE ( GOTO ASK-SVN-UPDATE )

:ASK-SVN-UPDATE
IF /I [%skipsvn%]==[Yes] (
ECHO JTSDK Option: - Skip SVN Update Enabled
ECHO.
GOTO GET-SVER
)
IF /I [%autosvn%]==[Yes] (
ECHO JTSDK Option: - Auto SVN Update Enabled
ECHO.
GOTO SVN-UPDATE
)
ECHO Update from SVN Before Building? ^( y/n ^)
SET answer=
ECHO.
SET /P answer=Type Response: %=%
If /I [%answer%]==[n] (
ECHO.
GOTO GET-SVER )
If /I [%answer%]==[y] (
ECHO.
GOTO SVN-UPDATE
) ELSE (
ECHO.
ECHO  Please Answer With: ^( y or n ^)
ECHO.
GOTO ASK-SVN-UPDATE
)

:SVN-UPDATE
CD /D %srcd%\%nopt%
start /wait svn update
IF ERRORLEVEL 1 ( GOTO SVN-UPDATE-ERROR )
GOTO GET-SVER

:GET-SVER
svn info %srcd%\%nopt% |grep "Rev:" |awk "{print $4}" >s.v & SET /p sver=<s.v & rm s.v
GOTO GET-AVER

:GET-AVER
SET vfile="%srcd%\%nopt%\Versions.cmake"
cat %vfile% |grep "_MAJOR" |awk "{print $3}" |cut "-c1" >ma.v & SET /p mav=<ma.v & rm ma.v
cat %vfile% |grep "_MINOR" |awk "{print $3}" |cut "-c1" >mi.v & SET /p miv=<mi.v & rm mi.v
cat %vfile% |grep "_PATCH" |awk "{print $3}" |cut "-c1" >pa.v & SET /p pav=<pa.v & rm pa.v
cat %vfile% |grep "_RC" |awk "{print $3}" |cut "-c1" >rcx.v & SET /p rcx=<rcx.v & rm rcx.v
cat %vfile% |grep "_RELEASE" |awk "{print $3}" |cut "-c1" >rel.v & SET /p relx=<rel.v & rm rel.v
IF [%relx%]==[1] (
SET aver=%mav%.%miv%.%pav%
SET desc=GA Release
)
IF %rcx% GTR 0 (
IF [%relx%]==[1] (
SET aver=%mav%.%miv%.%pav%
SET desc=GA Release
)
)
IF [%rcx%]==[0] (
IF [%relx%]==[0] (
SET aver=%mav%.%miv%.%pav%
SET desc=devel
)
)
IF %rcx% GTR 0 (
IF [%relx%]==[0] (
SET aver=%mav%.%miv%.%pav%
SET desc=Release Candidate
)
)
GOTO SETUP-DIRS


:SETUP-DIRS
ECHO --------------------------------------------
ECHO  Folder Locations
ECHO --------------------------------------------
ECHO.
IF /I [%separate%]==[No] (
ECHO  JTSDK Option^: - Folder Separation Disabled
SET buildd=%based%\wsjtx\%folder%\%qtv%\%aver%\%copt%\build
SET installd=%based%\wsjtx\%folder%\%qtv%\%aver%\%copt%\install
SET pkgd=%based%\wsjtx\%folder%\%qtv%\%aver%\%copt%\package
IF /I [%qt55%]==[Yes] (
ECHO  JTSDK Option^: - QT55 Enabled
SET buildd=%based%\wsjtx\%folder%\%qtv%\%aver%\%copt%\build
SET installd=%based%\wsjtx\%folder%\%qtv%\%aver%\%copt%\install
SET pkgd=%based%\wsjtx\%folder%\%qtv%\%aver%\%copt%\package
) ELSE (
ECHO  JTSDK Option^: - QT55 Disabled
)
GOTO CREATE-DIRS
)
IF /I [%separate%]==[Yes] (
ECHO  JTSDK Option^: - Folder Separation Enabled
SET buildd=%based%\wsjtx\%folder%\%qtv%\%aver%\%sver%\%copt%\build
SET installd=%based%\wsjtx\%folder%\%qtv%\%aver%\%sver%\%copt%\install
SET pkgd=%based%\wsjtx\%folder%\%qtv%\%aver%\%sver%\%copt%\package
IF /I [%qt55%]==[Yes] (
ECHO  JTSDK Option^: - QT55 Enabled
SET buildd=%based%\wsjtx\%folder%\%qtv%\%aver%\%sver%\%copt%\build
SET installd=%based%\wsjtx\%folder%\%qtv%\%aver%\%sver%\%copt%\install
SET pkgd=%based%\wsjtx\%folder%\%qtv%\%aver%\%sver%\%copt%\package
) ELSE (
ECHO  JTSDK Option^: - QT55 Disabled
)
GOTO CREATE-DIRS
)
GOTO EOF

:CREATE-DIRS
IF /I [%quiet-mode%]==[Yes] (
ECHO  JTSDK Option: - Quit Mode Enabled
ECHO.
GOTO CREATE-DIRS-1
)
ECHO.
ECHO  Build .......^: %buildd%
ECHO  Install .....^: %installd%
ECHO  Package .....^: %pkgd%
ECHO.

:CREATE-DIRS-1
SET appsrc=%srcd%\%nopt%
mkdir %buildd% >NUL 2>&1
mkdir %installd% >NUL 2>&1
mkdir %pkgd% >NUL 2>&1
GOTO START-MAIN

:START-MAIN

ECHO --------------------------------------------
ECHO  Build Information
ECHO --------------------------------------------
ECHO.
IF /I [%quiet-mode%]==[Yes] (
ECHO  JTSDK Option: - Quit Mode Enabled
GOTO BUILD-SELECT
)
ECHO  Name ........^: %nopt% %desc%
ECHO  Version .....^: %aver%
ECHO  SVN .........^: r%sver%
ECHO  Type ........^: %copt%
ECHO  Target ......^: %topt%
ECHO  Tool Chain ..^: %qtv%
ECHO  SRC .........^: %srcd%\%nopt%
ECHO  Build .......^: %buildd%
ECHO  Install .....^: %installd%
ECHO  Package .....^: %pkgd%
ECHO  SVN URL .....^: %burl%/%nopt%
ECHO  TC File .....^: %tchain%
ECHO.
GOTO BUILD-SELECT

:BUILD-SELECT
IF /I [%topt%]==[config] ( GOTO CONFIG-ONLY )
IF /I [%topt%]==[install] ( GOTO INSTALL-TARGET )
IF /I [%topt%]==[package] ( GOTO PKG-TARGET )
IF /I [%topt%]==[docs] (
GOTO DOCS-TARGET
) ELSE (
GOTO UD-TARGET
)
GOTO EOF

REM  --------------------------------------------------------------- CONFIG-ONLY
:CONFIG-ONLY
CD /D %buildd%
ECHO.
ECHO --------------------------------------------
ECHO  Configuring Build Tree
ECHO --------------------------------------------
ECHO.
cmake -G "MinGW Makefiles" -Wno-dev -D CMAKE_TOOLCHAIN_FILE=%tchain% ^
-D CMAKE_COLOR_MAKEFILE=OFF ^
-D WSJT_INCLUDE_KVASD=OFF ^
-D CMAKE_BUILD_TYPE=%copt% ^
-D CMAKE_INSTALL_PREFIX=%installd% %appsrc%
IF ERRORLEVEL 1 ( GOTO ERROR-CMAKE )
GOTO FINISH-CONFIG
GOTO EOF


REM  ---------------------------------------------------------------- USER GUIDE
:DOCS-TARGET
CD /D %buildd%
ECHO.
ECHO --------------------------------------------
ECHO  Building User Guide
ECHO --------------------------------------------
ECHO.
IF NOT EXIST Makefile (
cmake -G "MinGW Makefiles" -Wno-dev -D CMAKE_TOOLCHAIN_FILE=%tchain% ^
-D CMAKE_BUILD_TYPE=%copt% ^
-D CMAKE_INSTALL_PREFIX=%installd% %appsrc%
IF ERRORLEVEL 1 ( GOTO ERROR-CMAKE )
)
cmake --build . --target docs
IF ERRORLEVEL 1 ( GOTO ERROR-CMAKE )
DIR /B %buildd%\doc\*.html >d.n & SET /P docname=<d.n & rm d.n
GOTO FINISH-UG

REM  ------------------------------------------------------------ INSTALL-TARGET
:INSTALL-TARGET
CD /D %buildd%
ECHO.
ECHO --------------------------------------------
ECHO  Building Install Target
ECHO --------------------------------------------
ECHO.
cmake -G "MinGW Makefiles" -Wno-dev -D CMAKE_TOOLCHAIN_FILE=%tchain% ^
-D CMAKE_BUILD_TYPE=%copt% ^
-D CMAKE_INSTALL_PREFIX=%installd% %appsrc%
IF ERRORLEVEL 1 ( GOTO ERROR-CMAKE )
cmake --build . --target %topt% -- -j %JJ%
IF ERRORLEVEL 1 ( GOTO ERROR-CMAKE )
GOTO FINISH-INSTALL


REM  ------------------------------------------------------------------- PACKAGE
:PKG-TARGET
CD /D %buildd%
ECHO.
ECHO --------------------------------------------
ECHO  Building Win32 Installer
ECHO --------------------------------------------
ECHO.
cmake -G "MinGW Makefiles" -Wno-dev -D CMAKE_TOOLCHAIN_FILE=%tchain% ^
-D CMAKE_BUILD_TYPE=%copt% ^
-D CMAKE_INSTALL_PREFIX=%pkgd% %appsrc%
IF ERRORLEVEL 1 ( GOTO ERROR-CMAKE )
cmake --build . --target %topt% -- -j %JJ%
IF ERRORLEVEL 1 ( GOTO NSIS-ERROR )
DIR /B %buildd%\*-win32.exe >p.k & SET /P wsjtxpkg=<p.k & rm p.k
ECHO JTSDK^: ^- Copying package to^: %pkgd%
COPY /Y %buildd%\%wsjtxpkg% %pkgd% > NUL
GOTO FINISH-PKG

REM  --------------------------------------------------------USER-DEFINED-TARGET
:UD-TARGET
CD /D %buildd%
ECHO.
ECHO --------------------------------------------
ECHO  Building User Defined Target ^ [ %topt% ^]
ECHO --------------------------------------------
ECHO.
cmake -G "MinGW Makefiles" -Wno-dev -D CMAKE_TOOLCHAIN_FILE=%tchain% ^
-D CMAKE_BUILD_TYPE=%copt% ^
-D CMAKE_INSTALL_PREFIX=%installd% %appsrc%
IF ERRORLEVEL 1 ( GOTO ERROR-CMAKE )
cmake --build . --target %topt% -- -j %JJ%
IF ERRORLEVEL 1 ( GOTO ERROR-CMAKE )
GOTO FINISH-UD

REM  ***************************************************************************
REM   FINISH MESSAGES
REM  ***************************************************************************
:FINISH-INSTALL
ECHO.
ECHO --------------------------------------------
ECHO  Build Summary
ECHO --------------------------------------------
ECHO.
ECHO   Name ........^: %nopt% %desc%
ECHO   Version .....^: %aver%
ECHO   SVN .........^: r%sver%
ECHO   Type ........^: %copt%
ECHO   Target ......^: %topt%
ECHO   Tool Chain ..^: %qtv%
ECHO   SRC .........^: %srcd%\%nopt%
ECHO   Location ....^: %buildd%\%topt%
ECHO   SVN URL .....^: %burl%/%nopt%
ECHO.
GOTO EOF

:FINISH-CONFIG
ECHO.
ECHO --------------------------------------------
ECHO  Configure Summary
ECHO --------------------------------------------
ECHO.
ECHO   Name ........^: %nopt% %desc%
ECHO   Version .....^: %aver%
ECHO   SVN .........^: r%sver%
ECHO   Type ........^: %copt%
ECHO   Target ......^: %topt%
ECHO   Tool Chain ..^: %qtv%
ECHO   SRC .........^: %srcd%\%nopt%
ECHO   Location ....^: %buildd%
ECHO   SVN URL .....^: %burl%/%nopt%
ECHO.
ECHO   Config Only builds simply configure the build tree with
ECHO   default options. To further configure or re-configure this build,
ECHO   run the following commands:
ECHO.
ECHO   cd %buildd%
ECHO   cmake-gui .
ECHO   Once the CMake-GUI opens, click on Generate, then Configure
ECHO.
ECHO   You now have have a fully configured build tree. If you make 
ECHO   changes be sure click on Generate and Configure again.
ECHO.
ECHO   To return to the main menu, type: main-menu
ECHO.
GOTO EOF

:FINISH-UG
ECHO.
ECHO --------------------------------------------
ECHO  User Guide Summary
ECHO --------------------------------------------
ECHO.
ECHO   Name ........^: %docname%
ECHO   Version .....^: %aver%
ECHO   SVN .........^: r%sver%
ECHO   Type ........^: %copt%
ECHO   Target ......^: %topt%
ECHO   Tool Chain ..^: %qtv%
ECHO   SRC .........^: %srcd%\%nopt%
ECHO   Build .......^: %buildd%
ECHO   Location ....^: %buildd%\doc\%docname%
ECHO   SVN URL .....^: %burl%/%nopt%
ECHO.
ECHO   The user guide does ^*not^* get installed like normal install
ECHO   builds, it remains in the build folder to aid in browser
ECHO   shortcuts for quicker refresh during development iterations. 
ECHO.
ECHO   The name ^[ %docname% ^] also remains constant rather
ECHO   than including the version infomation.
ECHO.
GOTO EOF

:FINISH-PKG
ECHO.
ECHO --------------------------------------------
ECHO  Win32 Installer Summary
ECHO --------------------------------------------
ECHO.
ECHO   Name ........^: %wsjtxpkg%
ECHO   Version .....^: %aver%
ECHO   SVN .........^: r%sver%
ECHO   Type ........^: %copt%
ECHO   Target ......^: %topt%
ECHO   Tool Chain ..^: %qtv%
ECHO   SRC .........^: %srcd%\%nopt%
ECHO   Build .......^: %buildd%
ECHO   Location ....^: %pkgd%\%wsjtxpkg%
ECHO   SVN URL .....^: %burl%/%nopt%
ECHO.
ECHO   To Install the package, browse to Location and
ECHO   run as you normally do to install Windows applications.
ECHO.
GOTO EOF

:FINISH-UD
ECHO.
ECHO -----------------------------------------------------------------
ECHO  User Defined Target Summary
ECHO -----------------------------------------------------------------
ECHO.
ECHO   Name ........^: %nopt%
ECHO   Version .....^: %aver%
ECHO   SVN .........^: r%sver%
ECHO   Type ........^: %copt%
ECHO   Target ......^: %topt%
ECHO   Tool Chain ..^: %qtv%
ECHO   SRC .........^: %srcd%\%nopt%
ECHO   Location ....^: %buildd%\%topt%
ECHO   SVN URL .....^: %burl%/%nopt%
ECHO.
ECHO   Custom Targets do ^*not^* get installed like normal install
ECHO   builds, they remain in the build folder. 
ECHO.
ECHO   See Location above for build target ^[ %topt% ^]
ECHO.
GOTO EOF

REM  ***************************************************************************
REM   HELP MESSAGES
REM  ***************************************************************************
:HELP-OPTIONS
CLS
ECHO --------------------------------------------
ECHO  DEFAULT BUILD COMMANDS
ECHO --------------------------------------------
ECHO.
ECHO  Usage .....^: build-wsjtx ^[ OPTION ^]
ECHO  Example....^: build-wsjtx rinstall
ECHO.
ECHO  OPTIONS:
ECHO     rconfig    WSJTX Devel, Release, Config Only
ECHO     dconfig    WSJTX Devel, Debug, Config Only
ECHO     rinstall   WSJTX Devel, Release, Install
ECHO     dinstall   WSJTX Devel, Debug, Install
ECHO     package    WSJTX Devel, Release, Package
ECHO     docs       WSJTX Devel, Release, User Guide
ECHO.
ECHO --------------------------------------------
ECHO  COMMAND LINE OPTIONS
ECHO --------------------------------------------
ECHO.
ECHO  Usage .....^: build-wsjtx ^[-h^] ^[-b^] ^[-n^] ^[-c^] ^[-t^]  
ECHO  Example....^: build-wsjtx ^-b dev ^-n wsjtx ^-c release ^-t install
ECHO.
ECHO  OPTIONS:
ECHO     ^-h   Displays this message
ECHO     ^-b   ^( dev ^| gar ^)
ECHO          dev ^= development branches ^^/branches
ECHO          gar ^= GA and RC branches ^^/tags
ECHO     ^-n   Branch Name^: wsjtx, wsjtx-1.6, wsjtx-1.6.0-rc1, etc
ECHO     ^-c   Cmake Build Type^: ^( release ^| debug ^)
ECHO     ^-t  install package docs ^| user-defined
ECHO.
ECHO  Use ^: wsjtx-list ^-a  to list available branch names
ECHO.
GOTO EOF

:GLOBAL-OPTIONS
ECHO --------------------------------------------
ECHO  GLOBAL OPTION STATUS
ECHO --------------------------------------------
ECHO.
ECHO  Separate ....^: %separate%
ECHO  Quiet Mode ..^: %quiet-mode%
ECHO  Auto SVN ....^: %skipsvn%
ECHO  Auto SVN ....^: %autosvn%
ECHO  Use QT5.5 ...^: %qt55%
ECHO.
ECHO  USAGE ..^: enable-^[NAME^] or disable-^[NAME^]
ECHO  NAME ...^: separate qt55 quiet skipsvn autosvn
ECHO.
ECHO  DESCRIPTION
ECHO   separate ...^: Separate by App Version ^+ SVN Version
ECHO   quiet ......^: Enable or Disable Additional on Screen messages
ECHO   skipsvn ....^: If Enabled, dont ask and dont update from SVN
ECHO   autosvn ....^: If Enabled, perform the SVN update without asking
ECHO   qt55 .......^: Enable or Disable using QT5.5 as the Tool Chain
ECHO.
ECHO  When QT55 is enabled or disabled, you ^*Must^* restart JTSDK-QT
ECHO  before the change can take affect.
ECHO.
ECHO  To disply this message, type:  build-wsjtx ^-o
ECHO.
GOTO EOF

REM  ***************************************************************************
REM   ERROR MESSAGES
REM  ***************************************************************************
:ERROR-CMAKE
ECHO.
ECHO --------------------------------------------
ECHO  CMAKE BUILD ERROR
ECHO --------------------------------------------
ECHO.
ECHO  There was a problem building ^( %nopt% %desc% ^)
ECHO.
ECHO  Check the screen for error messages, correct, then try to
ECHO  re-build ^( %nopt%  %desc% %copt% %topt% ^)
ECHO.
ECHO.
GOTO EOF

:NSIS-ERROR
ECHO.
ECHO --------------------------------------------
ECHO  Win32 INSTALLER BUILD ERROR
ECHO --------------------------------------------
ECHO.
ECHO  There was a problem building the package, or the script
ECHO  could not find:
ECHO.
ECHO  %buildd%\%WSJTXPKG%
ECHO.
ECHO  Check the Cmake logs for any errors, or correct any build
ECHO  script issues that were obverved and try to rebuild the package.
ECHO.
GOTO EOF

:MISSING-LIST
CLS
ECHO --------------------------------------------
ECHO  Missing [ %missing% ]
ECHO --------------------------------------------
ECHO.
ECHO  ^[ %missing% ^] is either missing or could
ECHO  not be opened.
ECHO.
ECHO  To correct this, run the following command^:
ECHO.
ECHO  wsjtx-list ^-u
ECHO.
ECHO  If the problem presists after updating,
ECHO  contact the development list.
ECHO.
GOTO EOF

:MISSING-OPTIONS
CLS
ECHO --------------------------------------------
ECHO  MISSING COMMAND LINE OPTION
ECHO --------------------------------------------
ECHO.
ECHO  Option Count Error ^- ^[ %argcount% ^]
ECHO.
ECHO  The WSJTX build script requires at least ^[ 1 ^]
ECHO  argument for defualt builds and ^[ 8 ^] for
ECHO  custom command line builds, you supplied ^[ %argcount% ^]
ECHO.
ECHO  Press any key to display the help message ... 
ECHO.
PAUSE>NUL
GOTO HELP-OPTIONS

:CLI-INVALID-OPTION
ECHO.
ECHO  Invalid Option ^- ^[ %1 %2 ^]
ECHO.
ECHO  Please correct the command line options
ECHO  and try again.
ECHO.
ECHO  Press any key to display the help message ... 
PAUSE>NUL
GOTO HELP-OPTIONS

:CLI-BRANCH-NAME-ERROR
ECHO.
ECHO  Invalid Branch Name ^- ^[ %nopt% ^]
ECHO.
ECHO  %nopt% was not found in the the wsjtx
ECHO  build lists.
ECHO.
ECHO  If you believe the brach is valid, try updating
ECHO  the lists with: wsjtx-list ^-u
ECHO.
ECHO  Press any key to view the branch list for ^[ ^-n %bopt% ^]
PAUSE>NUL
IF /I [%bopt%]==[dev] (
call %scr%\qtenv-build-list.cmd -d
) ELSE (
call %scr%\qtenv-build-list.cmd -g
)
GOTO EOF

:SVN-CO-ERROR
ECHO --------------------------------------------
ECHO  Sourceforge Checkout Error
ECHO --------------------------------------------
ECHO.
ECHO  ^build-wsjtx was unable to checkout the
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

:SVN-UPDATE-ERROR
ECHO --------------------------------------------
ECHO  Sourceforge Update Error
ECHO --------------------------------------------
ECHO.
ECHO  ^build-wsjtx was unable to update ^[ %nopt% ^]
ECHO  Sourceforge. The service may be down or
ECHO  undergoing maintenance. Check the following
ECHO  link for current site status reports^:
ECHO.
ECHO  http://sourceforge.net/blog/category/sitestatus/
ECHO.
ECHO  If your sure the entry is correct and you suspect
ECHO  a problem with the build script, contact the
ECHO  wsjt-devel list for assistance.
ECHO.
GOTO EOF

REM  ***************************************************************************
REM  END QTENV-BUILD-WSJTX.CMD
REM  ***************************************************************************
:EOF
CD /D %based%
COLOR 0B

EXIT /B 0
