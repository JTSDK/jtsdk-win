::-----------------------------------------------------------------------------::
:: Name .........: pyenv-co.bat
:: Project ......: Part of the JTSDK v2.0.0 Project
:: Description ..: Batch file to check out WSJT and WSPR from SVN
:: Project URL ..: http://sourceforge.net/projects/wsjt/
:: Usage ........: This file is run from within pyenv.bat
:: 
:: Author .......: Greg, Beam, KI7MT, <ki7mt@yahoo.com>
:: Copyright ....: Copyright (C) 2014-2015 Joe Taylor, K1JT
:: License ......: GPL-3
::
:: pyenv-co.bat is free software: you can redistribute it and/or modify it
:: under the terms of the GNU General Public License as published by the Free
:: Software Foundation either version 3 of the License, or (at your option) any
:: later version. 
::
:: pyenv-co.bat is distributed in the hope that it will be useful, but WITHOUT
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
COLOR 0A
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
IF /I [%1]==[wspr] (SET app_name=wspr &GOTO WSPR_CO)
IF /I [%1]==[wsjt] (SET app_name=wsjt &GOTO WSJT_CO)

:: PERFORM WSPR CHECKOUT
:WSPR_CO
CD /D %srcd%
CLS
ECHO.
ECHO -----------------------------------------------------------------
ECHO Checking Out ^( %app_name% ^) From SVN
ECHO -----------------------------------------------------------------
start /wait svn co https://svn.code.sf.net/p/wsjt/wsjt/branches/%app_name%
GOTO FINISH
)

:: PERFORM WSJT CHECKOUT
:WSJT_CO
CD /D %srcd%
CLS
ECHO.
ECHO -----------------------------------------------------------------
ECHO Checking Out ^( %app_name% ^) From SVN
ECHO -----------------------------------------------------------------
start /wait svn co https://svn.code.sf.net/p/wsjt/wsjt/trunk
GOTO FINISH
)

:: FINISH CHECKOUT MESSAGE
:FINISH
ECHO.
ECHO Checkout complete.
ECHO.
ECHO To Build, Type: build-%APP_NAME%
ECHO.
ECHO For additional build options, type: help-%APP_NAME%
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
ECHO         pyenv.bat
ECHO.
PAUSE
GOTO EOF

:: END OF PYENV-CO.BAT
:EOF
CD /D %based%
ENDLOCAL

EXIT /B 0