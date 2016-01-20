::-----------------------------------------------------------------------------::
:: Name .........: pyenv.cmd
:: Function .....: JTSDK Python Environment for Win32
:: Project ......: Part of the JTSDK v2.0.0 Project
:: Description ..: Sets the Environment for building WSJT and WSPR
:: Project URL ..: http://sourceforge.net/projects/jtsdk 
:: Usage ........: Windows Start, run C:\JTSDK\pyenv.cmd
:: 
:: Author .......: Greg, Beam, KI7MT, <ki7mt@yahoo.com>
:: Copyright ....: Copyright (C) 2014-2015 Joe Taylor, K1JT
:: License ......: GPL-3
::
:: pyenv.cmd is free software: you can redistribute it and/or modify it under the
:: terms of the GNU General Public License as published by the Free Software
:: Foundation either version 3 of the License, or (at your option) any later
:: version. 
::
:: pyenv.cam is distributed in the hope that it will be useful, but WITHOUT ANY
:: WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
:: A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
::
:: You should have received a copy of the GNU General Public License
:: along with this program.  If not, see <http://www.gnu.org/licenses/>.
::-----------------------------------------------------------------------------::

:: Windows commands and Variables are in CAPS
:: User Defined variables are lower case like %based%

:: ENVIRONMENT
@ECHO OFF
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
COLOR 0A
SET LANG=en_US
SET env-name=JTSDK-PY

SET /P version=<version.jtsdk
SET based=C:\JTSDK
SET tools=%based%\tools\bin
SET svnd=%based%\subversion\bin
SET PATH=%based%;%tools%;%svnd%;%WINDIR%\System32
%svnd%\svn.exe info |%tools%\grep.exe "Rev:" |%tools%\awk.exe "{print $4}" >r.v & set /p rev=<r.v & %tools%\rm.exe r.v
SET version=%version% %rev%
SET title-string=JTSDK Python Development Environment - %version%
TITLE %title-string%
SET PROMPT=$CJTSDK-PY 3.3 $F $P$F

:: PATH VARIABLES
SET cfgd=%based%\config
SET mgw=%based%\mingw32\bin
SET inno=%based%\inno5
SET ruby=%based%\Ruby\bin
SET scr=%based%\scripts
REM  SET python2path=%based%\python27;%based%\python27\Scripts;%based%\python27\DLLs
SET python3path=%based%\Python33;%based%\python33\Scripts;%based%\python33\DLLs
SET svnd=%based%\subversion\bin
SET srcd=%based%\src
SET LIBRARY_PATH=
SET PATH=%based%;%python2path%;%python3path%;%MGW%;%cfgd%;%tools%;%innno%;%ruby%;%scr%;%srcd%;%svnd%;%WINDIR%\System32

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
REM  DOSKEY python2="C:\JTSDK\python27\python.exe" $*
DOSKEY python3="C:\JTSDK\python33\python.exe" $*

REM  ***************************************************************************
REM                    DO NOT EDIT BELOW THIS LINE
REM  ***************************************************************************

CD /D %based%

:: MAKE SURE SRCD IS PRESENT
IF NOT EXIST %srcd%\NUL ( mkdir %based%\src )

:: RE-SET FILE ASSOCIATIONS
SET PATHEXT=.COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC

REM  ---------------------------------------------------------------------------
REM   CHECKOUT and BUILD COMMANDS - ( users *should not* edit these )
REM  ---------------------------------------------------------------------------
DOSKEY checkout-wspr="%based%\scripts\svn-checkout.cmd" $* wspr
DOSKEY checkout-wsjt="%based%\scripts\svn-checkout.cmd" $* wsjt
DOSKEY build-wspr="%scr%\pyenv-build-wspr.cmd" $*
DOSKEY build-wsjt="%scr%\pyenv-build-wsjt.cmd" $*
DOSKEY make=C:\JTSDK\mingw32\bin\mingw32-make $*

REM  ---------------------------------------------------------------------------
REM   HELP PAGES  - ( users *should not* edit these )
REM  ---------------------------------------------------------------------------
DOSKEY main-menu=CD ^/D %based% ^&CALL %scr%\pyenv-info.cmd
DOSKEY list-options="%scr%\help\jtsdk-help.cmd" $* listoptions
DOSKEY help-list="%based%\scripts\help\jtsdk-help.cmd" $* helplist
DOSKEY help-pyenv="%based%\scripts\help\jtsdk-help.cmd" $* pymain
DOSKEY help-wsjt="%based%\scripts\help\jtsdk-help.cmd" $* wsjthelp
DOSKEY help-wspr="%based%\scripts\help\jtsdk-help.cmd" $* wsprhelp
DOSKEY help-checkout="%based%\scripts\svn-checkout.cmd" $* pycohelp

REM  ---------------------------------------------------------------------------
REM   USER CONFIGURABLE OPTIONS  ( users *should not* edit these )
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

:: RUN VERSION INFORMATION SCRIPT
CALL %scr%\pyenv-info.cmd
GOTO EOF

:: LAUNCH CMD WINDOW
:EOF
%COMSPEC% /A /Q /K
