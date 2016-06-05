# JTSDK

is a collection of several open source development frameworks 
(QT, Python, Tcl/Tk), Gnu tools (Coreutils, etc), isolated development
environments ( Windows CMD, MSYS/Bash, Cygwin/Bash ), utility packages
and customized build scripts.

Efforts have been taken to minimize custom package configurations, allowing
the end-user to install / update most of the packages manually if desired.
Those that cannot be updated, will have comments to that affect on their
respective page. Both on-line and off-line installers will be provided.


## Installation Overview

Installation assumes you have not installed JTSDK previously. Adjust as
necessary if reinstalling. Download the following packages, then follow the
install instructions below.

### DOIWNLOADS

Click the following links to download.

* [MS-VCredist (2010)](http://sourceforge.net/projects/jtsdk/files/win32/2.0.0/base/contrib/vcredist_x86.exe/download)
* [MS-VCredist (2013)](http://sourceforge.net/projects/jtsdk/files/win32/2.0.0/base/contrib/vcredist_msvc2013_x86.exe/download)
* [OmniRig](http://sourceforge.net/projects/jtsdk/files/win32/2.0.0/base/contrib/OmniRig.zip/download)
* [JTSDK Main Installer](http://sourceforge.net/projects/jtsdk/files/win32/2.0.0/JTSDK-2.0.0-win32.exe/download)
* [JTSDK Update-1](http://sourceforge.net/projects/jtsdk/files/win32/2.0.0/JTSDK-2.0.0-u1-win32.exe/download)
* [JTSDK Update-2](http://sourceforge.net/projects/jtsdk/files/win32/2.0.0/JTSDK-2.0.0-u2-win32.exe/download)
* [JTSDK Update-3](http://sourceforge.net/projects/jtsdk/files/win32/2.0.0/JTSDK-2.0.0-u3-win32.exe/download)
* [JTSDK Update-4](http://sourceforge.net/projects/jtsdk/files/win32/2.0.0/JTSDK-2.0.0-u4-win32.exe/download)

### INSTALLATION

It is important to install the packages in the correct order. All you should
have to do is follow the prompts in all (7) installers. This will
take about ~15 minutes to complete, and the installation location for
JTSDK is fixed: ( C:\\JTSDK ) it cannot be changed.

* Install MS-VCredist (2010), follow the prompts
* Install MS-VCredist (2013), follow the prompts
* Unzip, then run the OmniRig Installer, follow the prompts
* JTSDK Main Installer, follow the prompts
* JTSDK Update-1, follow the prompts
* JTSDK Update-2, follow the prompts, provides QT 5.5 and GCC 4.9
* JTSDK Update-3, follow the prompts, adds Ruby and Asciidoctor
* JTSDK Update-4, Move Build scripts to a stable branch ( Important Upgrade! )

### POST INSTALL UPDATE - ( Important ! )
After the installation finishes, and before building Hamlib3 or other
autotools applications:

* Open JTSDK-MSYS once, close then re-open JTSDK-MSYS.
* Now follow the instructions per your version of Windows

***XP / Vista / Win7***

* Start >> Programs >> JTSDK >> Tools >> JTSDK Maintenance
* svn switch ^^/jtsdk-win/tags/jtsdk-win-2.0.5
* Close JTSDK-Maint
* Re-Open JTSDK Maint, then type: version
* Ensure you are on v2.0.5 or later
* Then type: update
* Then type: upgrade

***Win8 / Win10***

* Launchers should be listed under a location similar to:
* All Apps >> J >> JTSDK >> JTSDK Maintenance
* svn switch ^^/jtsdk-win/tags/jtsdk-win-2.0.5
* Close JTSDK-Maint
* Re-Open JTSDK Maint, then type: version
* Ensure you are on v2.0.5 or later
* Then type: update
* Then type: upgrade

### BASIC COMPILING INSTRUCTIONS
You should build  / rebuild Hamlib3 often, as it is receives frequent updates.
You must also build Hamlib3 "before" building WSJT-X the first time.

***Build Hamlib3***

* Open JTSDK-MSYS or JTSDK-QT
* Type: build-hamlib3

***WSJTX v1.7.0 Devel Example***

* Open JTSDK-QT ( Desktop Icon or Start Menu )
* Type: build-wsjtx rinstall

***WSJT v10.0 Example***

* Open JTSDK-PY ( Desktop Icon or Start Menu )
* Type: build-wsjt install


## BUILD NOTES
* The install locations for all builds will be posted at the bottom of the each
sucessful run.
* Besure sure to check your build options with: list-options


## REPORTING ISSUES
Send Email to: [WSJT-Devel](<wsjt-devel@lists.sourceforge.net>)

