JTSDK - fftw3f
--------------

FFTW ( single-precision ) is used in all 5 WSJT applications, both
static libs and dll's. While **JTSDK** provides a pre-built Windows
version, it also provides a Bash script ( msys-build-fftw.sh ) and the
latest source tar ball to build FFTW from source. The pre-compiled
Windows version also includes fftw-wisdom, which is used to to optimize
FFT's for MAP65.

-  Version - 3.3.4
-  Website - `FFTW <http://www.fftw.org/>`__
-  Installer -
   `fftw-3.3.4-dll32.zip <ftp://ftp.fftw.org/pub/fftw/fftw-3.3.4-dll32.zip>`__

Installation
~~~~~~~~~~~~

-  Unzip to $(path)3fe
-  Nothing else is required.

Optional Source Build
~~~~~~~~~~~~~~~~~~~~~

To build FFTW from source:

-  Backup $(path)3f to a safe location
-  Open msys-env
-  At the Prompt, simply type: build-fftw
-  Edit the script as needed to test various configurations

The source file is located in
:math:`(path)\JTSDK\src\fftw-3.3.4.tar.gz.The build script is located at: `\ (path)-build-fftw.sh
which is currently set to build static and disable shared. It creates
it's own folder at install ( $(path)3f), and uses pkg-config. The
default tool-chain is QT5 mingw-64, which is winpthreads. WSJT and WSPR
uses pthreads. If you want / need to build specifically for WSJT and
WPSR, change the tool-chain paths in the build script:

**From**:

::

    For winpthreads

    export PATH="/c/JTSDK/qt5/bin:$PATH"
    TC='C:/JTSDK/qt5/bin'

**To**:

::

    For pthreads

    export PATH="/c/JTSDK/mingw32/bin:$PATH"
    TC='C:/JTSDK/mingw32/bin'

Care should be taken to keep custom builds separate from production use.
As of this writing, WSJT-X, WSPR-X and MAP65 are using the pre-built
libraries. WSJT and WSPR are using pre-bulilt libraries from their SVN
src folders.

The script is fairly well documented. Edit as you see fit for testing.

--------------

