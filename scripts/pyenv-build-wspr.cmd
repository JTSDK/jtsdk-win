::-----------------------------------------------------------------------------::
:: Name .........: pyenv-wspr.bat
:: Project ......: Part of the JTSDK v2.0.0 Project
:: Description ..: Build both WSJT and WSPR from source
:: Project URL ..: http://sourceforge.net/projects/wsjt/ 
:: Usage ........: This file is run from within pyenv.bat
::
:: Author .......: Greg, Beam, KI7MT, <ki7mt@yahoo.com>
:: Copyright ....: Copyright (C) 2014 Joe Taylor, K1JT
:: License ......: GPL-3
::
:: pyenv-wspr.bat is free software: you can redistribute it and/or modify it
:: under the terms of the GNU General Public License as published by the Free
:: Software Foundation either version 3 of the License, or (at your option) any
:: later version. 
::
:: pyenv-build.bat is distributed in the hope that it will be useful, but WITHOUT
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
SET BASED=C:\JTSDK
SET SRCD=%BASED%\src
SET TOOLS=%BASED%\tools\bin
SET MGW=%BASED%\mingw32\bin
SET INNO=%BASED%\inno5
SET SCR=%BASED%\scripts
SET PYP=%BASED%\Python33
SET PYS=%BASED%\Python33\Scripts
SET PYD=%BASED%\Python33\DLLs
SET SVND=%BASED%\subversion\bin
SET PATH=%BASED%;%MGW%;%PYP%;%PYS%;%PYD%;%TOOLS%;%SRCD%;%INNO%;%SCR%;%SVND%;%WINDIR%\System32

:: VARS USED IN PROCESS
SET JJ=%NUMBER_OF_PROCESSORS%
SET CP=%TOOLS%\cp.exe
SET MV=%TOOLS%\mv.exe
SET APP_NAME=wspr
SET APP_SRC=%SRCD%\wspr
SET INSTALLDIR=%BASED%\wspr\install
SET PACKAGEDIR=%BASED%\wspr\package
GOTO WSPR_OPTIONS

:WSPR_OPTIONS
IF /I [%1]==[] (
SET TARGET=install
GOTO START
) ELSE IF /I [%1]==[install] (
SET TARGET=install
GOTO START
) ELSE IF /I [%1]==[package] (
SET TARGET=package
GOTO START
) ELSE IF /I [%1]==[wspr0] (
SET TARGET=wspr0.exe
GOTO START
) ELSE IF /I [%1]==[WSPRcode] (
SET TARGET=WSPRcode.exe
GOTO START
) ELSE IF /I [%1]==[libwspr] (
SET TARGET=libwspr.a
GOTO START
) ELSE IF /I [%1]==[fmtest] (
SET TARGET=fmtest.exe
GOTO START
) ELSE IF /I [%1]==[fmtave] (
SET TARGET=fmtave.exe
GOTO START
)  ELSE IF /I [%1]==[fcal] (
SET TARGET=fcal.exe
GOTO START
) ELSE IF /I [%1]==[fmeasure] (
SET TARGET=fmeasure.exe
GOTO START
) ELSE IF /I [%1]==[sound] (
SET TARGET=sound.o
GOTO START
) ELSE IF /I [%1]==[gmtime2] (
SET TARGET=sound.o
GOTO START
) ELSE IF /I [%1]==[w.pyd] (
SET TARGET=WsprMod/w.pyd
GOTO START
) ELSE ( GOTO UNSUPPORTED_TARGET )

:: ------------------------------------------------------------------------------
:: -- START MAIN SCRIPT --
:: ------------------------------------------------------------------------------

:: START MAIN BUILD
:START
CD %BASED%
CLS
ECHO -----------------------------------------------------------------
ECHO   Starting Build for ^( %APP_NAME% %TARGET% Target ^)
ECHO -----------------------------------------------------------------
ECHO.

:: IF SRCD EXISTS, CHECK FOR PREVIOUS CO
IF NOT EXIST %APP_SRC%\.svn\NUL (
mkdir %BASED%\src
GOTO COMSG
) ELSE (GOTO ASK_SVN)

:: START WSPR BUILD
:ASK_SVN
ECHO Update from SVN Before Building? ^( y/n ^)
SET ANSWER=
ECHO.
SET /P ANSWER=Type Response: %=%
If /I "%ANSWER%"=="N" GOTO START_BUILD
If /I "%ANSWER%"=="Y" (
GOTO SVN_UPDATE
) ELSE (
ECHO.
ECHO Please Answer With: ^( Y or N ^)
GOTO ASK_SVN
)

:: UPDATE WSJT FROM SVN
:SVN_UPDATE
ECHO.
ECHO UPDATING ^( %APP_SRC% ^ )
cd %APP_SRC%
start /wait svn update
GOTO START_BUILD

:: START MAIN BUILD PROCESS
:START_BUILD
ECHO.
IF NOT EXIST %BASED%\%APP_NAME%\NUL ( mkdir %BASED%\%APP_NAME% )
CD /D %APP_SRC%
ECHO ..Performing make clean first
mingw32-make -f Makefile.jtsdk2 clean >nul 2>&1
ECHO ..Running mingw32-make To Build ^( %TARGET% ^) Target
ECHO.
mingw32-make -f Makefile.jtsdk2 %TARGET%
ECHO.
IF ERRORLEVEL 1 ( GOTO BUILD_ERROR )

ECHO -----------------------------------------------------------------
ECHO   MAKEFILE EXIT STATUS: ^( %ERRORLEVEL% ^) is OK
ECHO -----------------------------------------------------------------
ECHO.

IF /I [%TARGET%]==[install] (
GOTO REV_NUM
) ELSE IF /I [%TARGET%]==[package] ( 
GOTO MAKE_PACKAGE
) ELSE ( GOTO SINGLE_FINISHED )

:: BEGIN WSJT MAIN BUILD
:MAKE_PACKAGE
CD /D %APP_SRC%
ECHO.
ECHO..Running InnoSetup for: ^( %APP_NAME% ^)
mingw32-make -s -f Makefile.jtsdk2 package
IF ERRORLEVEL 1 ( GOTO BUILD_ERROR )
GOTO REV_NUM

:: GET SVN r NUMBER, STILL in %APP_SRC%
:REV_NUM
ECHO ..Getting SVN version number
svn -qv status %APP_NAME%.py |gawk "{print $2}" > r.txt
SET /P VER=<r.txt & rm r.txt

:: PACKAGE JUST NEEDS THE SVN NUMBER FOR FOLDER NAME
IF /I [%TARGET%]==[package] ( GOTO PKG_FINISH )
ECHO ..Copying files to install directory
IF EXIST %BASED%\%APP_NAME%\%APP_NAME%-r%VER% ( 
rm -r %BASED%\%APP_NAME%\%APP_NAME%-r%VER% )
XCOPY %INSTALLDIR% %BASED%\%APP_NAME%\%APP_NAME%-r%VER% /I /E /Y /q >/nul
IF ERRORLEVEL 0 ( GOTO MAKEBAT ) ELSE ( GOTO COPY_ERROR )

:: GENERATE RUNTIME BATCH FILE
:MAKEBAT
CD /D %BASED%\%APP_NAME%\%APP_NAME%-r%VER%
ECHO ..Generating Batch File
IF EXIST %APP_NAME%.bat (DEL /Q %APP_NAME%.bat)
>%APP_NAME%.bat (
ECHO @ECHO OFF
ECHO REM -- WSJT-WSPR batch File
ECHO REM -- Part of the JTSDK Project
ECHO COLOR 0A
ECHO bin\%APP_NAME%.exe
ECHO EXIT /B 0
)
GOTO FINISHED

:: SINGLE TARGET BUILD MESSAGE
:SINGLE_FINISHED
ECHO.
ECHO ..Finished Building Target ^( %TARGET% ^)
ECHO.
GOTO EOF

:: FINISHED INSTALL OR PACKAGE TARGET BUILD
:PKG_FINISH
ECHO ..Copying build files
IF EXIST %BASED%\%APP_NAME%\%APP_NAME%-r%VER% ( 
rm -r %BASED%\%APP_NAME%\%APP_NAME%-r%VER% )
XCOPY %INSTALLDIR% %BASED%\%APP_NAME%\%APP_NAME%-r%VER% /I /E /Y /q >nul
IF ERRORLEVEL 1 ( GOTO BUILD_ERROR )
ECHO ..Finisned InnoSetup
ECHO ..Exit Status: ^( %ERRORLEVEL% ^) is OK
GOTO FINISHED

:: FINISHED INSTALL OR PACKAGE TARGET BUILDS
:FINISHED
ECHO.
ECHO -----------------------------------------------------------------
ECHO   ^( %APP_NAME%-r%VER% ^) BUILD COMPLETE
ECHO -----------------------------------------------------------------
ECHO.
ECHO  Source Dir ...: %APP_SRC%
ECHO  Install Dir ..: %BASED%\%APP_NAME%\%APP_NAME%-r%VER%
ECHO  Batch File ...: %BASED%\%APP_NAME%\%APP_NAME%-r%VER%\%APP_NAME%.bat

IF EXIST "%BASED%\%APP_NAME%\package\WSPR-4.0-Win32.exe" ( 
ECHO  Package ......: %BASED%\%APP_NAME%\package\WSPR-4.0-Win32.exe
)
CD /D %BASED%
ECHO.
GOTO ASKRUN

:: ASK USER IF THEY WANT TO RUN THE APP
:ASKRUN
ECHO.
ECHO  Would You Like To Run %APP_NAME% Now? ^( y/n ^)
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
ECHO ..Starting: ^( %APP_NAME% ^)
CD %BASED%\%APP_NAME%\%APP_NAME%-r%VER%
START %APP_NAME%.bat & GOTO EOF

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
CALL %scr%\help\pyenv-help-%APP_NAME%.cmd
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
ECHO    %BASED%\jtsdk-pyenv.bat
ECHO.
PAUSE
GOTO EOF

:: DISPLAY SRC DIRECTORY WAS NOT FOUND, e.g. NO CHECKOUT FOUND
:COMSG
CLS
ECHO ----------------------------------------
ECHO  %APP_SRC% Was Not Found
ECHO ----------------------------------------
ECHO.
ECHO In order to build ^( %APP_NAME% ^) you
ECHO must first perform a checkout from 
ECHO SourceForge, then type: build %APP_NAME%
ECHO.
ECHO ANONYMOUS CHECKOUT ^( %APP_NAME% ^):
ECHO  Type: checkout %APP_NAME%
ECHO  After Checkout, Type: build %APP_NAME%
IF /I [%APP_NAME%]==[wsjt] (
ECHO.
ECHO FOR DEV CHECKOUT:
ECHO  ^cd src
ECHO  svn co https://%USERNAME%@svn.code.sf.net/p/wsjt/wsjt/trunk
ECHO  ^cd ..
ECHO  build %APP_NAME%
ECHO.
ECHO DEV NOTE: Change ^( %USERNAME% ^) to your Sourforge User Name
GOTO EOF
)
IF /I [%APP_NAME%]==[wspr] (
ECHO.
ECHO FOR DEV CHECKOUT:
ECHO  ^cd src
ECHO  svn co https://%USERNAME%@svn.code.sf.net/p/wsjt/wsjt/branches/wspr
ECHO  ^cd ..
ECHO  build %APP_NAME%
ECHO.
ECHO DEV NOTE: Change ^( %USERNAME% ^) to your Sourforge User Name.
GOTO EOF
)

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
ECHO  Possible Solution:
ECHO  cd %APP_SRC%
ECHO  make -f Makefile.jtsdk2 distclean
ECHO.
ECHO  Then rebuild your target.
ECHO.
EXIT /B %ERRORLEVEL%

:: FINAL FOLDER CREATION ERROR MESSAGE
:COPY_ERROR
ECHO.
ECHO -----------------------------------------------------------------
ECHO   Error Creating ^( %APP_NAME%-r%VER% ^)
ECHO -----------------------------------------------------------------
ECHO. 
ECHO  An error occured when trying to copy the build to it's final
ECHO  location: C:\JTSDK-PY\%APP_NAME%\%APP_NAME%-r%VER%
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
CD /D %BASED%
ENDLOCAL

EXIT /B 0
