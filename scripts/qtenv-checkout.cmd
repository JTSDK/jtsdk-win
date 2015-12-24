::-----------------------------------------------------------------------------::
:: Name .........: qtenv-checkout.cmd
:: Project ......: Part of the JTSDK v2.0.0 Project
:: Description ..: Batch file to check out WSJT-X/RC, WSPR-X and MAP65
:: Project URL ..: http://sourceforge.net/projects/wsjt/ 
:: Usage ........: This file is run from within qtenv.cmd
:: 
:: Author .......: Greg, Beam, KI7MT, <ki7mt@yahoo.com>
:: Copyright ....: Copyright (C) 2014-2015 Joe Taylor, K1JT
:: License ......: GPL-3
::
:: qtenv-checkout.cmd is free software: you can redistribute it and/or modify it
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

:: ENVIRONMENT
@ECHO OFF
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION
SET LANG=en_US
COLOR 0B

:: TEST DOUBLE CLICK, if YES, GOTO ERROR MESSAGE
FOR %%x IN (%cmdcmdline%) DO IF /I "%%~x"=="/c" SET GUI=1
IF DEFINED GUI CALL GOTO DOUBLE_CLICK_ERROR

:: PATH VARIABLES
SET based=C:\JTSDK
SET tools=%based%\tools\bin
SET srcd=%based%\src
SET scr=%based%\scripts
SET svnd=%based%\subversion\bin
SET PATH=%based%;%tools%;%srcd%;%scr%;%svnd%;%WINDIR%\System32
GOTO CHK_APP

:: CHECK IF APPLICATION NAME IF SUPPORTED
:CHK_APP
IF /I [%1]==[wsjtxrc] (
SET app_name=wsjtx-1.6
SET display_name=WSJTX-1.6-RC
GOTO SVN_CO
)
IF /I [%1]==[wsjtxexp] (
CALL "%scr%\qtenv-exp-message.cmd"
:: SET app_name=wsjtx_exp
:: display_name=WSJTX-1.6.1-devel
GOTO EOF
)
IF /I [%1]==[wsjtx] (
SET app_name=wsjtx
SET display_name=WSJTX-1.7.0-devel
GOTO SVN_CO
)
IF /I [%1]==[wsprx] (
SET app_name=wsprx
SET display_name=WSPRX
GOTO SVN_CO
)
IF /I [%1]==[map65] (
SET app_name=map65
SET display_name=MAP65
GOTO SVN_CO
) 
:: If its not supported, goto EOF
GOTO EOF

:: PERFORM WSPR CHECKOUT
:SVN_CO
IF NOT EXIST %srcd%\NUL (MKDIR %srcd% )
CD /D %srcd%
CLS
ECHO.
ECHO -----------------------------------------------------------------
ECHO Checking Out ^( %display_name% ^) From SVN
ECHO -----------------------------------------------------------------
start /wait svn co https://svn.code.sf.net/p/wsjt/wsjt/branches/%app_name%
CD %based%
GOTO FINISH

:: FINISH CHECKOUT MESSAGE
:FINISH
ECHO.
ECHO Checkout complete.
ECHO.
IF /I [%1%]==[wsjtxrc] (
ECHO To Build, Type ...........: build-wsjtxrc
ECHO For build options, type ..: help-wsjtxrc
GOTO EOF
)
:: The EXP Branch is currently dorment
:: IF /I [%1]==[wsjtxexp] (
:: ECHO To Build, Type ...........: build-wsjtxexp
:: ECHO For build options, type ..: help-wsjtxexp
:: GOTO EOF
)
IF /I [%1]==[wsjtx] (
ECHO To Build, Type ...........: build-wsjtx
ECHO For build options, type ..: help-wsjtx
GOTO EOF
)
IF /I [%1]==[wsprx] (
ECHO To Build, Type ...........: build-wsprx
ECHO For build options, type ..: help-wsprx
GOTO EOF
)
IF /I [%1]==[map65] (
ECHO To Build, Type ...........: build-map65
ECHO For build options, type ..: help-map65
GOTO EOF
)

:: WARN ON DOUBLE CLICK
:DOUBLE_CLICK_ERROR
CLS
ECHO -------------------------------
ECHO     DOUBLE CLICK WARNING
ECHO -------------------------------
ECHO.
ECHO  Please Use JTSDK Enviroment
ECHO.
ECHO         qtenv.cmd
ECHO.
PAUSE
GOTO EOF

:: END OF QTENV-CO.BAT
:EOF
CD /D %based%
COLOR 0B
ENDLOCAL

EXIT /B 0
