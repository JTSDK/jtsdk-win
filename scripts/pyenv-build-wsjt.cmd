::-----------------------------------------------------------------------------::
:: Name .........: pyenv-build-wsjt.cmd
:: Project ......: Part of the JTSDK v2.0.0 Project
:: Description ..: Build WSJT from source
:: Project URL ..: http://sourceforge.net/projects/wsjt/ 
:: Usage ........: This file is run from within pyenv.bat
::
:: Author .......: Greg, Beam, KI7MT, <ki7mt@yahoo.com>
:: Copyright ....: Copyright (C) 2014 Joe Taylor, K1JT
:: License ......: GPL-3
::
:: pyenv-build-wsjt.cmd is free software: you can redistribute it and/or modify it
:: under the terms of the GNU General Public License as published by the Free
:: Software Foundation either version 3 of the License, or (at your option) any
:: later version. 
::
:: pyenv-build-wsjt.cmd is distributed in the hope that it will be useful, but WITHOUT
:: ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
:: FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
:: details.
::
:: You should have received a copy of the GNU General Public License
:: along with this program.  If not, see <http://www.gnu.org/licenses/>.
::-----------------------------------------------------------------------------::

:: ENVIRONMENT
@ECHO OFF
SET LANG=en_US
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
COLOR 0A

:: TEST DOUBLE CLICK, if YES, GOTO ERROR MESSAGE
FOR %%x IN (%cmdcmdline%) DO IF /I "%%~x"=="/c" SET GUI=1
IF DEFINED GUI CALL GOTO DCLICK

:: PATH VARIABLES
SET LANG=en_US
SET LIBRARY_PATH=
SET based=C:\JTSDK
SET srcd=%based%\src
SET tools=%based%\tools\bin
SET mgw=%based%\mingw32\bin
SET inno=%based%\inno5
SET scr=%based%\scripts
SET python_home=%based%\Python33;%based%\Python33\Scripts;%based%\Python33\DLLs
SET svnd=%based%\subversion\bin
SET PATH=%based%;%mgw%;%python_home%;%tools%;%srcd%;%inno%;%scr%;%svnd%;%WINDIR%\System32

:: VARS USED IN PROCESS
SET JJ=%NUMBER_OF_PROCESSORS%
SET CP=%tools%\cp.exe
SET MV=%tools%\mv.exe
SET app_name=wsjt
SET app_src=%srcd%\trunk
SET installdir=%based%\wsjt\install
SET packagedir=%based%\wsjt\package

:: IF SRCD EXISTS, CHECK FOR PREVIOUS CO
CLS
IF NOT EXIST %app_src%\.svn\NUL (
mkdir %based%\src
GOTO COMSG
) ELSE (GOTO ASK_SVN)

:: START WSJT BUILD
:ASK_SVN
CLS
ECHO Update from SVN Before Building? ^( y/n ^)
SET ANSWER=
ECHO.
SET /P answer=Type Response: %=%
If /I "%answer%"=="N" GOTO WSJT_OPTIONS
If /I "%answer%"=="Y" (
GOTO SVN_UPDATE
) ELSE (
ECHO.
ECHO Please Answer With: ^( Y or N ^)
GOTO ASK_SVN
)

:: UPDATE WSJT FROM SVN
:SVN_UPDATE
ECHO.
ECHO UPDATING ^( %app_src% ^ )
CD /D %app_src%
start /wait svn update
GOTO WSJT_OPTIONS

:: WSJT TARGETS
:WSJT_OPTIONS
IF /I [%1]==[] (
SET all-target=1
SET target=install
GOTO BUILD_INSTALL
) ELSE IF /I [%1]==[install] (
SET all-target=1
SET target=install
GOTO BUILD_INSTALL
) ELSE IF /I [%1]==[package] (
SET pkg-target=1
SET target=package
GOTO BUILD_PACKAGE
) ELSE IF /I [%1]==[clean] (
GOTO BUILD_CLEAN
) ELSE IF /I [%1]==[distclean] (
GOTO BUILD_DISTCLEAN
) ELSE IF /I [%1]==[libjt] (
SET target=libjta
GOTO BUILD_TARGET
) ELSE IF /I [%1]==[jt65code] (
SET target=jt65code.exe
GOTO BUILD_TARGET
) ELSE IF /I [%1]==[jt4code] (
SET target=jt4code.exe
GOTO BUILD_TARGET
) ELSE IF /I [%1]==[audio.pyd] (
SET target=WsjtMod/Audio.pyd
GOTO BUILD_TARGET
) ELSE ( GOTO UNSUPPORTED_TARGET )

:: ------------------------------------------------------------------------------
:: -- START MAIN SCRIPT --
:: ------------------------------------------------------------------------------

::BUILD_CLEAN
:BUILD_CLEAN
CD /D %app_src%
CLS
ECHO -----------------------------------------------------------------
ECHO   Clean Targets for ^( %app_name% ^)
ECHO -----------------------------------------------------------------
ECHO.
ECHO ..Running mingw32-make clean
mingw32-make -f Makefile.jtsdk2 clean > NUL 2>&1
ECHO ..Finished
GOTO EOF

::BUILD_DISTCLEAN
:BUILD_DISTCLEAN
CD /D %app_src%
CLS
ECHO -----------------------------------------------------------------
ECHO   Distclean Targets for ^( %app_name% ^)
ECHO -----------------------------------------------------------------
ECHO.
ECHO ..Running mingw32-make distclean
mingw32-make -f Makefile.jtsdk2 distclean > NUL 2>&1
ECHO ..Finished
GOTO EOF

:BUILD_INSTALL
CD /D %app_src%
CLS
ECHO -----------------------------------------------------------------
ECHO   Starting Install Build for ^( %app_name% ^)
ECHO -----------------------------------------------------------------
ECHO.
ECHO ..Running mingw32-make clean
mingw32-make -f Makefile.jtsdk2 clean > NUL 2>&1
ECHO ..Running mingw32-make all
ECHO.
mingw32-make -f Makefile.jtsdk2
IF ERRORLEVEL 1 ( GOTO BUILD_ERROR )
mingw32-make -f Makefile.jtsdk2 install
IF ERRORLEVEL 1 ( GOTO BUILD_ERROR )
GOTO MAKEBAT

:BUILD_PACKAGE
CD /D %app_src%
CLS
ECHO -----------------------------------------------------------------
ECHO   Starting Package Build for ^( %app_name% ^)
ECHO -----------------------------------------------------------------
ECHO.
ECHO ..Running mingw32-make distclean
mingw32-make -f Makefile.jtsdk2 distclean > NUL 2>&1
ECHO ..Running mingw32-make all
ECHO.
mingw32-make -f Makefile.jtsdk2
IF ERRORLEVEL 1 ( GOTO BUILD_ERROR )
mingw32-make -f Makefile.jtsdk2 install
IF ERRORLEVEL 1 ( GOTO BUILD_ERROR )
GOTO MAKEBAT

:: BEGIN WSJT MAIN BUILD
:BUILD_TARGET
CD /D %app_src%
CLS
ECHO -----------------------------------------------------------------
ECHO   Starting Build for Target^( %target% ^)
ECHO -----------------------------------------------------------------
ECHO.
ECHO ..Running mingw32-make To Build ^( %target% ^)
ECHO.
mingw32-make -f Makefile.jtsdk2 %target%
IF ERRORLEVEL 1 ( GOTO BUILD_ERROR )
GOTO SINGLE_FINISH

:: GENERATE RUNTIME BATCH FILE
:MAKEBAT
CD /D %installdir%
IF EXIST %app_name%.bat (DEL /Q %app_name%.bat)
>%app_name%.bat (
ECHO @ECHO OFF
ECHO REM -- WSJT batch File
ECHO REM -- Part of the JTSDK v2.0 Project
ECHO COLOR 0A
ECHO bin\%app_name%.exe
ECHO EXIT /B 0
)
IF DEFINED pkg-target (
CD /D %app_src%
mingw32-make -f Makefile.jtsdk2 package
IF ERRORLEVEL 1 ( GOTO BUILD_ERROR )
ECHO.
GOTO FINISH
)
GOTO FINISH

:: FINISHED INSTALL OR PACKAGE TARGET BUILDS
:SINGLE_FINISH
ECHO.
ECHO ..Finished building Target ^( %target% ^) 
ECHO.
GOTO EOF

:: FINISHED INSTALL OR PACKAGE TARGET BUILDS
:FINISH
IF DEFINED all-target ( GOTO ASKRUN )
GOTO EOF

:: ASK USER IF THEY WANT TO RUN THE APP
:ASKRUN
ECHO.
ECHO  Would You Like To Run %app_name% Now? ^( y/n ^)
ECHO.
SET answer=
SET /P answer=Type Response: %=%
ECHO.
If /I "%answer%"=="Y" GOTO RUN_APP
If /I "%ANSWER%"=="N" (
GOTO EOF
) ELSE (
ECHO.
ECHO ..Please Answer With: ^( y or n ^) & ECHO. & GOTO ASKRUN
)
GOTO EOF

:: RUN THE APP IFF USER ANSWERED YES ABOVE
:RUN_APP
ECHO.
ECHO ..Starting: ^( %app_name% ^)
CD /D %installdir%
START %app_name%.bat & GOTO EOF

REM ----------------------------------------------------------------------------
REM  MESSAGE SECTION
REM ----------------------------------------------------------------------------

:: USER INPUT INCORRECT BUILD TARGET
:UNSUPPORTED_TARGET
CLS
ECHO.
ECHO -----------------------------------------------------------------
ECHO   ^( %1 ^) IS AN INVALID TARGET
ECHO -----------------------------------------------------------------
ECHO. 
ECHO  After the pause, the build help menu
ECHO  will be displayed. Please use the syntax
ECHO  as outlined and choose the correct
ECHO  target to build.
ECHO.
PAUSE
CALL %scr%\help\pyenv-help-%app_name%.cmd
GOTO EOF

:: DISPLAY DOUBLE CLICK WARNING MESSAGE
:DCLICK
@ECHO OFF
CLS
ECHO -------------------------------
ECHO     DOUBLE CLICK WARNING
ECHO -------------------------------
ECHO.
ECHO  Please Use JTSDK Enviroment
ECHO.
ECHO         pyenv.cmd
ECHO.
PAUSE
GOTO EOF

:: DISPLAY SRC DIRECTORY WAS NOT FOUND, e.g. NO CHECKOUT FOUND
:COMSG
CLS
ECHO ----------------------------------------
ECHO  %app_src% Was Not Found
ECHO ----------------------------------------
ECHO.
ECHO  In order to build ^( %app_name% ^) you
ECHO  must first perform a checkout from 
ECHO  SourceForge
ECHO.
ECHO  After the pause, the checkout help menu
ECHO  will be displayed.
ECHO.
PAUSE
CALL %based%\scripts\help\pyenv-help-checkout.cmd
GOTO EOF

:: DISPLAY COMPILER BUILD WARNING MESSAGE
:BUILD_ERROR
ECHO.
ECHO -----------------------------------------------------------------
ECHO   Compiler Build Warning
ECHO -----------------------------------------------------------------
ECHO. 
ECHO  mingw32-make exited with a non-(0) build status. Check and or 
ECHO  correct the error, perform a clean, then re-make the target.
ECHO.
ECHO.
EXIT /B %ERRORLEVEL%

REM ----------------------------------------------------------------------------
REM  END OF PYENV-BUILD>BAT
REM ----------------------------------------------------------------------------
:EOF
CD /D %based%
ENDLOCAL

EXIT /B 0
