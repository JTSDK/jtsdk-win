::-----------------------------------------------------------------------------::
:: Name .........: qtenv.bat
:: Function .....: JTSDK QT5 Environment for Win32
:: Project ......: Part of the JTSDK v2.0.0 Project
:: Description ..: Sets the Environment for building WSJT-X, WSPR-X and MAP65
:: Project URL ..: http://sourceforge.net/projects/jtsdk 
:: Usage ........: Windows Start, run C:\JTSDK\qtenv.bat
:: 
:: Author .......: Greg, Beam, KI7MT, <ki7mt@yahoo.com>
:: Copyright ....: Copyright (C) 2014 Joe Taylor, K1JT
:: License ......: GPL-3
::
:: qtenv.bat is free software: you can redistribute it and/or modify it under the
:: terms of the GNU General Public License as published by the Free Software
:: Foundation either version 3 of the License, or (at your option) any later
:: version. 
::
:: qtenv.bat is distributed in the hope that it will be useful, but WITHOUT ANY
:: WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
:: A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
::
:: You should have received a copy of the GNU General Public License
:: along with this program.  If not, see <http://www.gnu.org/licenses/>.
::-----------------------------------------------------------------------------::

:: ENVIRONMENT
@ECHO OFF
ECHO Setting Up JTSDK-QT v2 Environment variables ...
TITLE JTSDK QT5 Development Environment
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
SET PROMPT=$CJTSDK-QT$F $P$F
SET LANG=en_US
COLOR 0B

:: PATH VARIABLES
SET based=C:\JTSDK
SET cmk=%based%\cmake\bin
SET tools=%based%\tools\bin
SET hl3=%based%\hamlib3\bin
SET fft=%based%\fftw3f
SET nsi=%based%\nsis
SET ino=%based%\inno5
SET gccd=%based%\qt5\Tools\mingw48_32\bin
SET qt5d=%based%\qt5\5.2.1\mingw48_32\bin
SET qt5a=%based%\qt5\5.2.1\mingw48_32\plugins\accessible
SET qt5p=%based%\qt5\5.2.1\mingw48_32\plugins\platforms
SET scr=%based%\scripts
SET srcd=%based%\src
SET svnd=%based%\subversion\bin
SET LIBRARY_PATH=
SET PATH=%based%;%cmk%;%tools%;%hl3%;%fft%;%gccd%;%qt5d%;%qt5a%;%qt5p%;%nsi%;%ino%;%srcd%;%scr%;%svnd%;%WINDIR%;%WINDIR%\System32
CD /D %based%

:: CHECKOUT COMMANDS ( users *should not* edit these )
DOSKEY checkout-wsjtx="%scr%\qtenv-checkout.cmd" $* wsjtx
DOSKEY checkout-wsjtxrc="%scr%\qtenv-checkout.cmd" $* wsjtxrc
DOSKEY checkout-wsprx="%scr%\qtenv-checkout.cmd" $* wsprx
DOSKEY checkout-map65="%scr%\qtenv-checkout.cmd" $* map65

:: BUILD COMMANDS ( users *should not* edit these )
DOSKEY build-wsjtx="%scr%\qtenv-build-wsjtx.cmd" $* wsjtx
DOSKEY build-wsjtxrc="%scr%\qtenv-build-wsjtxrc.cmd" $* wsjtxrc
DOSKEY build-wsprx="%scr%\qtenv-build-wsprx.cmd" $* wsprx
DOSKEY build-map65="%scr%\qtenv-build-map65.cmd" $* map65

:: HELP PAGES ( users *should not* edit these )
DOSKEY main-menu=CD ^/D %based% ^&CALL %scr%\qtenv-info.cmd
DOSKEY help-qtenv=CALL %based%\scripts\help\qtenv-help-main.cmd
DOSKEY help-checkout=CALL %based%\scripts\help\qtenv-help-checkout.cmd
DOSKEY help-wsjtx=CALL %based%\scripts\help\qtenv-help-wsjtx.cmd
DOSKEY help-wsjtxrc=CALL %based%\scripts\help\qtenv-help-wsjtxrc.cmd
DOSKEY help-wsprx=CALL %based%\scripts\help\qtenv-help-wsprx.cmd
DOSKEY help-map65=CALL %based%\scripts\help\qtenv-help-map65.cmd

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

CALL %scr%\qtenv-info.cmd
IF NOT EXIST %based%\src\NUL mkdir %based%\src
GOTO EOF

:: LAUNCH CMD WINDOW
:EOF
%WINDIR%\System32\cmd.exe /A /Q /K
