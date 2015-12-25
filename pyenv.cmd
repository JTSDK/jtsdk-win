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
SET version=2.0.3
SET based=C:\JTSDK
SET tools=%based%\tools\bin
SET svnd=%based%\subversion\bin
SET PATH=%based%;%tools%;%svnd%;%WINDIR%\System32
svn info |grep "Rev:" |awk "{print $2}" >r.v & set /p rev=<r.v & rm r.v
SET version=%version%-%rev%
SET title-string=JTSDK Python Development Environment %version%
TITLE %title-string%
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
SET PROMPT=$CJTSDK-PY 3.3 $F $P$F
SET LANG=en_US
MODE con:cols=100 lines=38
COLOR 0A

:: PATH VARIABLES
SET mgw=%based%\mingw32\bin
SET inno=%based%\inno5
SET ruby=%based%\Ruby\bin
SET scr=%based%\scripts
SET python2path=%based%\python27;%based%\python27\Scripts;%based%\python27\DLLs
SET python3path=%based%\Python33;%based%\python33\Scripts;%based%\python33\DLLs
SET svnd=%based%\subversion\bin
SET srcd=%based%\src
SET LIBRARY_PATH=
SET PATH=%based%;%python2path%;%python3path%;%MGW%;%tools%;%innno%;%ruby%;%scr%;%srcd%;%svnd%;%WINDIR%\System32
CD /D %based%

:: MAKE SURE SRCD IS PRESENT
IF NOT EXIST %srcd%\NUL ( mkdir %based%\src )

:: CHECKOUT AND BUILD COMMANDS ( users *should not* edit these )
DOSKEY checkout-wspr="%scr%\pyenv-checkout.cmd" $* wspr
DOSKEY checkout-wsjt="%scr%\pyenv-checkout.cmd" $* wsjt
DOSKEY build-wspr="%scr%\pyenv-build-wspr.cmd" $*
DOSKEY build-wsjt="%scr%\pyenv-build-wsjt.cmd" $*
DOSKEY make=C:\JTSDK\mingw32\bin\mingw32-make $*

:: HELP PAGES ( users *should not* edit these )
DOSKEY main-menu=CD ^/D %based% ^&CALL %scr%\pyenv-info.cmd
DOSKEY help-pyenv=CALL %based%\scripts\help\pyenv-help-main.cmd
DOSKEY help-checkout=CALL %based%\scripts\help\pyenv-help-checkout.cmd
DOSKEY help-wspr=CALL %based%\scripts\help\pyenv-help-wspr.cmd
DOSKEY help-wsjt=CALL %based%\scripts\help\pyenv-help-wsjt.cmd

:: USER DEFINABLE ALIAS COMMANDS ( use edit-alias to edit list )
:: Note, this file gets overwritten with SVN update changes
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
DOSKEY python2="C:\JTSDK\python27\python.exe" $*
DOSKEY python3="C:\JTSDK\python33\python.exe" $*

:: RE-SET FILE ASSOCIATIONS
SET PATHEXT=.COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC

:: RUN VERSION INFORMATION SCRIPT
CALL %scr%\pyenv-info.cmd
GOTO EOF

:: LAUNCH CMD WINDOW
:EOF
%COMSPEC% /A /Q /K
