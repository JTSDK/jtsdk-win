Overview
========

.. include:: links.txt

`JTSDK`_ is a collection of several open source development frameworks 
( QT_, Python_, `Tcl/Tk`_ ), `GNU Coreutils`_, isolated development
environments ( `Windows CMD`_, MSYS_, Cygwin_ ), utility packages and
customized build scripts for the `WSJT Project`_

Efforts have been taken to minimize custom package configurations, allowing
the end-user to install / update most of the packages manually if desired.
Those that cannot be updated, will have comments to that affect on their
respective page. Both on-line and off-line installers will be provided.


Environments
------------

There are (4) pimary environments, each suited to a specific purpose. For the
most part, the environments are isolated from user installed packages, with the
exeption of Windows System32. This helps prevent conflicts between JTSDK_
applications and any of the same name or type on the systems path.

+------------+--------------------------+-----------+
| **Environments Table**                            |
+------------+--------------------------+-----------+
| Name       | Application              | Framework |
+============+==========================+===========+
| JTSDK-QT   | WSJT-X, WSPR-x and MAP65 | `QT`_     |
+------------+--------------------------+-----------+
| JTSDK-PY   | WSJT and WSPR            | `Python`_ |
+------------+--------------------------+-----------+
| JTSDK-MSYS | GNU Tools and GCC        | `MSYS`_   |
+------------+--------------------------+-----------+
| JTSDK-DOC  | Cygwin Tools             | `Cygwin`_ |
+------------+--------------------------+-----------+


