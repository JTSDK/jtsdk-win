@ECHO OFF
REM ----------------------------------------------------------------------------
REM  Name .........: qtenv.cmd
REM  Function .....: JTSDK QT5 Environment for Win32
REM  Project ......: Part of the JTSDK v2.0 Project
REM  Description ..: Sets the Environment for building WSJT-X, WSPR-X and MAP65
REM  Project URL ..: http://sourceforge.net/projects/jtsdk 
REM  Usage ........: Windows Start, run C:\JTSDK\qtenv.cmd
REM
REM  Author .......: Greg, Beam, KI7MT, <ki7mt@yahoo.com>
REM  Copyright ....: Copyright (C) 2014-2016 Joe Taylor, K1JT
REM  License ......: GPL-3
REM
REM  qtenv.cmd is free software: you can redistribute it and/or modify it under the
REM  terms of the GNU General Public License as published by the Free Software
REM  Foundation either version 3 of the License, or (at your option) any later
REM  version. 
REM
REM  qtenv.cmd is distributed in the hope that it will be useful, but WITHOUT ANY
REM  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
REM  A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
REM
REM  You should have received a copy of the GNU General Public License
REM  along with this program.  If not, see <http://www.gnu.org/licenses/>.
REM  ---------------------------------------------------------------------------

:: Windows commands and Variables are in CAPS
:: User Defined variables are lower case like %based%

:: ENVIRONMENT
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
COLOR 0B
SET LANG=en_US
SET env-name=JTSDK-QT

SET /P version=<version.jtsdk
SET based=C:\JTSDK
SET tools=%based%\tools\bin
SET svnd=%based%\subversion\bin
SET PATH=%based%;%tools%;%svnd%;%WINDIR%\System32
%svnd%\svn.exe info |%tools%\grep.exe "Rev:" |%tools%\awk.exe "{print $4}" >r.v & set /p rev=<r.v & %tools%\rm.exe r.v
SET version=%version% %rev%
ECHO.
IF EXIST %based%\config\qt55.txt (
SET PROMPT=$CJTSDK-QT 5.5 $F $P$F
SET title-string=JTSDK QT 5.5 Development Environment - %version%
) ELSE (
SET PROMPT=$CJTSDK-QT 5.2 $F $P$F
SET title-string=JTSDK QT 5.2 Development Environment - %version%
)
TITLE %title-string%


:: PATH VARIABLES
SET cfgd=%based%\config
SET cmk=%based%\cmake\bin
SET fft=%based%\fftw3f
SET nsi=%based%\nsis
SET ino=%based%\inno5
SET ruby=%based%\Ruby\bin
SET scr=%based%\scripts
SET srcd=%based%\src
SET svnd=%based%\subversion\bin
:: Optional enable / Disable use of QT55 for testing
:: *DO NOT EDIT MANYALLY*
IF EXIST %based%\config\qt55.txt (
SET gccd=%based%\qt55\Tools\mingw492_32\bin
SET qt5d=%based%\qt55\5.5\mingw492_32\bin
SET qt5p=%based%\qt55\5.5\mingw492_32\plugins\platforms
SET qt5a=
SET LIBRARY_PATH=
) ELSE (
SET gccd=%based%\qt5\Tools\mingw48_32\bin
SET qt5d=%based%\qt5\5.2.1\mingw48_32\bin
SET qt5a=%based%\qt5\5.2.1\mingw48_32\plugins\accessible
SET qt5p=%based%\qt5\5.2.1\mingw48_32\plugins\platforms
SET LIBRARY_PATH=
SET hl3=%based%\hamlib3\bin;%based%\hamlib3\include\hamlib;%based%\hamlib3\lib
)
SET PATH=%based%;%cfgd%;%cmk%;%tools%;%hl3%;%py27%;%fft%;%gccd%;%qt5d%;%qt5a%;%qt5p%;%nsi%;%ino%;%ruby%;%srcd%;%scr%;%srcd%;%svnd%;%WINDIR%;%WINDIR%\System32

REM  ---------------------------------------------------------------------------
REM   USER DEFINABLE ALIAS COMMANDS ( add what you like here )
REM  ---------------------------------------------------------------------------
DOSKEY clear=CLS
DOSKEY ss="svn.exe" $* status
DOSKEY sv="svn.exe" $* status ^|grep "?"
DOSKEY sa="svn.exe" $* status ^|grep "A"
DOSKEY sm="svn.exe" $* status ^|grep "M"
DOSKEY sd="svn.exe" $* status ^|grep "D"
DOSKEY log="svn.exe" log -l $*
DOSKEY logr="svn.exe" log -r $*
DOSKEY logv="svn.exe" log -v -l $*
DOSKEY logvr="svn.exe" log -v -r $*
DOSKEY edit="%tools%\Sc351.exe" $1


REM  ***************************************************************************
REM                    DO NOT EDIT BELOW THIS LINE
REM  ***************************************************************************

REM  ---------------------------------------------------------------------------
REM   SETUP DIRECTORIES
REM  ---------------------------------------------------------------------------
CD /D %based%
IF NOT EXIST %srcd%\NUL ( mkdir %based%\src )
IF NOT EXIST %cfgd%\NUL ( mkdir %based%\config )

REM  ---------------------------------------------------------------------------
REM   CHECK FOR ORIGINAL QT55 ENABLE FILE
REM  ---------------------------------------------------------------------------
IF EXIST qt55-enabled.txt (
touch C:\JTSDK\config\qt55.txt
rm qt55-enabled.txt
)

REM  ---------------------------------------------------------------------------
REM   CHECKOUT COPMMANDS
REM  ---------------------------------------------------------------------------
DOSKEY checkout-wsprx="%scr%\svn-checkout.cmd" $* wsprx
DOSKEY checkout-map65="%scr%\svn-checkout.cmd" $* map65
DOSKEY checkout-wsjtx="%scr%\svn-checkout.cmd" $* wsjtx
DOSKEY checkout-wsjtxexp="%scr%\svn-checkout.cmd" $* wsjtxexp
DOSKEY checkout-wsjtxrc="%scr%\svn-checkout.cmd" $* wsjtxrc

REM  ---------------------------------------------------------------------------
REM   BUILD COMMANDS
REM  ---------------------------------------------------------------------------
DOSKEY build-wsprx="%scr%\qtenv-build-wsprx.cmd" $* wsprx
DOSKEY build-map65="%scr%\qtenv-build-map65.cmd" $* map65
DOSKEY build-wsjtx="%scr%\qtenv-build-wsjtx.cmd" $*
DOSKEY wsjtx-list="%based%\scripts\qtenv-build-list.cmd" $*

REM  ---------------------------------------------------------------------------
REM   HELP PAGES
REM  ---------------------------------------------------------------------------
DOSKEY main-menu=CD ^/D %based% ^&CALL %scr%\qtenv-info.cmd
DOSKEY list-options="%scr%\help\jtsdk-help.cmd" $* listoptions
DOSKEY help-list="%scr%\help\jtsdk-help.cmd" $* helplist
DOSKEY help-qtenv="%scr%\help\jtsdk-help.cmd" $* qtmain
DOSKEY help-wsprx="%scr%\help\jtsdk-help.cmd" $* wsprxhelp
DOSKEY help-map65="%scr%\help\jtsdk-help.cmd" $* map65help
DOSKEY help-wsjtx="%scr%\qtenv-build-wsjtx.cmd" $* help
DOSKEY help-checkout="%scr%\svn-checkout.cmd" $* qtcohelp



REM  ---------------------------------------------------------------------------
REM   USER CONFIGURABLE OPTIONS
REM  ---------------------------------------------------------------------------
:: ENABLE / DISABLE Qt5.5
DOSKEY enable-qt55="touch.exe" C:\JTSDK\config\qt55.txt
DOSKEY disable-qt55="rm.exe" -f C:\JTSDK\config\qt55.txt

:: ENABLE / DISABLE Separation 
DOSKEY enable-separate="touch.exe" C:\JTSDK\config\separate.txt
DOSKEY disable-separate="rm.exe" -f C:\JTSDK\config\separate.txt

:: ENABLE / DISABLE Extra Screen Messages ( Quiet Mode )
DOSKEY enable-quiet="touch.exe" C:\JTSDK\config\quiet.txt
DOSKEY disable-quiet="rm.exe" -f C:\JTSDK\config\quiet.txt

:: ENABLE / DISABLE Auto Yes to SVN Update
DOSKEY enable-autosvn="touch.exe" C:\JTSDK\config\autosvn.txt
DOSKEY disable-autosvn="rm.exe" -f C:\JTSDK\config\autosvn.txt

:: ENABLE / DISABLE Skip Ask to update from SVN
DOSKEY enable-skipsvn="touch.exe" C:\JTSDK\config\skipsvn.txt
DOSKEY disable-skipsvn="rm.exe" -f C:\JTSDK\config\skipsvn.txt

:: ENABLE / DISABLE Clean Build Tree
DOSKEY enable-clean="touch.exe" C:\JTSDK\config\clean.txt
DOSKEY disable-clean="rm.exe" -f C:\JTSDK\config\clean.txt

:: ENABLE / DISABLE Reconfiguring the build tree
DOSKEY enable-rcfg="touch.exe" C:\JTSDK\config\rcfg.txt
DOSKEY disable-rcfg="rm.exe" -f C:\JTSDK\config\rcfg.txt

:: ENABLE / DISABLE Auto run the build when asked
DOSKEY enable-autorun="touch.exe" C:\JTSDK\config\autorun.txt
DOSKEY disable-autorun="rm.exe" -f C:\JTSDK\config\autorun.txt

REM  ---------------------------------------------------------------------------
REM   CALL MAIN SCREEN SCRIPT
REM  ---------------------------------------------------------------------------
CALL %scr%\qtenv-info.cmd
GOTO EOF

:: LAUNCH CMD WINDOW
:EOF
%WINDIR%\System32\cmd.exe /A /Q /K

