::-----------------------------------------------------------------------------::
:: Name .........: qtenv-checkout.cmd
:: Project ......: Part of the JTSDK v2.0.0 Project
:: Description ..: Batch file to check out WSJT-X/RC, WSPR-X and MAP65
:: Project URL ..: http://sourceforge.net/projects/wsjt/ 
:: Usage ........: This file is run from within qtenv.cmd
:: 
:: Author .......: Greg, Beam, KI7MT, <ki7mt@yahoo.com>
:: Copyright ....: Copyright (C) 2014 Joe Taylor, K1JT
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
SET BASED=C:\JTSDK
SET tools=%based%\tools\bin
SET SRCD=%based%\src
SET SCR=%based%\scripts
SET SVND=%based%\subversion\bin
SET PATH=%based%;%tools%;%srcd%;%scr%;%svnd%;%WINDIR%\System32
GOTO CHK_APP

:: CHECK IF APPLICATION NAME IF SUPPORTED
:CHK_APP
IF /I [%1]==[wsjtxrc] ( SET app_name=wsjtx-1.4 &GOTO SVN_CO )
IF /I [%1]==[wsjtx] ( SET app_name=wsjtx & GOTO SVN_CO )
IF /I [%1]==[wsprx] ( SET app_name=wsprx & GOTO SVN_CO )
IF /I [%1]==[map65] ( SET app_name=map65 & GOTO SVN_CO )
GOTO EOF

:: PERFORM WSPR CHECKOUT
:SVN_CO
CD /D %srcd%
CLS
ECHO.
ECHO -----------------------------------------------------------------
ECHO Checking Out ^( %app_name% ^) From SVN
ECHO -----------------------------------------------------------------
start /wait svn co https://svn.code.sf.net/p/wsjt/wsjt/branches/%app_name%
CD %based%
GOTO FINISH
)

:: FINISH CHECKOUT MESSAGE
:FINISH
ECHO.
ECHO Checkout complete.
ECHO.
IF /I [%app_name%]==[wsjtxrc]
ECHO To Build, Type: build-wsjtxrc
) ELSE (
ECHO To Build, Type: build-%APP_NAME%
)
ECHO.
IF /I [%app_name%]==[wsjtxrc] (
ECHO For additional build options, type: help-wsjtxrc
) ELSE (
ECHO For additional build options, type: help-%app_name%
)
ECHO.
GOTO EOF

:: WARN ON DOUBLE CLICK
:DOUBLE_CLICK_ERROR
CLS
ECHO -------------------------------
ECHO     DOUBLE CLICK WARNING
ECHO -------------------------------
ECHO.
ECHO  Please Use JTSDK Enviroment
ECHO.
ECHO         qtenv.bat
ECHO.
PAUSE
GOTO EOF

:: END OF QTENV-CO.BAT
:EOF
CD /D %based%
ENDLOCAL

EXIT /B 0
