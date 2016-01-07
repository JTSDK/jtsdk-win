::-----------------------------------------------------------------------------::
:: Name .........: maint.cmd
:: Project ......: Part of the JTSDK v2.0 Project
:: Description ..: Maintenance script for general use
:: Project URL ..: http://sourceforge.net/projects/jtsdk
:: Usage ........: Run this file directly, or from the Windows Start Menu
::
:: Author .......: Greg, Beam, KI7MT, <ki7mt@yahoo.com>
:: Copyright ....: Copyright (C) 2014-2016 Joe Taylor, K1JT
:: License ......: GPL-3
::
:: maint.cmd is free software: you can redistribute it and/or
:: modify it under the terms of the GNU General Public License as published by
:: the Free Software Foundation either version 3 of the License, or (at your
:: option) any later version. 
::
:: maint.cmd is distributed in the hope that it will be useful, but
:: WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
:: or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
:: more details.
::
:: You should have received a copy of the GNU General Public License
:: along with this program.  If not, see <http://www.gnu.org/licenses/>.
::-----------------------------------------------------------------------------::

@ECHO OFF
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
COLOR 0E
SET LANG=en_US

SET /P version=<version.jtsdk
SET based=C:\JTSDK
SET tools=%based%\tools\bin
SET svnd=%based%\subversion\bin
SET rubyd=%based%\Ruby\bin
SET url1="http://svn.code.sf.net/p/jtsdk/jtsdk/jtsdk-win/updates/postinstall.cmd"
SET PATH=%based%;%svnd%;%tools%;%rubyd%;%WINDIR%\System32

:: Full paths are needed for some versions of Windows
:: Why some are and others are not, is still unknown.
%svnd%\svn.exe info |%tools%\grep.exe "Rev:" |%tools%\awk.exe "{print $4}" >r.v & set /p rev=<r.v & %tools%\rm.exe r.v
SET version=%version%-%rev%
TITLE JTSDK General Maintenance and Upgrades - %version%

:: Power-User Commands, add as many as you like
DOSKEY clear=cls
DOSKEY ls=dir
DOSKEY ss="svn.exe" $* status
DOSKEY sv="svn.exe" $* status ^|grep "?"
DOSKEY sa="svn.exe" $* status ^|grep "A"
DOSKEY sm="svn.exe" $* status ^|grep "M"
DOSKEY sd="svn.exe" $* status ^|grep "D"
DOSKEY log="svn.exe" log -l $*
DOSKEY logv="svn.exe" log -v -l $*

:: UPDATE & UPGRADE COMMANDS
DOSKEY update="%svnd%\svn.exe" $* export --force %url1% >nul 2>&1
DOSKEY upgrade="postinstall.cmd" $* upgrade
DOSKEY version="postinstall.cmd" $* version-info

:: Start Main Script
CD /D %based%
CLS
ECHO -------------------------------------------------------------
ECHO  JTSDK General Maintenance Environment - %version%
ECHO -------------------------------------------------------------
ECHO.
ECHO  ^* Provides Access To: Subversion, Gnu Tools and Asciidoctor
ECHO  ^* Upgrades JTSDK Main Scripts and Packages when needed
ECHO.
ECHO  TO UPDATE and UPGRADE
ECHO   Type .......: update
ECHO   Then Type ..: upgrade
ECHO.
ECHO  TO DISPLAY CURRENT VERSION INFORMATION
ECHO   Type .......: version
ECHO.
ECHO  GENERAL: MAINTENANCE
ECHO   With this env, you have access to all the Gnu
ECHO   Tools, Subversion and Asciidoctor. It can be used
ECHO   to perform most any task needed by the SDK.
ECHO   There are no Tool-Chains or Frameworks ( Qt / Python )
ECHO   in ^*PATH^*
ECHO.

%COMSPEC% /A /Q /K