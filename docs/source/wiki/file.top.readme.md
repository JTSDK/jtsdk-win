# JTSDK Files and Installers
###Version: v2.0.0
###Last Update: 06-DEC-2014
The files in Base are use to build a particular library / application.

* BASE: foundation packages for JTSDK v2
* SRC:  development packages for build testing
* WSJT-SUITE: incremental builds of WSJT-Suite ( for testing JTSDK v2.0 )
* JTSDK-2.0.0-B(x)-Win32.exe is Base Packages + Build Scripts

###Note(s):

* WSJT-Suite is **not** intended to be a used long term. The primary
use is to test builds and installers.
* If you have trouble with any of the applications in WSJT-Suite, you
should install an official release version from the[ WSJT Website](http://physics.princeton.edu/pulsar/k1jt/), and compare the behavior between the two.

###CHANGE LOG
#####06-DEC-2014 WSJT-Suite-1.0.8.Win32-exe
* Rebuilt all 6 Applications
* WSJT-X was updated by Bill ( G4WJS ), mostly for Mac OSX
* Changed Python Pillow version to v2.3.0 ( affects WSJT & WSPR )
* Added missing Util Batch file for WSJTX

#####05-DEC-2014 WSJT-Suite-1.0.7.Win32-exe
* MAP65 Add correct resource files to install bin dir

##### 05-DEC-2014 WSJT-Suite-1.0.6.Win32-exe
* Added WSJT-X Release Candidate 1.4 RC3
* Rebuilt all 5 applications due to build script changes
* MAP65 Added missing .dat and runtime dlls
* WSPR-X Added missing .dat files
* WSJT build updated due to Makefile.jtsdk2 changes
* WSPR build updated due to Makefile.jtsdk2 changes
* No JTSDK Base Packages Changes were made

#####04-DEC-2014 WSJT-Suite-1.0.5.Win32-exe
* Changed Installer Name to add version numbers
* Old name WSJT-Suite-<date> - New name WSJT-Suite-x.x.x-Win32.exe
* Added kvasd.exe.md5 v1.12 to WSJTX Folder
* Fixed MAP65 Shortcut Link
* Added libgcc_s_dw2-1.dll to MAP65 and WSPRX folders
* Remove WSPR-X default .INI file
* No Changes To Application Versions
