Overview
========

JTSDK_ is a collection of several open source development frameworks 
( QT_, Python_, `Tcl/Tk`_ ), `GNU Coreutils`_, isolated development
environments ( `Windows CMD`_, MSYS_, Cygwin_ ), utility packages and
customized build scripts for the `WSJT Project`_

Efforts have been taken to minimize custom package configurations, allowing
the end-user to install / update most of the packages manually if desired.
Those that cannot be updated, will have comments to that affect on their
respective page. Both on-line and off-line installers will be provided.

Core Applications
^^^^^^^^^^^^^^^^^

There are (4) pimary environments, each suited to a specific purpose. For the
most part, the environments are isolated from user installed packages, with the
exeption of Windows System32. This helps prevent conflicts between JTSDK_
applications and any of the same name or sype on the systems path.

+------------+--------------------------+-----------+
| Name       | Application              | Framework |
+============+==========================+===========+
| JTSDK-QT   | WSJT-X, WSPR-x and MAP65 | QT5       |
+------------+--------------------------+-----------+
| JTSDK-PY   | WSJT and WSPR            | Python    |
+------------+--------------------------+-----------+
| JTSDK-MSYS | GNU Tools and GCC        | MSYS      |
+------------+--------------------------+-----------+
| JTSDK-DOC  | Cygwin Tools             | Cygwin    |
+------------+--------------------------+-----------+

.. Warning::
    If you use a unicode character, you'll need to have an encoding at the top
    of your settings.py file::

        # -*- coding: UTF-8 -*-


.. _WSJT Project: http://physics.princeton.edu/pulsar/k1jt/
.. _Cygwin: https://cygwin.com/
.. _MSYS: http://www.mingw.org/wiki/msys
.. _Tcl/Tk: https://www.tcl.tk/
.. _Qt: https://www.qt.io/
.. _Windows CMD: http://windows.microsoft.com/en-us/windows-vista/open-a-command-prompt-window
.. _GNU Coreutils: http://www.gnu.org/software/coreutils/coreutils.html
.. _JTSDK: https://github.com/KI7MT/jtsdk-nix
.. _Python: https://www.python.org/
