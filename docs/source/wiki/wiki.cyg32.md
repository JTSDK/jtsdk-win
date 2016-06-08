cyg32
---

Cyg32 is a pre-built Cygwin ( x86 / 32bit ) environment. In regards to JTSDK, cyg32's primary function is to build WSJT documentation. However, it also provides many powerful command line tools. These tools ( applications ) are available as stand alone programs in their respective shells. This document provides background information on cyg32's construction and configuration for use with JTSDK.

## Sections
* [Package Data](#package-information)
* [Core Tools](#tool-list)
* [Build Script](#build-script)
* [Post Install Mods](#post-install)
* [Cygwin Licensing](#cyg-license)

### Package Data<a id="package-information"></a>
* Version - 1.7.33 Cygwin DLL
* Website - [Cygwin.com](https://www.cygwin.com/)
* Installer - [setup-x86.exe](http://cygwin.com/setup-x86.exe)

### Core Tool List <a id="tool-list"></a>
Many tools are provided as part of the base Cygwin installation. See **$(path)\JTSDK\cyg32\bin** for all binary applications.  The following are key elements of **cyg32**:

* Python 2.7.8 ( used for Documentation builds )
* Subversion ( used for all JTSDK SVN activity )
* Bash 4.x ( Base env + mintty shell )
* GNU source-highlight ( default AsciiDoc Syntax Highlight )
* Python-Pygments ( alternate AsciiDoc Syntax Highlight )
* GNU coreutils ( rm, mkdir, cp, cat, less, more etc )
* GNU patch utils
* GNU diff Utils
* Misc utils, rsync, wget, curl, gawk, sed, grep, etc.

### Build Script <a id="build-script"></a>
The following is the unattended build script used to generate the base installation. You can add packages as you see fit using setup-x86.exe, however, care should be taken if installing GCC tools or the associated Autotools as conflicts between MinGw32 or Mingw-W64 tool-chains can occur. In general, installing the Cygwin GCC Tool-Chain ( for use with JTSDK ) is **not advisable**. Additionally, use caution when adding or modifying any package that may affects Group, Passwd ( user lists ), profile or bashrc files as this can adversely affect the user account. 

<  INCLUDE-BUILD SCRIPT HERE  >

### Post Installation Mods<a id="post-install"></a>
Several post installation mods have been made in order to make the cyg32 ( Cygwin installation ) portable. The following is a short list of mods performed post installation. Comments can be found in each of the respective files where changes from the original source occurs:

* Remove UUID & group files to force re-generation of user on initial log-in
* Update FSTAB to include /scripts directory
* Updated /etc/profile to re-generate user at initial log-in
* Updated all files in /etc/skel


### Cygwin Licensing Terms<a id="cyg-license"></a>
Cygwin Licensing Terms can be found at: [Terms](http://cygwin.com/licensing.html)

---
