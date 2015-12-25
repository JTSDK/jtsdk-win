::----------------------------------------------------------------------------::
:: Name .........: update.cmd
:: Project ......: Part of the JTSDK v2.0 Project
:: Description ..: Update script
:: Project URL ..: http://sourceforge.net/projects/jtsdk
:: Usage ........: Run this file from the JTSDK Start Menu
::
:: Author .......: Greg, Beam, KI7MT, <ki7mt@yahoo.com>
:: Copyright ....: Copyright (C) 2014-2016 Joe Taylor, K1JT
:: License ......: GPL-3
::
:: update.cmd is free software: you can redistribute it and/or
:: modify it under the terms of the GNU General Public License as published by
:: the Free Software Foundation either version 3 of the License, or (at your
:: option) any later version. 
::
:: update.cmd is distributed in the hope that it will be useful, but
:: WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
:: or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
:: more details.
::
:: You should have received a copy of the GNU General Public License
:: along with this program.  If not, see <http://www.gnu.org/licenses/>.
::----------------------------------------------------------------------------::

@ECHO OFF
COLOR 0E
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
TITLE JTSDK UPDATE and UPGRADE
SET based=C:\JTSDK
SET svnd=%based%\subversion\bin
SET url="http://svn.code.sf.net/p/jtsdk/jtsdk/jtsdk-win/updates/postinstall.cmd"
SET PATH=%based%;%svnd%

:: START JTSDK UPDATE / UPGRADE
CD /D %based%
START /wait %svnd%\svn.exe cleanup
START /wait %svnd%\svn.exe export --force %url1% >nul 2>&1
CALL postinstall.cmd upgrade
ENDLOCAL
EXIT /B 0