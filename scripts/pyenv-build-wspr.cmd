@ECHO OFF
REM  ---------------------------------------------------------------------------
REM  Name .........: pyenv-build-wsjt.cmd
REM  Project ......: Part of the JTSDK v2.0 Project
REM  Description ..: Build WSJT from source
REM  Project URL ..: http://sourceforge.net/projects/wsjt/ 
REM  Usage ........: This file is run from within pyenv.cmd
REM  
REM  Author .......: Greg, Beam, KI7MT, <ki7mt@yahoo.com>
REM  Copyright ....: Copyright (C) 2014-2016 Joe Taylor, K1JT
REM  License ......: GPL-3
REM
REM  pyenv-build-wsjt.cmd is free software: you can redistribute it and/or modify it
REM  under the terms of the GNU General Public License as published by the Free
REM  Software Foundation either version 3 of the License, or (at your option) any
REM  later version. 
REM
REM  pyenv-build-wsjt.cmd is distributed in the hope that it will be useful, but WITHOUT
REM  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
REM  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
REM  details.
REM
REM  You should have received a copy of the GNU General Public License
REM  along with this program.  If not, see <http://www.gnu.org/licenses/>.
REM  ---------------------------------------------------------------------------

CLS
CD /D %based%
SET burl=http://svn.code.sf.net/p/wsjt/wsjt/branches/wspr
SET nopt=wspr
SET separate=No
SET qt55=No
SET quiet-mode=No
SET autosvn=No
SET skipsvn=No
SET clean-first=No
SET autorun=No
SET rcfg=No
SET iss=jtsdk.iss
SET makefile=Makefile.204
GOTO CHECK-OPTIONS

:CHECK-OPTIONS
IF EXIST %cfgd%\separate.txt (
SET separate=Yes
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
IF EXIST %cfgd%\clean.txt (
SET clean-first=Yes
)
IF EXIST %cfgd%\rcfg.txt (
SET rcfg=Yes
)
IF EXIST %cfgd%\autorun.txt (
SET autorun=Yes
)
GOTO TARGETS

:TARGETS
IF /I [%1]==[] (
SET topt=install
GOTO OPTION-STATUS
) ELSE IF /I [%1]==[help] (
CALL %based%\scripts\help\jtsdk-help.cmd wsprhelp
GOTO EOF
) ELSE IF /I [%1]==[-h] (
CALL %based%\scripts\help\jtsdk-help.cmd wsprhelp
GOTO EOF
) ELSE IF /I [%1]==[-o] (
CALL %based%\scripts\help\jtsdk-help.cmd listoptions
GOTO EOF
) ELSE IF /I [%1]==[install] (
SET topt=install
GOTO OPTION-STATUS
) ELSE IF /I [%1]==[package] (
SET topt=package
GOTO OPTION-STATUS
) ELSE IF /I [%1]==[docs] (
SET topt=docs
GOTO OPTION-STATUS
) ELSE IF /I [%1]==[list-targets] (
CALL :LIST-TARGETS
GOTO EOF
) ELSE (
SET topt=%1
GOTO OPTION-STATUS
)

:OPTION-STATUS
ECHO --------------------------------------------
ECHO  Option Status
ECHO --------------------------------------------
IF /I [%quiet-mode%]==[Yes] (
ECHO  ^* JTSDK Option^: Quiet Mode Enabled
ECHO.
GOTO SVN-CHECKOUT
) ELSE (
CALL :LIST-OPTIONS
GOTO SVN-CHECKOUT
)

:SVN-CHECKOUT
IF NOT EXIST %srcd%\wspr\.svn\NUL (
CD /D %srcd%
ECHO.
ECHO --------------------------------------------
ECHO  SVN Checkout
ECHO --------------------------------------------
ECHO.
ECHO  Checking Out New Version of ^( WSPR ^) from SVN
ECHO.
start /wait svn co %burl%
IF ERRORLEVEL 1 ( GOTO SVN-CO-ERROR )
GOTO GET-SVER
) ELSE (
GOTO SVC1
)

:SVC1
IF /I [%skipsvn%]==[Yes] (
GOTO GET-SVER
)
IF /I [%autosvn%]==[Yes] (
GOTO SVN-UPDATE
) ELSE (
GOTO GET-SVER
)

:SVN-UPDATE
CD /D %srcd%\wspr
ECHO.
ECHO --------------------------------------------
ECHO  SVN Update
ECHO --------------------------------------------
ECHO.
ECHO  Updating WSPR from SVN
ECHO.
start /wait svn update
IF ERRORLEVEL 1 ( GOTO SVN-UPDATE-ERROR )
GOTO GET-SVER

:GET-SVER
svn info %srcd%\wspr |grep "Rev:" |awk "{print $4}" >s.v & SET /p sver=<s.v & rm s.v
GOTO GET-AVER

:GET-AVER
cat %srcd%\wspr\wspr.py |grep "Version=" |awk "{print $1}" |tail -c5 >a.v & SET /p aver=<a.v & rm a.v
GOTO SETUP-DIRS

:SETUP-DIRS
IF /I [%separate%]==[Yes] (
SET buildd=%srcd%\wspr
SET installd=%based%\wspr\%aver%\%sver%\install
SET logd=%based%\wspr\%aver%\%sver%\install\Logbook
SET pkgd=%based%\wspr\%aver%\%sver%\package
GOTO MAKE-DIRS
) ELSE (
SET buildd=%srcd%\wspr
SET installd=%based%\wspr\install
SET logd=%based%\wspr\install\Logbook
SET pkgd=%based%\wspr\package
GOTO MAKE-DIRS
)

:MAKE-DIRS
IF /I [%quiet-mode%]==[Yes] (
GOTO MD1
)
CALL :FOLDER-LOCATIONS

:MD1
mkdir %installd% >NUL 2>&1
mkdir %pkgd% >NUL 2>&1
mkdir %logd% >NUL 2>&1
GOTO START-MAIN

:START-MAIN
IF /I [%quiet-mode%]==[Yes] (
GOTO BUILD-SELECT
)
CALL :BUILD-INFORMATION
GOTO BUILD-SELECT

:BUILD-SELECT
IF /I [%topt%]==[install] ( GOTO BUILD-INSTALL )
IF /I [%topt%]==[package] ( GOTO BUILD-PKG )
IF /I [%topt%]==[docs] (
GOTO BUILD-DOCS
) ELSE (
GOTO BUILD-UDT
)

REM  ***************************************************************************
REM  START MAIN SCRIPT --
REM  ***************************************************************************

REM  ------------------------------------------------------------ INSTALL TARGET
:BUILD-INSTALL
CD /D %srcd%\wspr
ECHO --------------------------------------------
ECHO  Build Install Target
ECHO --------------------------------------------
IF /I [%clean-first%]==[Yes] (
CALL :MAKE-CLEAN
GOTO BI1
)
GOTO BI1

:BI1
CALL :MAKE-ALL && CALL :MAKE-INSTALL && CALL :MAKE-CMD && CALL :FINISH-INSTALL
GOTO EOF


REM  ------------------------------------------------------------ PACKAGE TARGET
:BUILD-PKG
CD /D %srcd%\wspr
ECHO --------------------------------------------
ECHO  Build Win32 Installer
ECHO --------------------------------------------
ECHO.
IF /I [%clean-first%]==[Yes] (
CALL :MAKE-CLEAN
GOTO BP1
)
GOTO BP1

:BP1
CALL :MAKE-ISS && CALL :MAKE-ALL && CALL :MAKE-INSTALL && CALL :MAKE-INSTALLER && CALL :FINISH-PKG
GOTO EOF

REM  ---------------------------------------------------------------- USER GUIDE
:BUILD-DOCS
CD /D %srcd%\wspr
ECHO --------------------------------------------
ECHO  Build User Guide
ECHO --------------------------------------------
IF /I [%clean-first%]==[Yes] (
CALL :MAKE-CLEAN
GOTO UG1
)
GOTO UG1

:UG1
CALL :MAKE-DOCS && CALL :FINISH-UG
GOTO EOF


REM  ------------------------------------------------------- USER DEFINED TARGET
:BUILD-UDT
CD /D %srcd%\wspr
ECHO --------------------------------------------
ECHO  User Defined Target ^[ %topt% ^]
ECHO --------------------------------------------
ECHO.
IF /I [%clean-first%]==[Yes] (
CALL :MAKE-CLEAN
GOTO UD1
)
GOTO UD1

:UD1
CALL :MAKE-UDT
GOTO EOF

REM  ***************************************************************************
REM  END OF PYENV-BUILD>BAT
REM  ***************************************************************************
:EOF
CD /D %based%
EXIT /B 0


REM  ***************************************************************************
REM   PROCESS FUNCTIONS
REM  ***************************************************************************
:MAKE-ISS
rm -f %srcd%\wspr\jtsdk.iss >NUL 2>&1
>%srcd%\wspr\jtsdk.iss (
ECHO ; For Use With JTSDK v2
ECHO #define MyAppName "wspr"
ECHO #define MyAppVersion "%aver%-%sver%"
ECHO #define MyAppPublisher "Joe Taylor, K1JT"
ECHO #define MyAppCopyright "Copyright (C) 2001-2016 by Joe Taylor, K1JT"
ECHO #define MyAppURL "http://physics.princeton.edu/pulsar/k1jt/doc/wspr/"
ECHO #define WsjtGroupURL "https://groups.yahoo.com/neo/groups/wsjtgroup/info"
ECHO.
ECHO [Setup]
ECHO AppName={#MyAppName}
ECHO AppVersion={#MyAppVersion}
ECHO AppPublisher={#MyAppPublisher}
ECHO AppPublisherURL={#MyAppURL}
ECHO AppSupportURL={#MyAppURL}
ECHO AppUpdatesURL={#MyAppURL}
ECHO DisableReadyPage=yes
ECHO DefaultDirName=C:\wspr\wspr-{#MyAppVersion}
ECHO DefaultGroupName=wspr
ECHO LicenseFile=C:\JTSDK\common-licenses\GPL-3
ECHO OutputDir=%pkgd%
ECHO OutputBaseFilename={#MyAppName}-{#MyAppVersion}-Win32
ECHO SetupIconFile=C:\JTSDK\icons\wsjt.ico
ECHO Compression=lzma
ECHO SolidCompression=yes
ECHO.
ECHO [Languages]
ECHO Name: "english"; MessagesFile: "compiler:Default.isl"
ECHO.
ECHO [Files]
ECHO Source: "%installd%\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
ECHO.
ECHO [Icons]
ECHO Name: "{group}\{#MyAppName}\Documentation\wspr {#MyAppVersion} User Guide"; Filename: "{app}\wspr-main-{#MyAppVersion}.html"; WorkingDir: {app}; IconFileName: "{app}\wsjt.ico"
ECHO Name: "{group}\{#MyAppName}\Documentation\{cm:ProgramOnTheWeb,{#MyAppName}}"; Filename: "{#MyAppURL}"
ECHO Name: "{group}\{#MyAppName}\Resources\{cm:ProgramOnTheWeb,wspr Group}"; Filename: "{#WsjtGroupURL}"
ECHO Name: "{group}\{#MyAppName}\Uninstall\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"; Comment: "Uninstall wspr";
ECHO Name: "{group}\{#MyAppName}\wspr v10"; Filename: "{app}\wspr.cmd"; WorkingDir: {app}; IconFileName: "{app}\wsjt.ico"
ECHO Name: "{userdesktop}\{#MyAppName}"; Filename: "{app}\wspr.cmd";    WorkingDir: {app}; IconFileName: "{app}\wsjt.ico"
ECHO.
ECHO [Run]
ECHO Filename: "{app}\wspr.cmd"; Description: "Launch wspr v10"; Flags: postinstall nowait unchecked
)
EXIT /B 0

:MAKE-CLEAN
ECHO  ^* JTSDK Option^: Clean Build Tree Enabled
mingw32-make INSTALLDIR=%installd% PACKAGEDIR=%pkgd% LOGBOOKDIR=%logd% -f %makefile% distclean >NUL 2>&1
mkdir %installd% >NUL 2>&1
mkdir %pkgd% >NUL 2>&1
mkdir %logd% >NUL 2>&1
ECHO.
EXIT /B 0

:MAKE-ALL
REM  Build all the rargets
CD /D %srcd%\wspr
mingw32-make INSTALLDIR=%installd% PACKAGEDIR=%pkgd% LOGBOOKDIR=%logd% -f %makefile% all
IF ERRORLEVEL 1 ( GOTO BUILD-ERROR )
EXIT /B 0

:MAKE-CMD
REM  Create the runtime batch file
CD /D %installd%
rm -f wspr.bat >NUL 2>&1
>wspr.bat (
ECHO @ECHO OFF
ECHO REM -- wspr batch File
ECHO REM -- Part of the JTSDK v2.0 Project
ECHO COLOR 0A
ECHO bin\wspr.exe
ECHO EXIT /B 0
)
EXIT /B 0

:MAKE-INSTALL
CD /D %srcd%\wspr
mingw32-make INSTALLDIR=%installd% PACKAGEDIR=%pkgd% LOGBOOKDIR=%logd% -f %makefile% install
IF ERRORLEVEL 1 (
GOTO BUILD-ERROR
GOTO EOF
)
EXIT /B 0

:MAKE-UDT
CD /D %srcd%\wspr
mingw32-make -f %makefile% %topt%
IF ERRORLEVEL 1 (
GOTO BUILD-ERROR
GOTO EOF
) ELSE (
GOTO FINISH-UDT
)
EXIT /B 0

:LIST-TARGETS
CD /D %srcd%\wspr
mingw32-make -f %makefile% list-targets
IF ERRORLEVEL 1 (
GOTO BUILD-ERROR
GOTO EOF
)
EXIT /B 0


:MAKE-INSTALLER
CD /D %srcd%\wspr
mingw32-make INSTALLDIR=%installd% PACKAGEDIR=%pkgd% LOGBOOKDIR=%logd% SRCD=%srcd%\wspr NAME=wspr VER=%aver% SVER=r%sver% OS=win32 ISS=jtsdk.iss -f %makefile% package
IF ERRORLEVEL 1 (
GOTO BUILD-ERROR
GOTO EOF
)
DIR /B %pkgd%\wspr-%aver%-r%sver%*.exe >p.k & SET /P wsprpkg=<p.k & rm p.k
EXIT /B 0

:MAKE-DOCS
CD /D %srcd%\wspr
mingw32-make INSTALLDIR=%installd% PACKAGEDIR=%pkgd% LOGBOOKDIR=%logd% -f %makefile% docs
IF ERRORLEVEL 1 (
GOTO BUILD-ERROR
GOTO EOF
)
DIR /B %srcd%\wspr\doc\*.html >d.n & SET /P docname=<d.n & rm d.n
EXIT /B 0

:LIST-OPTIONS
ECHO  Separate .....^: %separate%
ECHO  Quiet Mode ...^: %quiet-mode%
ECHO  Skip SVN .....^: %skipsvn%
ECHO  Auto SVN .....^: %autosvn%
ECHO  Clean First ..^: %clean-first%
ECHO  Auto run .....^: %autorun%
ECHO.
EXIT /B 0

:FOLDER-LOCATIONS
ECHO --------------------------------------------
ECHO  Folder Locations
ECHO --------------------------------------------
ECHO.
ECHO  Build .......^: %buildd%
ECHO  Install .....^: %installd%
ECHO  Logbook .....^: %logd%
ECHO  Package .....^: %pkgd%
ECHO.
EXIT /B 0

:BUILD-INFORMATION
ECHO --------------------------------------------
ECHO  Build Information
ECHO --------------------------------------------
ECHO.
ECHO  Name ........^: wspr
ECHO  Version .....^: %aver%
ECHO  SVN .........^: r%sver%
ECHO  Target ......^: %topt%
ECHO  SRC .........^: %srcd%\wspr
ECHO  Install .....^: %installd%
ECHO  Logbook .....^: %logd%
ECHO  Package .....^: %pkgd%
ECHO  SVN URL .....^: %burl%
ECHO.
EXIT /B 0


REM  ***************************************************************************
REM   FINISH MESSAGES
REM  ***************************************************************************
:FINISH-INSTALL
ECHO.
ECHO --------------------------------------------
ECHO  Build Summary
ECHO --------------------------------------------
ECHO.
ECHO   Name ..........^: wspr
ECHO   Version .......^: %aver%
ECHO   SVN ...........^: r%sver%
ECHO   Target ........^: %topt%
ECHO   SRC ...........^: %srcd%\wspr
ECHO   Install .......^: %installd%
ECHO   Package .......^: %pkgd%
ECHO   SVN URL .......^: %burl%
GOTO FRUN

:FRUN
IF /I [%autorun%]==[Yes] (
ECHO.
ECHO  JTSDK Option ..: Autorun Enabled
ECHO  Starting ......: wspr %aver% r%sver%
ECHO.
CD /D %installd%
CALL wspr.bat
EXIT /B 0
) ELSE (
EXIT /B 0
)

:FINISH-UG
ECHO.
ECHO --------------------------------------------
ECHO  User Guide Summary
ECHO --------------------------------------------
ECHO.
ECHO   Name ........^: %docname%
ECHO   Version .....^: %aver%
ECHO   SVN .........^: r%sver%
ECHO   Target ......^: %topt%
ECHO   SRC .........^: %srcd%\wspr
ECHO   Location ....^: %srcd%\wspr\doc\%docname%
ECHO   SVN URL .....^: %burl%
ECHO.
ECHO   The user guide does ^*not^* get installed like normal install
ECHO   builds, it remains in the build folder to aid in browser
ECHO   shortcuts for quicker refresh during development iterations. 
ECHO.
ECHO   The name ^[ %docname% ^] also remains constant rather
ECHO   than including the subversion revision number.
ECHO.
EXIT /B 0

:FINISH-PKG
ECHO.
ECHO --------------------------------------------
ECHO  Win32 Installer Summary
ECHO --------------------------------------------
ECHO.
ECHO   Name ........^: %wsprpkg%
ECHO   Version .....^: %aver%
ECHO   SVN .........^: r%sver%
ECHO   Target ......^: %topt%
ECHO   SRC .........^: %srcd%\wspr
ECHO   Location ....^: %pkgd%\%wsprpkg%
ECHO   SVN URL .....^: %burl%
ECHO.
ECHO   To Install the package, browse to Location and
ECHO   run as you normally do to install Windows applications.
ECHO.
EXIT /B 0

:FINISH-UDT
ECHO.
ECHO -----------------------------------------------------------------
ECHO  User Defined Target Summary
ECHO -----------------------------------------------------------------
ECHO.
ECHO   Name ........^: %nopt%
ECHO   Version .....^: %aver%
ECHO   SVN .........^: r%sver%
ECHO   Target ......^: %topt%
ECHO   SRC .........^: %srcd%\wspr
ECHO   Location ....^: %srcd%\wspr\%topt%
ECHO   SVN URL .....^: %burl%
ECHO.
ECHO   User Defined Targets do ^*not^* get installed like normal install
ECHO   builds, they remain in the build folder. 
ECHO.
ECHO   See Location above for build target ^[ %topt% ^]
ECHO.
EXIT /B 0


REM  ***************************************************************************
REM   ERROR MESSAGES
REM  ***************************************************************************
:SVN-CO-ERROR
ECHO --------------------------------------------
ECHO  Sourceforge Checkout Error
ECHO --------------------------------------------
ECHO.
ECHO  ^build-wspr was unable to checkout the
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
ECHO  peoblem presists, contact the wspr-devel list.
ECHO
EXIT /B 0
GOTO EOF

:SVN-UPDATE-ERROR
ECHO --------------------------------------------
ECHO  Sourceforge Update Error
ECHO --------------------------------------------
ECHO.
ECHO  ^build-wspr was unable to update ^[ %nopt% ^]
ECHO  Sourceforge. The service may be down or
ECHO  undergoing maintenance. Check the following
ECHO  link for current site status reports^:
ECHO.
ECHO  http://sourceforge.net/blog/category/sitestatus/
ECHO.
ECHO  If your sure the entry is correct and you suspect
ECHO  a problem with the build script, contact the
ECHO  wspr-devel list for assistance.
ECHO.
EXIT /B 0
GOTO EOF

:BUILD-ERROR
ECHO.
ECHO -----------------------------------------------------------------
ECHO  Compiler Build Warning
ECHO -----------------------------------------------------------------
ECHO. 
ECHO  mingw32-make exited with a non-(0) build status. Check and or 
ECHO  correct the error, perform a clean, then re-make the target.
ECHO.
ECHO  If this was a target build error ^ ( not found ^), list the
ECHO  available targets by typing^: build-wspr list-targets
ECHO.

EXIT /B %ERRORLEVEL%