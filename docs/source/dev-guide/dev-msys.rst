MSYS from MinGW-Builds
----------------------

MSYS provides easy access to Bash, Autotools, M4, $(MAKE) scripts, VCS
applications ( SVN, Git, Mercurial, CVS etc ) and many command-line GNU
Utilities. MSYS is **not** used to build any of the
`WSJT <https://sourceforge.net/projects/wsjt/>`__ applications directly,
however, it can build several of the support libraries; **Hamlib3,
Portaudio, Samplerate, FFTW** etc. For
`JTSDK <https://sourceforge.net/projects/wsjt/>`__ purposes, the main
use has been to build Git versions of Hamlib3, which is seeing a number
of improvements in Rig Control.

Package Information
~~~~~~~~~~~~~~~~~~~

-  Version - msys+7za+wget+svn+git+Mercurial+cvs-rev13 - 2013-05-15
-  Website -
   `MinGW-Builds <https://sourceforge.net/projects/mingwbuilds/files/external-binary-packages>`__
-  Installer -
   `MSYS <https://sourceforge.net/projects/mingwbuilds/files/external-binary-packages/>`__

Installation
~~~~~~~~~~~~

-  Extract the 7z file to $(path)

Post Install Modifications
~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Several reports of WGET causing Windows ( BSOD ) events have been
   reported. As such, `JTSDK <https://sourceforge.net/projects/wsjt/>`__
   does not use the WGET version which ships with this package.
-  Curl is used as the default web-download application.
-  Several modifications are made, post install / extraction, to
   customize the environment for
   `JTSDK <https://sourceforge.net/projects/wsjt/>`__ need:

   -  Updated profile and fstab
   -  Custom /etc/skel/.dot files for new user generation
   -  Add alias ( shot-cut ) lists and and scripts to build libraries
   -  Add custom headers and colors

-  All updates / patches can be found
   `here <https://svn.code.sf.net/p/wsjt/wsjt/branches/jtsdk/win32/scripts/msys/etc>`__,
   far too many to list individually. All modifications, with the
   exception of removing WGET, are done with the **postinstall.bat**
   script.

