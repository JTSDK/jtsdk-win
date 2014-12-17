::-----------------------------------------------------------------------------::
:: Name .........: pyenv.cmd
:: Function .....: JTSDK Python Environment for Win32
:: Project ......: Part of the JTSDK v2.0.0 Project
:: Description ..: Sets the Environment for building WSJT and WSPR
:: Project URL ..: http://sourceforge.net/projects/jtsdk 
:: Usage ........: Windows Start, run C:\JTSDK\pyenv.bat
:: 
:: Author .......: Greg, Beam, KI7MT, <ki7mt@yahoo.com>
:: Copyright ....: Copyright (C) 2014 Joe Taylor, K1JT
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
ECHO Setting Up JTSDK-PY v2 Environment variables ...
TITLE JTSDK Python Development Environment
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
SET PROMPT=$CJTSDK-PY$F $P$F
SET LANG=en_US
COLOR 0A

:: PATH VARIABLES
SET based=C:\JTSDK
SET tools=%based%\tools\bin
SET mgw=%based%\mingw32\bin
SET inno=%based%\inno5
SET scr=%based%\scripts
SET pythonpath=%based%\Python33;%based%\Python33\Scripts;%based%\Python33\DLLs
SET svnd=%based%\subversion\bin
SET LIBRARY_PATH=
SET PATH=%based%;%MGW%;%pythonpath%;%tools%;%innno%;%scr%;%svnd%;%WINDIR%\System32
CD /D %based%

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

:: RE-SET FILE ASSOCIATIONS
SET PATHEXT=.COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC;.py
assoc .py=Python.File > NUL
assoc .pyc=Python.File > NUL
ftype Python.File=%based%\Python33\python.exe "%1" %* > NUL

:: RUN VERSION INFORMATION SCRIPT
CALL %scr%\pyenv-info.cmd
GOTO EOF

:: LAUNCH CMD WINDOW
:EOF
%COMSPEC% /A /Q /K
