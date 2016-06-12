@ECHO OFF
::-----------------------------------------------------------------------------::
:: Name .........: qtenv-info.bat
:: Project ......: Part of the JTSDK v2.0 Project
:: Description ..: Batch file to check version informaiton
:: Project URL ..: http://sourceforge.net/projects/wsjt/ 
:: Usage ........: This file is run from within qtenv.cmd
::
:: Author .......: Greg, Beam, KI7MT, <ki7mt@yahoo.com>
:: Copyright ....: Copyright (C) 2014-2016 Joe Taylor, K1JT
:: License ......: GPL-3
::
:: qtenv-info.bat is free software: you can redistribute it and/or modify it
:: under the terms of the GNU General Public License as published by the Free
:: Software Foundation either version 3 of the License, or (at your option) any
:: later version. 
::
:: qtenv-info.bat is distributed in the hope that it will be useful, but WITHOUT
:: ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
:: FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
:: details.
::
:: You should have received a copy of the GNU General Public License
:: along with this program.  If not, see <http://www.gnu.org/licenses/>.
::-----------------------------------------------------------------------------::

:: Check if Qt5.5 is enabled
IF EXIST C:\JTSDK\config\qt55.txt (
SET gccinfo=Mingw 49_32
) ELSE (
SET gccinfo=Mingw 48_32
)

:: START GATHERING VERSION INFO
CLS
ECHO      _ _____ ____  ____  _  __      ___ _____ 
ECHO     ^| ^|_   _/ ___^|^|  _ \^| ^|/ /     / _ \_   _^|
ECHO  _  ^| ^| ^| ^| \___ \^| ^| ^| ^| ' /_____^| ^| ^| ^|^| ^|  
ECHO ^| ^|_^| ^| ^| ^|  ___) ^| ^|_^| ^| . \_____^| ^|_^| ^|^| ^|  
ECHO  \___/  ^|_^| ^|____/^|____/^|_^|\_\     \__\_\^|_^| %version%
ECHO.
ECHO.
ECHO BUILD APPLICATIONS: ^( WSJT-X WSPR-X MAP65 ^)
ECHO -------------------------------------------------------------
ECHO.
ECHO USAGE:  build-^(app_name^) ^(type^)
ECHO.
ECHO  App Names ............^: wsjtx wsprx map65
ECHO  Release Types ........^: rconfig rinstall package
ECHO  Debug Types ..........^: dconfig dinstall
ECHO.
ECHO HELP SCREENS
ECHO -------------------------------------------------------------
ECHO  JTSDK-QT Help, Type ..^: help-qtenv
ECHO  Checkout Help, Type ..^: help-checkout
ECHO  Build Help, Type .....^: help-(app_name)
ECHO  List Options, Type ...^: list-options
ECHO.
ECHO COMPILER INFO ^( %gccinfo% ^)
ECHO -------------------------------------------------------------
g++.exe --version |grep Built |gawk "{print $7}" >g.v & set /p CVER=<g.v & rm g.v
gfortran.exe --version |grep Fortran |gawk "{print $8}" >g.v & set /p GFOR=<g.v & rm g.v
mingw32-make --version |grep Make |gawk "{print $3}" >g.v & set /p GNMK=<g.v & rm g.v
ECHO  C^+^+ ........: %CVER%
ECHO  GFortran ...: %GFOR%
ECHO  GNU Make ...: %GNMK%
ECHO.
ECHO CRITICAL APP INFO
ECHO -------------------------------------------------------------
asciidoctor --version |grep "asciidoctor" |awk "{print $2}" >a.v & set /p ADV=<a.v & rm a.v
cmake --version |gawk "{print $3}" >c.m & set /p CMV=<c.m & rm c.m
cpack --version |gawk "{print $3}" >c.p & set /p CPV=<c.p & rm c.p
qmake --version |gawk "FNR==2 {print $4}" >q.m & set /p QTV=<q.m & rm q.m
qmake --version |gawk "FNR==1 {print $3}" >q.m & set /p QMV=<q.m & rm q.m
makensis.exe /VERSION  >n.m & set /p NSM=<n.m & rm n.m
pkg-config --version >p.c & set /p PKG=<p.c & rm p.c
ECHO  Asciidoctor..: %ADV%
ECHO  Cmake .......: %CMV%
ECHO  Cpack .......: %CPV%
ECHO  QT5 .........: %QTV%
ECHO  QMake .......: %QMV%
ECHO  NSIS ........: %NSM%
ECHO  InnoSetup ...: 5.5.5a
ECHO  Pkg-Cfg .....: %PKG%
ECHO.
GOTO EOF

:: END QTENV-INFO.BAT
:EOF
EXIT /B 0
