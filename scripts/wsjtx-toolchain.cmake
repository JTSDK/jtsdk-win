# JTSDK-QT Tool-Chain File for WSJTX
# Part of the JTSDK v2.0.0 Project
# NOTE: WSKT-X uses Hamlib3, not Hamlib2

# System Type and Base Paths
SET (CMAKE_SYSTEM_NAME Windows)
SET (BASED C:/JTSDK)

# for AsciiDoctor ( Ruby version )
SET (ADOCT C:/JTSDK/Ruby/bin) 

 # for AsciiDoc ( Python27 version )
SET (ADOCD C:/JTSDK/asciidoc)
SET (PY27D C:/JTSDK/python27)

# Remiander of tools
SET (QTDIR C:/JTSDK/qt5/5.2.1/mingw48_32)
SET (HAMLIB C:/JTSDK/hamlib3)
SET (FFTW C:/JTSDK/fftw3f)

# Set the Prefix Paths
SET (CMAKE_PREFIX_PATH ${PY27D} ${ADOCD} ${ADOCT} ${QTDIR} ${FFTW} ${HAMLIB} ${HAMLIB}/bin)
SET (CMAKE_FIND_ROOT_PATH ${BASED})
SET (CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
SET (CMAKE_FIND_ROOT_PATH_MODE_LIBRARY BOTH)
SET (CMAKE_FIND_ROOT_PATH_MODE_INCLUDE BOTH)
