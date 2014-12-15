::-----------------------------------------------------------------------------::
:: Name .........: <file-name>
:: Project ......: Part of the JTSDK v2.0.0 Project
:: Description ..: <What Does The File Do >
:: Project URL ..: http://sourceforge.net/projects/jtsdk/
:: Usage ........: <How To Call or Use the file.name>
:: 
:: Author .......: <NAME>, <CALL>, <EMAIL>
:: Copyright ....: Copyright (C) 2014 Joe Taylor, K1JT
:: License ......: GPL-3
::
:: <file-name> is free software: you can redistribute it and/or modify it
:: under the terms of the GNU General Public License as published by the Free
:: Software Foundation either version 3 of the License, or (at your option) any
:: later version. 
::
:: <file-name> is distributed in the hope that it will be useful, but WITHOUT
:: ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
:: FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
:: details.
::
:: You should have received a copy of the GNU General Public License
:: along with this program.  If not, see <http://www.gnu.org/licenses/>.
::-----------------------------------------------------------------------------::

:: Windows Commands and Variables are in Upper Case <CAPS>
:: User defined variables are in lower case

:: ENVIRONMENT
@ECHO OFF
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION
SET LANG=en_US
:: SET COLOR TO YOUR LIKING
 COLOR 0A

:: TEST DOUBLE CLICK, if YES, GOTO ERROR MESSAGE
FOR %%x IN (%cmdcmdline%) DO IF /I "%%~x"=="/c" SET gui=1
IF DEFINED gui CALL GOTO double_click_error


:: PATH VARIABLES
SET based=C:\JTSDK
:: <additional-paths>
SET PATH=%based%;%<additional-paths>%;%WINDIR%\System32
GOTO FUNCTOIN_1


:: DO SOMETING
:function_1
ECHO Do something
GOTO function_2


:: DO SOMETHIGN ELSE
:function_2
ECHO Do something else
GOTO EOF


:: END OF <FILE-NAME>
:eof
CD /D %based%
ENDLOCAL

EXIT /B 0
