Python3 Configuration
---------------------

Python3 ( version 3.3.5 ) is used for building **WSJT** and **WPSR**.
Newer versions of Python are available, however, problems have been
found with various combinations of Python + cx-freeze + NumPy. Staying
with the recommended Python release is highly advisable.

There are several modules, in addition to the base Python installation,
that are required for proper building. It's highly advisable to install
the packages in order to prevent unexpected result. The entire Python
tool chain, including the Gnu CC/FC compilers are 32bit. **Do Not** mix
in 64bit packages or libraries, as this will result in build /
application run failures. Following the steps carefully should yield a
positive result.

Download the following packages before starting the installation. While
there are many sources dotted around the net, the links below have
proved to be very stable and produces consistent builds over the last
6mo or so.

-  `Python
   3.3.5 <http://www.python.org/ftp/python/3.3.5/python-3.3.5.msi>`__
-  `Pip
   1.5.6 <http://www.lfd.uci.edu/~gohlke/pythonlibs/wyxyx8e9/pip-1.5.6.win32-py3.3.exe>`__
-  `Setuptools
   5.8 <http://www.lfd.uci.edu/~gohlke/pythonlibs/wyxyx8e9/setuptools-5.8.win32-py3.3.exe>`__
-  `PyWin32
   219 <http://www.lfd.uci.edu/~gohlke/pythonlibs/wyxyx8e9/pywin32-219.win32-py3.3.exe>`__
-  `CX-Freeze <http://www.lfd.uci.edu/%7Egohlke/pythonlibs/wyxyx8e9/cx_Freeze-4.3.3.win32-py3.3.exe>`__
-  `Numpy
   1.8.1 <https://sourceforge.net/projects/numpy/files/NumPy/1.8.2/>`__


Python3
~~~~~~~

The installation of Python is straight forward. You can select all the
defaults, with the exception of the install path:

-  Double-Click python-3.3.5.msi
-  Change install path to: $(path)33
-  Use the default option
-  Allow the install to finish

Distutils
~~~~~~~~~~~~~~~~~~~~~~~

In order to compile Numpy, we need to tell dist utils which compiler we
will be using. In this case, ( mingw32 ) from the MinGW project.

-  Browse to :code:`C:\JTSDK\python33`
-  create a text file called distutils.cfg
-  Edit the file and add one line at the top:

::

    compiler=mingw32

-  Save and exit the file.

Pip
~~~
-  Run pip-1.5.6.win32-py3.3.exe
-  If required, browse to $(path)33 and select python.exe.
-  Nothing else is required.

.. _setup-tools-install:

Setup Tools
~~~~~~~~~~~
-  Run setuptools-5.8.win32-py3.3.exe
-  If required, browse to $(path)33 and select python.exe.
-  Nothing else is required.

PyWin32
~~~~~~~
-  Run pywin32-219.win32-py3.3.exe
-  If required browse to $(path)33 and select python.exe.
-  Nothing else is required

cx_Freexe
~~~~~~~~~
-  Run cx\_Freeze-4.3.3.win32-py3.3.exe
-  If required browse to $(path)33 and select python.exe.
-  Nothing else is required
-  ( Optional), run cx-freeze post-install script in C:33. This should
   generate a simple Windows Batch File, that can be called from most
   any command line.

Pillow
~~~~~~
-  Open a Windows Terminal, CD/D C:33
-  Use pip to install pillow: pip install pillow==2.3
-  Ensure Pillow installed: pip list

NumPy
~~~~~
There are basically (3) options for Installing Numpy:
   1. Use an Installer ( if your not redistributing :code:`Python33` )
   2. Use Pip ( works, but has know to be problematic on install )
   3. Build from Source.

**JTSDK** uses the build from source method to ensure the C & FC
compilers, along with Python / Numpy work well together.

Before attempting to build Numpy from source, you need to Install
`Windows Visual Studio
Express <http://www.visualstudio.com/en-US/products/visual-studio-express-vs>`__
( Free Version ). This will give you MSVC dll's ( standard and debug
)and a couple configurations scripts that are needed during the Numpy
build. From the downloads performed earlier:

1. Open a Windows CMD terminal
2. Add MinGW32, Python and Python Scripts to your Windows path

.. code-block:: text

   C:\JTSDK\mingw32\bin;C:\JTSDK\Python33;C:\JTSDK\Python33\Scripts;%PATH%

3. Extract numpy-1.8.1 into :code:`C:\JTSDK\Python33\Scripts`
4. Change directories to :code:`CD /D C:\JTSDK\Python33\Scripts\numpy-1.8.1`
5. Ensure GCC is working properly by typing:

.. code-block:: bash

   gcc --version

6. Configure and Install NumPy

.. code-block:: numpy

   python setup.py config --compiler=mingw32 --fcompiler=gnu95 build

.. code-block:: numpy

   python setup.py config --compiler=mingw32 --fcompiler=gnu95 install


7. Change directories, then test F2PY

.. code-block:: numpy

   CD /D ..\ and then test F2PY ( assuming there were no compiler errors )

8. Now check Numpy

.. code-block:: numpy

   python C:\JTSDK\Python33\f2py.py -c --help-fcompiler

You should see your GCC environmet listed toward the tops, and Gfortran listed as your
Fcompiler. If you don't, then, something has gone wrong and you need to resolve it before
trying to build WSJT or WSPR.


TO-DO ( Instructions )
~~~~~~~~~~~~~~~~~~~~~~

-  python33.dll & msvcr100.dll Install
-  Update links for MinGW32 / 32\_48 ON SF
-  Add link to README.mingw32.md when it's written

