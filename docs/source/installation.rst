Installation
============

This installation method assumes you have not installed JTSDK previously.
Adjust as necessary if reinstalling. Download the following packages, then
follow the :ref:`install-sequence-label`.
below.

Downloads
^^^^^^^^^

Click the following links to download each of the installers:

* `MS-VCredist (2010) <http://sourceforge.net/projects/jtsdk/files/win32/2.0.0/base/contrib/vcredist_x86.exe/download>`_
* `MS-VCredist (2013) <http://sourceforge.net/projects/jtsdk/files/win32/2.0.0/base/contrib/vcredist_msvc2013_x86.exe/download>`_
* `OmniRig <http://sourceforge.net/projects/jtsdk/files/win32/2.0.0/base/contrib/OmniRig.zip/download>`_
* `JTSDK Main Installer <http://sourceforge.net/projects/jtsdk/files/win32/2.0.0/JTSDK-2.0.0-win32.exe/download>`_
* `JTSDK Update-1 <http://sourceforge.net/projects/jtsdk/files/win32/2.0.0/JTSDK-2.0.0-u1-win32.exe/download>`_
* `JTSDK Update-2 <http://sourceforge.net/projects/jtsdk/files/win32/2.0.0/JTSDK-2.0.0-u2-win32.exe/download>`_
* `JTSDK Update-3 <http://sourceforge.net/projects/jtsdk/files/win32/2.0.0/JTSDK-2.0.0-u3-win32.exe/download>`_
* `JTSDK Update-4 <http://sourceforge.net/projects/jtsdk/files/win32/2.0.0/JTSDK-2.0.0-u4-win32.exe/download>`_


.. _install-sequence-label:

Install Sequence
^^^^^^^^^^^^^^^^

It is **important** to install the packages in the correct order. Simply 
follow the list below, and accept the defaults in each installer. The entire
process takes ~15-20 minutes, depending on system speed.

The installation location for is fixed to :code:`C:\JTSDK` it cannot be
changed. This is due to the way Python and QT are installed. 

 1.  Install MS-VCredist (2010), follow the prompts
 2.  Install MS-VCredist (2013), follow the prompts
 3.  Unzip, then run the OmniRig Installer, follow the prompts
 4.  JTSDK Main Installer, follow the prompts
 5.  JTSDK Update-1, follow the prompts
 6.  JTSDK Update-2, follow the prompts, provides QT 5.5 and GCC 4.9
 7.  JTSDK Update-3, follow the prompts, adds Ruby and AsciiDoctor
 8.  JTSDK Update-4, Move Build scripts to a stable branch ( Important Upgrade! )

Post Installation
^^^^^^^^^^^^^^^^^

After the installation finishes, and before building Hamlib3 or other
autotools applications:

* Open JTSDK-MSYS once, close then re-open JTSDK-MSYS.
* Now follow the instructions per your version of Windows

XP / Vista / Win7
-----------------
* Start >> Programs >> JTSDK >> Tools >> JTSDK Maintenance
* Then type..: :code:`update`
* Then type..: :code:`upgrade`


Win8 / Win10
------------
* Launchers should be listed under a location similar to:
* All Apps >> J >> JTSDK >> JTSDK Maintenance
* Then type: :code:`update`
* Then type: :code:`upgrade`

