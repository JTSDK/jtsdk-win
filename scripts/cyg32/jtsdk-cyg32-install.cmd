::-----------------------------------------------------------------------------::
:: Name .........: jtsdk-cyg32-install.cmd
:: Project ......: Part of the JTSDK v2.0.0 Project
:: Description ..: Unattended Installation of C:\JTSDK\cyg32
:: Project URL ..: http://sourceforge.net/projects/wsjt/ 
:: Usage ........: This file is called from postinstall-update.cmd
::
:: Author .......: Greg, Beam, KI7MT, <ki7mt@yahoo.com>
:: Copyright ....: Copyright (C) 2014 Joe Taylor, K1JT
:: License ......: GPL-3
::
:: jtsdk-cyg32-install.cmd is free software: you can redistribute it and/or modify it
:: under the terms of the GNU General Public License as published by the Free
:: Software Foundation either version 3 of the License, or (at your option) any
:: later version. 
::
:: jtsdk-cyg32-install.cmd is distributed in the hope that it will be useful, but
:: WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
:: or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
:: more details.
::
:: You should have received a copy of the GNU General Public License
:: along with this program.  If not, see <http://www.gnu.org/licenses/>.
::-----------------------------------------------------------------------------::

@ECHO OFF
COLOR 0E
TITLE JTSDK-DOC Installation
SET LANG=en_US

:: SET VARIABLES
SET based=C:\JTSDK
SET cyinstaller=cyg32-setup-x86.exe
SET cyarch=x86
SET cyinstalld=%based%\cyg32
SET cypkgd=%based%\scripts\cyg32\downloads
SET cysite=http://mirrors.kernel.org/sourceware/cygwin/
REM SET cysite=http://cygwin.mirrors.pair.com/   <-- ALternate DL Site
SET cyopt=-B -q -D -L -X -g -N -d -o
SET cypkgs=mintty,python,subversion,dialog,ncurses,source-highlight,python-pygments,most,rsync,wget,openssh,sqlite3,libsqlite3_0
SET PATH=%based%;%WINDIR%\System32

:: START INSTALL
IF NOT EXIST %based%\scripts\cyg32\NUL (
SET ERRORLEVEL=Script Directory Not Found
ECHO ..Could not find script directory.
ECHO ..Cyg32 ^*WILL NOT^* be installed
GOTO ERROR1
)

CD /D %based%\scripts\cyg32
CLS
ECHO ------------------------------------------------------
ECHO  Installing JTSDK-DOC ^( Cygwin x86 ^)
ECHO ------------------------------------------------------

:: INSTALL DIRECTORY CHECK
IF NOT EXIST %cyinstalld%\NUL (
ECHO ..Added Directory: %cyinstalld% 
MKDIR %cyinstalld% 2> NUL
)

:: PACKAGE DIRECTORY CHECK
IF NOT EXIST %cypkgd%\NUL (
ECHO ..Added Directory: %cypkgd% 
MKDIR %cypkgd% 2> NUL
)

:: RUN THE CYGWIN INSTALLER
ECHO ..Sending Preset Parameters to Installer
%cyinstaller% %cyopt% -a %cyarch% -s %cysite% -l "%cypkgd%" -R "%cyinstalld%" -P %cypkgs% >nul
IF ERRORLEVEL 1 GOTO INSTALLERROR
GOTO CHECK

:: QUICK CHECK ( Needs Improvement )
:CHECK
IF EXIST %cyinstalld%\Cygwin.bat (
GOTO EOF
) ELSE (
SET ERRORLEVEL=Cygwin Installation Failed
GOTO INSTALLERROR
)

:INSTALLERROR
ECHO.
ECHO --------------------------------------
ECHO    *** Cygwin Install Failure ***   
ECHO --------------------------------------
ECHO.
ECHO  If you aborted the install script
ECHO  you will need to re-run the setup.
ECHO.
ECHO  If the problem presists, contact the
ECHO  Dev-Team for further assistance
ECHO.
ECHO  Error Status: %ERRORLEVEL%
ECHO.
EXIT /B 1

:ERROR1
CD /D %based%
ECHO ..Exiting with error: %ERRORLEVEL%
EXIT /B 1
CLS

:EOF
ECHO ..Finished JTSDK-DOC Installation ^( Cygwin x86 ^)
ECHO.
CD /D %based%
EXIT /B 0
CLS