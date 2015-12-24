::-----------------------------------------------------------------------------::
:: Name .........: qtenv-build-list.cmd
:: Project ......: Part of the JTSDK v2.0
:: Description ..: Batch file to generate WSJT-X Build targets
:: Project URL ..: http://sourceforge.net/projects/wsjt/ 
:: Usage ........: This file is run from within qtenv.cmd
:: 
:: Author .......: Greg, Beam, KI7MT, <ki7mt@yahoo.com>
:: Copyright ....: Copyright (C) 2014-2016 Joe Taylor, K1JT
:: License ......: GPL-3
::
:: qtenv-build-list.cmd is free software: you can redistribute it and/or modify
:: it under the terms of the GNU General Public License as published by the Free
:: Software Foundation either version 3 of the License, or (at your option) any
:: later version. 
::
:: qtenv-build-list.cmd is distributed in the hope that it will be useful, but
:: WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
:: FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
:: more details.
::
:: You should have received a copy of the GNU General Public License
:: along with this program.  If not, see <http://www.gnu.org/licenses/>.
::-----------------------------------------------------------------------------::

:: ENVIRONMENT
@ECHO OFF
SETLOCAL EnableExtensions
SETLOCAL EnableDelayedExpansion
SET LANG=en_US
MODE con:cols=100 lines=40
COLOR 0B

:: TEST DOUBLE CLICK, if YES, GOTO ERROR MESSAGE
FOR %%x IN (%cmdcmdline%) DO IF /I "%%~x"=="/c" SET GUI=1
IF DEFINED GUI CALL GOTO DOUBLE_CLICK_ERROR

:: PATH VARIABLES
SET based=C:\JTSDK
SET tools=%based%\tools\bin
SET cfg=%based%\config
SET svnd=%based%\subversion\bin
SET PATH=%based%;%tools%;%cfg%;%svnd%;%WINDIR%\System32

:: PROCESS FILES, URL's and FOLDERS
SET devlist=%cfg%\dev_list.txt
SET garlist=%cfg%\gar_list.txt
SET timestamp=%cfg%\list-update-time-stamp
SET devurl="http://svn.code.sf.net/p/wsjt/wsjt/branches"
set garurl="http://svn.code.sf.net/p/wsjt/wsjt/tags"
IF NOT EXIST %cfg%\NUL mkdir %cfg%
GOTO OPTIONS

:: PROCESS COMMAND LINE OPTIONS
:OPTIONS
IF [%1]==[] GOTO MISSING_OPTION
IF /I [%1]==[-h] ( GOTO HELP )
IF /I [%1]==[-a] ( GOTO LIST_ALL )
IF /I [%1]==[-d] ( GOTO DEV_LIST )
IF /I [%1]==[-g] ( GOTO GAR_LIST )
IF /I [%1]==[-u] ( GOTO UPDATE_LIST
) ELSE ( GOTO HELP )


:: All Lists -------------------------------------------------------------------
:: -a option
:LIST_ALL
CLS
ECHO --------------------------------------------
ECHO Development^, GA and RC List
ECHO --------------------------------------------
ls -al %timestamp% |awk "{print $6, $7}" >t.k & SET /P modtime=<t.k & rm t.k
ECHO.
ECHO Last Update ..: %modtime%
ECHO.
ECHO Development List from^: ^( ^^/branches ^):
cat %devlist%
ECHO.
ECHO GA and RC List from^: ^( ^^/tags ^):
cat %garlist%
GOTO EOF


:: DEVELOPMENT LIST ------------------------------------------------------------
:: -d option
:DEV_LIST
CLS
ECHO --------------------------------------------
ECHO  Development List from ^( ^^/branches ^)
ECHO --------------------------------------------
ls -al %devlist% |awk "{print $6, $7}" >t.k & SET /P modtime=<t.k & rm t.k
ECHO.
ECHO File Name ....: %devlist%
ECHO Last Update ..: %modtime%
ECHO.
cat %devlist%
ECHO.
GOTO EOF


:: GA and RELEASE CANDIDATE LIST -----------------------------------------------
:: -g option
:GAR_LIST
CLS
ECHO --------------------------------------------
ECHO GA and RC List from ^( ^^/tags ^)
ECHO --------------------------------------------
ls -al %garlist% |awk "{print $6, $7}" >t.k & SET /P modtime=<t.k & rm t.k
ECHO.
ECHO File Name ....: %garlist%
ECHO Last Update ..: %modtime%
ECHO.
cat %garlist%
ECHO.
GOTO EOF


:: UPDATE LISTS ----------------------------------------------------------------
:: -u option
:UPDATE_LIST
CD /D %cfg%
CLS
ECHO --------------------------------------------
ECHO Updating Build Lists from Sourceforge
ECHO --------------------------------------------
ECHO.
:: Test We have Internet connection
wget -q --tries=5 --timeout=10 -O - http://google.com > /NUL 2>&1
IF [%errorlevel%]==[0] ( ECHO ^* Internet Connection is OK
) ELSE ( GOTO INET_ERROR )

:: Check we can get data Sourceforge
svn list http://svn.code.sf.net/p/wsjt/wsjt > /NUL 2>&1
IF [%errorlevel%]==[0] ( ECHO ^* Access to Sourceforge is OK
) ELSE ( GOTO SF_ERROR )

:: If above tests pased, proceed with updating the lists.
rm -f %devlist% && touch %devlist% > /NUL 2>&1
rm -f %garlist% && touch %garlist% > /NUL 2>&1
ECHO ^* Updating Development List

:: wsjtx will always be in the list
ECHO wsjtx > %devlist%
svn list %devurl% | grep ^wsjtx-[1-9]\.[5-9] | sed "s:/*$::" | sort |uniq >> %devlist%

:: Add wsjtx_exp in case Joe wanted to eenable it
ECHO wsjtx_exp >> %devlist%
ECHO ^* Updating GA and RC List
svn list %garurl% | grep ^wsjtx-[1-9]\.[5-9] | sed "s:/*$::" | sort |uniq > %garlist%
ECHO.
ECHO New Development List from^: ^( ^^/branches ^):
cat %devlist%
ECHO.
ECHO New GA and RC List from^: ^( ^^/tags ^):
cat %garlist%
ECHO.
IF [%errorlevel%]==[0] ( touch "%cfg%\list-update-time-stamp" )
GOTO EOF


:: MUST HAVE ONE OPTION --------------------------------------------------------
:MISSING_OPTION
CLS
ECHO --------------------------------------------
ECHO  Invalid Number of Options - ^[0^]
ECHO --------------------------------------------
ECHO.
ECHO  Build List requires at least ^[1^] option
ECHO  to be entered by the user.
ECHO.
PAUSE
GOTO HELP

:: DISPLAY HELP MESSAGE --------------------------------------------------------
:HELP
CD /D %based%
CLS
ECHO --------------------------------------------
ECHO  Command Line Options Help
ECHO --------------------------------------------
ECHO.
ECHO  Usage ...: build-list [ option ]
ECHO  Example..: build-list -h
ECHO.
ECHO  OPTIONS^:
ECHO    -h   Display this message
ECHO    -a   Display all lists
ECHO    -d   Display the development branch list
ECHO    -g   Display the GA and RC tags list
ECHO    -u   Update lists from SVN repository
ECHO.
GOTO EOF


REM ----------------------------------------------------------------------------
REM ERROR MESSAGES
REM ----------------------------------------------------------------------------

:INET_ERROR
CLS
ECHO --------------------------------------------
ECHO  Internet Connection Failed
ECHO --------------------------------------------
ECHO.
ECHO  Build list was unable to connect to the
ECHO  Internet properly. Check your connection
ECHO  and try to update again.
ECHO.
GOTO EOF

:SF_ERROR
CLS
ECHO --------------------------------------------
ECHO  Sourceforge Connection Error
ECHO --------------------------------------------
ECHO.
ECHO  Build list was unable to connect to the
ECHO  Sourceforge SVN Repository. The service
ECHO  may be down or undergoing maintenance.
ECHO  Check the following link for current site
ECHO  status reports:
ECHO.
ECHO  http://sourceforge.net/blog/category/sitestatus/
ECHO.
GOTO EOF


:: WARN ON DOUBLE CLICK
:DOUBLE_CLICK_ERROR
CLS
ECHO -------------------------------
ECHO     DOUBLE CLICK WARNING
ECHO -------------------------------
ECHO.
ECHO   Use JTSDK-QT Environment
ECHO.
ECHO     to run this script
ECHO.
PAUSE
GOTO EOF


:: END OF QTENV-BUILD-LIST.CMD
:EOF
CD /D %based%
COLOR 0B
ENDLOCAL

EXIT /B 0
