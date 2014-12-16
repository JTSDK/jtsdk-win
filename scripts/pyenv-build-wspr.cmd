::-----------------------------------------------------------------------------::
:: Name .........: pyenv-build-wspr.cmd
:: Project ......: Part of the JTSDK v2.0.0 Project
:: Description ..: Build both WSJT and WSPR from source
:: Project URL ..: http://sourceforge.net/projects/wsjt/ 
:: Usage ........: This file is run from within pyenv.bat
::
:: Author .......: Greg, Beam, KI7MT, <ki7mt@yahoo.com>
:: Copyright ....: Copyright (C) 2014 Joe Taylor, K1JT
:: License ......: GPL-3
::
:: pyenv-build-wspr.cmd is free software: you can redistribute it and/or modify it
:: under the terms of the GNU General Public License as published by the Free
:: Software Foundation either version 3 of the License, or (at your option) any
:: later version. 
::
:: pyenv-build-wpsr.cmd is distributed in the hope that it will be useful, but WITHOUT
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
SET LIBRARY_PATH=""
SET based=C:\JTSDK
SET srcd=%based%\src
SET tools=%based%\tools\bin
SET mgw=%based%\mingw32\bin
SET inno=%based%\inno5
SET scr=%based%\scripts
SET python_home=%based%\Python33;%based%\Python33\Scripts;%based%\Python33\DLLs
SET SVND=%based%\subversion\bin
SET PATH=%based%;%mgw%;%python_home%;%tools%;%srcd%;%inno%;%scr%;%svnd%;%WINDIR%\System32

:: VARS USED IN PROCESS
SET JJ=%NUMBER_OF_PROCESSORS%
SET make=C:\JTSDK\mingw32\bin\mingw32-make %*
SET CP=%tools%\cp.exe
SET MV=%tools%\mv.exe
SET app_name=wspr
SET app_src=%srcd%\wspr
SET installdir=%based%\wspr\install
SET packagedir=%based%\wspr\package
GOTO WSPR_OPTIONS

:: WSPR TARGETS
:WSPR_OPTIONS
IF /I [%1]==[] (
SET all-target=1
GOTO BUILD_INSTALL
) ELSE IF /I [%1]==[install] (
SET all-target=1
GOTO BUILD_INSTALL
) ELSE IF /I [%1]==[package] (
SET pgk-target=1
GOTO BUILD_PACKAGE
) ELSE IF /I [%1]==[wspr0] (
SET target=wspr0.exe
GOTO BUILD_TARGET
) ELSE IF /I [%1]==[WSPRcode] (
SET target=WSPRcode.exe
GOTO BUILD_TARGET
) ELSE IF /I [%1]==[libwspr] (
SET target=libwspr.a
GOTO BUILD_TARGET
) ELSE IF /I [%1]==[fmtest] (
SET target=fmtest.exe
GOTO BUILD_TARGET
) ELSE IF /I [%1]==[fmtave] (
SET target=fmtave.exe
GOTO BUILD_TARGET
)  ELSE IF /I [%1]==[fcal] (
SET target=fcal.exe
GOTO BUILD_TARGET
) ELSE IF /I [%1]==[fmeasure] (
SET target=fmeasure.exe
GOTO BUILD_TARGET
) ELSE IF /I [%1]==[sound] (
SET target=sound.o
GOTO BUILD_TARGET
) ELSE IF /I [%1]==[gmtime2] (
SET target=sound.o
GOTO BUILD_TARGET
) ELSE IF /I [%1]==[w.pyd] (
SET target=WsprMod/w.pyd
GOTO BUILD_TARGET
) ELSE ( GOTO UNSUPPORTED_TARGET )

:: ------------------------------------------------------------------------------
:: -- START MAIN SCRIPT --
:: ------------------------------------------------------------------------------

:: IF SRCD EXISTS, CHECK FOR PREVIOUS CO
IF NOT EXIST %app_src%\.svn\NUL ( mkdir %based%\src
GOTO COMSG
) ELSE ( GOTO START_BUILD )
IF DEFINED all-target  GOTO BUILD_INSTALL )
IF DEFINED pkg-target ( GOTO BUILD_PACKAGE ) ELSE ( GOTO BUILD_TARGET )

:BUILD_INSTALL
CD /D %app_src%
CLS
ECHO -----------------------------------------------------------------
ECHO   Starting Build for ^( Install ^)
ECHO -----------------------------------------------------------------
ECHO.
ECHO ..Running make clean first ...
mingw32-make -f Makefile.jtsdk2 clean > NUL 2>&1
ECHO ..Running mingw32-make To Build ^( install ^) Target
ECHO.
mingw32-make -f Makefile.jtsdk2
IF ERRORLEVEL 1 ( GOTO BUILD_ERROR )
ECHO.
GOTO REV_NUM

:BUILD_PACKAGE
CD /D %app_src%
CLS
ECHO -----------------------------------------------------------------
ECHO   Starting Build for ^( Package ^)
ECHO -----------------------------------------------------------------
ECHO.
ECHO ..Running make clean first .. 
mingw32-make -f Makefile.jtsdk2 clean > NUL 2>&1
ECHO ..Running mingw32-make To Build ^( package ^) Target
ECHO.
mingw32-make -f Makefile.jtsdk2 %TARGET%
IF ERRORLEVEL 1 ( GOTO BUILD_ERROR )
GOTO REV_NUM

:: BEGIN WSJT MAIN BUILD
:BUILD_TARGET
CD /D %app_src%
CLS
ECHO -----------------------------------------------------------------
ECHO   Starting Build for ^( %TARGET% ^)
ECHO -----------------------------------------------------------------
ECHO.
ECHO ..Running mingw32-make To Build ^( %TARGET% ^)
ECHO.
mingw32-make -f Makefile.jtsdk2 %TARGET%
IF ERRORLEVEL 1 ( GOTO BUILD_ERROR )
GOTO SINGLE_FINISH

:: GET SVN r NUMBER, STILL in %app_src%
:REV_NUM
ECHO ..Getting SVN version number
svn -qv status %app_name%.py |gawk "{print $2}" > r.txt
SET /P VER=<r.txt & rm r.txt
ECHO ..Copying files to install directory
IF EXIST %based%\%app_name%\%app_name%-r%ver% ( 
rm -r %based%\%app_name%\%app_name%-r%ver% )
XCOPY %installdir% %based%\%app_name%\%app_name%-r%ver% /I /E /Y /q >/nul
IF ERRORLEVEL 0 ( GOTO MAKEBAT ) ELSE ( GOTO COPY_ERROR )

:: GENERATE RUNTIME BATCH FILE
:MAKEBAT
CD /D %based%\%app_name%\%app_name%-r%ver%
ECHO ..Generating Batch File
IF EXIST %app_name%.bat (DEL /Q %app_name%.bat)
>%app_name%.bat (
ECHO @ECHO OFF
ECHO REM -- WSJT-WSPR batch File
ECHO REM -- Part of the JTSDK Project
ECHO COLOR 0A
ECHO bin\%app_name%.exe
ECHO EXIT /B 0
)
GOTO FINISHED

:: FINISHED INSTALL OR PACKAGE TARGET BUILD
:FINISH_PACKAGE
ECHO ..Copying build files
IF EXIST %based%\%app_name%\%app_name%-r%ver% ( 
rm -r %based%\%app_name%\%app_name%-r%ver% )
XCOPY %installdir% %based%\%app_name%\%app_name%-r%ver% /I /E /Y /q >nul
IF ERRORLEVEL 1 ( GOTO BUILD_ERROR )
ECHO ..Finisned InnoSetup
ECHO ..Exit Status: ^( %ERRORLEVEL% ^) is OK
GOTO FINISHED

:: FINISHED INSTALL OR PACKAGE TARGET BUILDS
:SINGLE_FINISH
ECHO.
ECHO ..Finished building Target ^( %target% ^) 
ECHO.
GOTO EOF

:: FINISHED INSTALL OR PACKAGE TARGET BUILDS
:FINISHED
ECHO.
ECHO -----------------------------------------------------------------
ECHO   BUILD COMPLETE ^( %app_name%-r%ver% ^) 
ECHO -----------------------------------------------------------------
ECHO.
IF DEFINED all-targert (
ECHO  Source Dir ...: %app_src%
ECHO  Install Dir ..: %installdir%
ECHO  Batch File ...: %based%\%app_name%\%app_name%-r%ver%\%app_name%.bat
GOTO ASKRUN
)
IF DEFINED pkg-target (
ECHO  Source Dir ...: %app_src%
ECHO  Install Dir ..: %installdir%
ECHO  Package Dir ..: %packagedir%
GOTO EOF
)

:: ASK USER IF THEY WANT TO RUN THE APP
:ASKRUN
ECHO.
ECHO  Would You Like To Run %app_name% Now? ^( y/n ^)
ECHO.
SET ANSWER=
SET /P ANSWER=Type Response: %=%
ECHO.
If /I "%ANSWER%"=="Y" GOTO RUN_APP
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
CD %based%\%app_name%\%app_name%-r%ver%
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
ECHO  Please Use JTSDK-PY Enviroment
ECHO.
ECHO    %based%\jtsdk-pyenv.bat
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

:: FINAL FOLDER CREATION ERROR MESSAGE
:COPY_ERROR
ECHO.
ECHO -----------------------------------------------------------------
ECHO   Error Creating ^( %app_name%-r%ver% ^)
ECHO -----------------------------------------------------------------
ECHO. 
ECHO  An error occured when trying to copy the build to it's final
ECHO  location: C:\JTSDK\%app_name%\%app_name%-r%ver%
ECHO.
ECHO  If the probblems continues, please contact the wsjt-dev group.
ECHO.
COLOR 0A
ENDLOCAL
EXIT /B %ERRORLEVEL%

REM ----------------------------------------------------------------------------
REM  END OF PYENV-BUILD>BAT
REM ----------------------------------------------------------------------------
:EOF
CD /D %based%
ENDLOCAL

EXIT /B 0
