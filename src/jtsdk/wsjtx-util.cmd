::-----------------------------------------------------------------------------::
:: Name .........: wsjtx-util.bat
:: Project ......: Part of the JTSDK v2.0 Project
:: Description ..: Maintenance Shell for Testing jt9code jt65code
:: Project URL ..: http://sourceforge.net/projects/jtsdk
:: Usage ........: Run this file directly, or from the Windows Start Menu
::
:: Author .......: Greg, Beam, KI7MT, <ki7mt@yahoo.com>
:: Copyright ....: Copyright (C) 2014-2016 Joe Taylor, K1JT
:: License ......: GPL-3
::
:: wsjtx-util.bat is free software: you can redistribute it and/or modify it under
:: the terms of the GNU General Public License as published by the Free Software
:: Foundation either version 3 of the License, or (at your option) any later
:: version. 
::
:: wsjtx-util.bat is distributed in the hope that it will be useful, but
:: WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
:: or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
:: more details.
::
:: You should have received a copy of the GNU General Public License
:: along with this program.  If not, see <http://www.gnu.org/licenses/>.
::-----------------------------------------------------------------------------::

REM -- This file sets the paths for jt9code, jt65code. kvasd or chkfft testing.
REM    It does *not* permanently alter System or User %PATH%. Paths are re-set
REM    by closing the CMD window.

@ECHO OFF
SETLOCAL
COLOR 0B
TITLE WSJT-X Testing Environment

REM -- SETUP PATHS
PATH=.
CLS
ECHO --------------------------------------------------------------
ECHO  Welcome to WSJT-X Testing Utilities
ECHO --------------------------------------------------------------
ECHO.
ECHO  App Names ...: jt9code, jt65code or kvasd
ECHO  Help, type ..: [ app-name ] then ENTER
ECHO.
ECHO  Type ..: jt65code "message"  or  jt65code -t
ECHO  Type ..: jt9code "message"  or  jt9code -t
ECHO  Tpye ..: kvasd -v  or just  kvasd
ECHO.

:: OPEN CMD WINDOW
%COMSPEC% /A /Q /K