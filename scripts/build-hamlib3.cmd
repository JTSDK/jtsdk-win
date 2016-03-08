@ECHO OFF
REM  ---------------------------------------------------------------------------
REM  Name .........: build-hamlib3.cmd
REM  Project ......: Part of the JTSDK 2.0 Project
REM  Description ..: Build Hamlib3 from JTSDK-QT / PY Environments
REM  Project URL ..: http://sourceforge.net/projects/wsjt/
REM  Usage ........: Builds Hamllib3 from G4WJS Git Repository
REM
REM  Author .......: Greg, Beam, KI7MT, <ki7mt@yahoo.com>
REM  Copyright ....: Copyright (C) 2014-2016 Joe Taylor, K1JT
REM  License ......: GPL-3
REM
REM  build-hamlib3.cmd is free software: you can redistribute it and/or
REM  modify it under the terms of the GNU General Public License as published
REM  by the Free Software Foundation either version 3 of the License, or
REM  (at your option) any later version.
REM
REM  build-hamlib3.cmd is distributed in the hope that it will be useful,
REM  but WITHOUT ANY WARRANTY; without even the implied warranty of
REM  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General
REM  Public License for more details.
REM
REM  You should have received a copy of the GNU General Public License
REM  along with this program.  If not, see <http://www.gnu.org/licenses/>.
REM ----------------------------------------------------------------------------

CD /D %based%
SET hl3source=%based%\src\hamlib3
IF EXIST %cfgd%\qt55.txt ( 
SET hl3base=c:\JTSDK\hamlib3-qt55
) ELSE (
SET hl3base=c:\JTSDK\hamlib3
)
CLS
ECHO --------------------------------------------
ECHO  Building Hamlib3
ECHO --------------------------------------------
ECHO.
ECHO  Please be patient, this can take a few
ECHO  minutes to complete. With an Intel 
ECHO  i5 2.5Ghz Quad Core CPU, the average
ECHO  build time is^: ^( ^~ 10 Minutes ^)
ECHO.
start /wait %ComSpec% /c ""C:\JTSDK\msys\bin\sh.exe" --login -i -- C:\JTSDK\scripts\msys-build-hamlib3.sh && exit"
IF ERRORLEVEL 1 ( GOTO BUILD-ERROR )
GOTO HL3-TEST1

:HL3-TEST1
ECHO  ^* Checking Files
IF EXIST %hl3base%\bin\rigctl.exe (
ECHO     ^rigctl.exe .....^: OK
) ELSE (
SET hl3file=%hl3base%\bin\rigctl.exe
GOTO HL3-MISSING-FILE
)
IF EXIST %hl3base%\bin\rigctld.exe (
ECHO     ^rigctld.exe ....^: OK
) ELSE (
SET hl3file=%hl3base%\bin\rigctld.exe
GOTO HL3-MISSING-FILE
)
IF EXIST %hl3base%\include\hamlib\riglist.h (
ECHO     ^riglist.h ......^: OK
) ELSE (
SET hl3file=%hl3base%\include\hamlib\riglist.h
GOTO HL3-MISSING-FILE
)
IF EXIST %hl3base%\lib\pkgconfig\hamlib.pc (
ECHO     ^hamlib.pc ......^: OK
) ELSE (
SET hl3file=%hl3base%\lib\pkgconfig\hamlib.pc
GOTO HL3-MISSING-FILE
)
IF EXIST %hl3base%\lib\libhamlib.a (
ECHO     ^libhamlib.a ....^: OK
) ELSE (
SET hl3file=%hl3base%\lib\libhamlib.a
GOTO HL3-MISSING-FILE
)
SET t1status=OK
GOTO HL3-TEST2

:HL3-TEST2
ECHO.
ECHO  ^* Testing Dummy Rig Control
SET tfreq=145000000
%hl3base%\bin\rigctl.exe -m 1 F %tfreq%
%hl3base%\bin\rigctl.exe f >f.f
cat f.f >NUL 2>&1 & SET /p ret=<f.f & rm f.f
ECHO     ^Set Freq .........^: %tfreq%
ECHO     ^Return Freq ..... ^: %ret%
IF /I [%ret%]==[%tfreq%] (
SET t2status=OK
GOTO FINISH-HL3
) ELSE (
GOTO TEST2-ERROR
)
GOTO EOF

:FINISH-HL3
ECHO.
ECHO --------------------------------------------
ECHO  Hamlib3 Build Summary
ECHO --------------------------------------------
ECHO.
ECHO  The Hamlib3 build finished with what appears
ECHO  to be no errors. Only Dummy Rig Tests were
ECHO  performed. You should check your rig
ECHO  thoroughly with WSJT-X
ECHO.
ECHO  Test-1 ......^: %t1status%
ECHO  Test-2 ......^: %t2status%
ECHO  Source ......^: %hl3source%
ECHO  Install .....^: %hl3base%\bin
ECHO  Pkg-Config ..^: %hl3base%\lib\pkgconfig\hamlib.pc
ECHO.
ECHO  Return to Main-Menu, type ..^: main-menu
ECHO.
GOTO EOF

:HL3-MISSING-FILE
ECHO.
ECHO --------------------------------------------
ECHO  MISSING CRITICAL FILE
ECHO --------------------------------------------
ECHO.
ECHO  ^ [ %hl3file% ^] was not found. You should
ECHO  investigate the casue and re-build Hamlib3
ECHO  when resolved. 
ECHO.
GOTO EOF

:TEST2-ERROR
ECHO.
ECHO --------------------------------------------
ECHO  RIG CONTROL TEST ERROR
ECHO --------------------------------------------
ECHO.
ECHO  There was a problem testing Rig Control.
ECHO  Check the build for errors manually and
ECHO  report the problem to the devel-lsit if
ECHO  you cannot resolve the problem.
ECHO.
GOTO EOF

:BUILD-ERROR
ECHO.
ECHO --------------------------------------------
ECHO  HAMLIB3 BUILD ERROR
ECHO --------------------------------------------
ECHO.
ECHO  There was a problem building ^( Hamlib3 ^)
ECHO.
ECHO  Check the screen for error messages, correct,
ECHO  then try tore-build. If the problem presists,
ECHO  contact the wsjt-devel list.
ECHO.
GOTO EOF

:EOF
cd /d %based%

EXIT /B 0


