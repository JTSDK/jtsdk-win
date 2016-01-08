@ECHO OFF
REM  ---------------------------------------------------------------------------
REM   Name .........: qtenv-build-list.cmd
REM   Project ......: Part of the JTSDK v2.0 Project
REM   Description ..: Batch file to generate WSJT-X Build targets
REM   Project URL ..: http://sourceforge.net/projects/wsjt/ 
REM   Usage ........: This file is run from within qtenv.cmd
REM   
REM   Author .......: Greg, Beam, KI7MT, <ki7mt@yahoo.com>
REM   Copyright ....: Copyright (C) 2014-2016 Joe Taylor, K1JT
REM   License ......: GPL-3
REM  
REM   qtenv-build-list.cmd is free software: you can redistribute it and/or modify
REM   it under the terms of the GNU General Public License as published by the Free
REM   Software Foundation either version 3 of the License, or (at your option) any
REM   later version. 
REM  
REM   qtenv-build-list.cmd is distributed in the hope that it will be useful, but
REM   WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
REM   FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
REM   more details.
REM  
REM   You should have received a copy of the GNU General Public License
REM   along with this program.  If not, see <http://www.gnu.org/licenses/>.
REM  --------------------------------------------------------------------------  

SET cfgd=C:\JTSDK\config
SET repo=http://svn.code.sf.net/p/wsjt/wsjt
SET devurl=http://svn.code.sf.net/p/wsjt/wsjt/branches
SET garurl=http://svn.code.sf.net/p/wsjt/wsjt/tags
SET devlist=%cfgd%\devlist.txt
SET garlist=%cfgd%\garlist.txt
SET timestamp=%cfgd%\list-update-time-stamp
SET sed=C:\JTSDK\msys\bin\sed.exe
mkdir %cfgd% >NUL 2>&1

:OPTIONS
IF [%1]==[] GOTO MISSING-OPTION
IF /I [%1]==[-h] ( GOTO HELP )
IF /I [%1]==[-a] ( GOTO LIST-ALL )
IF /I [%1]==[-d] ( GOTO DEV-LIST )
IF /I [%1]==[-g] ( GOTO GAR-LIST )
IF /I [%1]==[-u] ( GOTO UPDATE-LIST
) ELSE ( GOTO HELP )

:LIST-ALL
IF NOT EXIST "%devlist%" (
SET missing=dev-list.txt
GOTO MISSING-LIST
)
IF NOT EXIST "%garlist%" (
SET missing=gar-list.txt
GOTO MISSING-LIST
)
IF NOT EXIST %timestamp% (
SET missing=Update Time Stamp
GOTO MISSING-LIST
)
CLS
ECHO --------------------------------------------
ECHO Development^, GA and RC Lists
ECHO --------------------------------------------
ls -al %timestamp% |awk "{print $6, $7}" >t.k & SET /P modtime=<t.k & rm t.k
ECHO.
ECHO Repository ...^: %repo%
ECHO Last Update ..^: %modtime%
ECHO.
ECHO Development List ^( ^^/wsjt/branches^/ ^)^:
cat %devlist%
ECHO.
ECHO GA and RC List ^( ^^/wsjt/tags^/ ^)^:
cat %garlist%
ECHO.
ECHO To update the lists to the latest available, issue the
ECHO follwing command^:  ^wsjtx-list ^-u
ECHO.
GOTO EOF

:DEV-LIST
IF NOT EXIST "%devlist%" (
SET missing=dev-list.txt
GOTO MISSING-LIST
)
CLS
ECHO --------------------------------------------
ECHO  Development List from ^( ^^/branches ^)
ECHO --------------------------------------------
ls -al %devlist% |awk "{print $6, $7}" >t.k & SET /P modtime=<t.k & rm t.k
ECHO.
ECHO File Name ....^: %devlist%
ECHO Last Update ..^: %modtime%
ECHO.
cat %devlist%
ECHO.
GOTO EOF

:GAR-LIST
IF NOT EXIST "%garlist%" (
SET missing=gar-list.txt
GOTO MISSING_LIST
)
CLS
ECHO --------------------------------------------
ECHO  GA and RC List from ^( ^^/tags ^)
ECHO --------------------------------------------
ls -al %garlist% |awk "{print $6, $7}" >t.k & SET /P modtime=<t.k & rm t.k
ECHO.
ECHO File Name ....^: %garlist%
ECHO Last Update ..^: %modtime%
ECHO.
cat %garlist%
ECHO.
GOTO EOF

:UPDATE-LIST
CD /D %cfg%
CLS
ECHO ---------------------------------------------
ECHO Updating WSJT-X Build Lists from Sourceforge
ECHO ---------------------------------------------
ECHO.
wget -q --tries=5 --timeout=10 -O - http://google.com > /NUL 2>&1
IF [%errorlevel%]==[0] ( ECHO ^* Internet Connection is OK
) ELSE ( GOTO INET-ERROR )

svn list http://svn.code.sf.net/p/wsjt/wsjt > /NUL 2>&1
IF [%errorlevel%]==[0] ( ECHO ^* Access to Sourceforge is OK
) ELSE ( GOTO SF-ERROR )

ECHO ^* Updating Development List
rm -f %devlist% && touch %devlist% >NUL 2>&1
rm -f %garlist% && touch %garlist% >NUL 2>&1
ECHO wsjtx >> %devlist%
svn list %devurl% |grep ^wsjtx-[1-9]\.[5-9] |%sed% "s:/*$::" |sort |uniq >> %devlist%
ECHO wsjtx_exp >> %devlist%

ECHO ^* Updating GA and RC List
svn list %garurl% |grep ^wsjtx-[1-9]\.[5-9] |%sed% "s:/*$::" |sort |uniq > %garlist%
ECHO.
ECHO Development List ^( ^^/wsjt/branches^/ ^)^:
cat %devlist%
ECHO.
ECHO GA and RC List ^( ^^/wsjt/tags^/ ^)^:
cat %garlist%
ECHO.
IF [%errorlevel%]==[0] ( touch "%cfgd%\list-update-time-stamp" )
GOTO EOF

:HELP
CD /D %based%
CLS
ECHO --------------------------------------------
ECHO  WSJT-X List Help Options
ECHO --------------------------------------------
ECHO.
ECHO  Usage ...^: ^wsjtx-list ^[ option ^]
ECHO  Example..^: ^wsjtx-list ^-h
ECHO.
ECHO  OPTIONS^:
ECHO    ^-h   Display this message
ECHO    ^-a   Display all lists
ECHO    ^-d   Display the development branch list
ECHO    ^-g   Display the GA and RC tags list
ECHO    ^-u   Update lists from SVN repository
ECHO.
GOTO EOF

:MISSING-OPTION
CLS
ECHO --------------------------------------------
ECHO  Invalid Number of Arguments ^- ^[ 0 ^]
ECHO --------------------------------------------
ECHO.
ECHO  wsjtx-list requires at least ^[ 1 ^] option
ECHO  to be entered by the user.
ECHO.
ECHO  Press any key to display the help message ... 
PAUSE>NUL
GOTO HELP

: MISSING-LIST
CLS
ECHO --------------------------------------------
ECHO  Missing ^[ %missing% ^]
ECHO --------------------------------------------
ECHO.
ECHO  ^[ %missing% ^] is either missing or could
ECHO  not be opened.
ECHO.
ECHO  To correct this, run with option ^[ ^-u ^]
ECHO.
ECHO  ^wsjtx-list ^-u
ECHO.
ECHO  If the problem presists after updating,
ECHO  contact the development list.
ECHO.
GOTO EOF

:INET-ERROR
CLS
ECHO --------------------------------------------
ECHO  Internet Connection Failed
ECHO --------------------------------------------
ECHO.
ECHO  ^wsjtx-list was unable to connect to the
ECHO  Internet properly. Check your connection
ECHO  and try to update again.
ECHO.
GOTO EOF

:SF-ERROR
CLS
ECHO --------------------------------------------
ECHO  Sourceforge Connection Error
ECHO --------------------------------------------
ECHO.
ECHO  ^wsjtx-list was unable to connect to the
ECHO  Sourceforge SVN Repository. The service
ECHO  may be down or undergoing maintenance.
ECHO  Check the following link for current site
ECHO  status reports:
ECHO.
ECHO  http://sourceforge.net/blog/category/sitestatus/
ECHO.
GOTO EOF

REM   END OF QTENV-BUILD-LIST.CMD
:EOF
CD /D %based%
COLOR 0B

EXIT /B 0
