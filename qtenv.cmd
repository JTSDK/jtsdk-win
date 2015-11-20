::-----------------------------------------------------------------------------::
:: Name .........: qtenv.cmd
:: Function .....: JTSDK QT5 Environment for Win32
:: Project ......: Part of the JTSDK v2.0.0 Project
:: Description ..: Sets the Environment for building WSJT-X, WSPR-X and MAP65
:: Project URL ..: http://sourceforge.net/projects/jtsdk 
:: Usage ........: Windows Start, run C:\JTSDK\qtenv.cmd
:: 
:: Author .......: Greg, Beam, KI7MT, <ki7mt@yahoo.com>
:: Copyright ....: Copyright (C) 2014-2015 Joe Taylor, K1JT
:: License ......: GPL-3
::
:: qtenv.cmd is free software: you can redistribute it and/or modify it under the
:: terms of the GNU General Public License as published by the Free Software
:: Foundation either version 3 of the License, or (at your option) any later
:: version. 
::
:: qtenv.cmd is distributed in the hope that it will be useful, but WITHOUT ANY
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
SET version=v2.0.3
SET title-string=JTSDK QT 5.5 Development Environment %version%
ECHO\
IF EXIST qt55-enabled.txt (
TITLE %title-string%
SET PROMPT=$CJTSDK-QT 5.5 $F $P$F
) ELSE (
TITLE %title-string%
SET PROMPT=$CJTSDK-QT 5.2 $F $P$F
)
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
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
SET ruby=%based%\Ruby\bin
SET scr=%based%\scripts
SET srcd=%based%\src
SET svnd=%based%\subversion\bin
:: Optional enable / Disable use of QT55 for testing
:: *DO NOT EDIT MANYALLY*
IF EXIST qt55-enabled.txt (
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

)
SET PATH=%based%;%cmk%;%tools%;%hl3%;%py27%;%fft%;%gccd%;%qt5d%;%qt5a%;%qt5p%;%nsi%;%ino%;%ruby%;%srcd%;%scr%;%srcd%;%svnd%;%WINDIR%;%WINDIR%\System32


::----------------------------------------------------------------------------::
::                    USER DEFINABLE ALIAS COMMANDS                           ::
::----------------------------------------------------------------------------::

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


::----------------------------------------------------------------------------::
::                   DO NOT EDIT BELOW THIS LINE                              ::
::----------------------------------------------------------------------------::

:: ENSURE WE ARE IN THER JTSDK ROOT DIRECTORY
CD /D %based%

:: MAKE SURE SRCD IS PRESENT
IF NOT EXIST %srcd%\NUL ( mkdir %based%\src )

:: CHECKOUT COMMANDS ( users *should not* edit these )
DOSKEY checkout-wsprx="%scr%\qtenv-checkout.cmd" $* wsprx
DOSKEY checkout-map65="%scr%\qtenv-checkout.cmd" $* map65

:: BUILD COMMANDS ( users *should not* edit these )
DOSKEY build-wsprx="%scr%\qtenv-build-wsprx.cmd" $* wsprx
DOSKEY build-map65="%scr%\qtenv-build-map65.cmd" $* map65

:: HELP PAGES ( users *should not* edit these )
DOSKEY main-menu=CD ^/D %based% ^&CALL %scr%\qtenv-info.cmd
DOSKEY help-qtenv=CALL %based%\scripts\help\qtenv-help-main.cmd
DOSKEY help-checkout=CALL %based%\scripts\help\qtenv-help-checkout.cmd
DOSKEY help-wsprx=CALL %based%\scripts\help\qtenv-help-wsprx.cmd
DOSKEY help-map65=CALL %based%\scripts\help\qtenv-help-map65.cmd

:: WSJTX DEVEL BRANCH ( users *should not* edit these )
DOSKEY help-wsjtx=CALL %based%\scripts\help\qtenv-help-wsjtx.cmd
DOSKEY checkout-wsjtx="%scr%\qtenv-checkout.cmd" $* wsjtx
DOSKEY build-wsjtx="%scr%\qtenv-build-wsjtx.cmd" $* wsjtx

:: WSJT-X RC BRANCH ( users *should not* edit these )
DOSKEY help-wsjtxrc=CALL %based%\scripts\help\qtenv-help-wsjtxrc.cmd
DOSKEY checkout-wsjtxrc="%scr%\qtenv-checkout.cmd" $* wsjtxrc
DOSKEY build-wsjtxrc="%scr%\qtenv-build-wsjtxrc.cmd" $* wsjtxrc
:: DOSKEY help-wsjtxrc="%scr%\qtenv-rc-message.cmd"
:: DOSKEY build-wsjtxrc="%scr%\qtenv-rc-message.cmd"
:: DOSKEY checkout-wsjtxrc="%scr%\qtenv-rc-message.cmd"

:: WSJT-X EXP BRANCH ( users *should not* edit these )
DOSKEY checkout-wsjtxexp="%scr%\qtenv-exp-message.cmd"
DOSKEY build-wsjtxexp="%scr%\qtenv-exp-message.cmd"
DOSKEY help-wsjtxexp="%scr%\qtenv-exp-message.cmd"

:: DOSKEY checkout-wsjtxexp="%scr%\qtenv-checkout.cmd" $* wsjtxexp
:: DOSKEY build-wsjtxexp="%scr%\qtenv-exp-message.cmd"
:: DOSKEY help-wsjtxexp=CALL %based%\scripts\help\qtenv-help-wsjtxexp.cmd
:: DOSKEY build-wsjtxexp="%scr%\qtenv-build-wsjtxexp.cmd" $* wsjtxexp


:: ENABLE / DISABLE Qt5.5 ( users *should not* edit these )
DOSKEY qt55-enable="touch.exe" C:\JTSDK\qt55-enabled.txt
DOSKEY qt55-disable="rm.exe" -f C:\JTSDK\qt55-enabled.txt

CALL %scr%\qtenv-info.cmd
IF NOT EXIST %based%\src\NUL ( mkdir %based%\src )
GOTO EOF

:: LAUNCH CMD WINDOW
:EOF
%WINDIR%\System32\cmd.exe /A /Q /K
