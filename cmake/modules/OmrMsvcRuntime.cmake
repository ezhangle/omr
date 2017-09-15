##############################################################################
#
# (c) Copyright IBM Corp. 2017, 2017
#
#  This program and the accompanying materials are made available
#  under the terms of the Eclipse Public License v1.0 and
#  Apache License v2.0 which accompanies this distribution.
#
#      The Eclipse Public License is available at
#      http://www.eclipse.org/legal/epl-v10.html
#
#      The Apache License v2.0 is available at
#      http://www.opensource.org/licenses/apache2.0.php
#
# Contributors:
#    Multiple authors (IBM Corp.) - initial implementation and documentation
###############################################################################

# Find the MSVC Runtime libraries.
# Will set:
#   OMR_MSVC_CRT: The name of the MSVC runtime DLL, or NOTFOUND.
#
# This module will determine the MSVC runtime names from the version of MSVC being used.

if(OMR_MSVC_RUNTIME_)
	return()
endif()
set(OMR_MSVC_RUNTIME_ 1)

include(OmrAssert)

# OMR_MSVC_CRT

if(DEFINED ENV{MSVC_CRT})
	set(msvc_crt "$ENV{MSVC_CRT}")
elseif(MSVC_VERSION EQUAL 1200) # VS 6
	string(CONCAT msvc_crt
		$<$<CONFIG:Debug>:MSVCR60D>
		$<$<CONFIG:Release>:MSVCR60>
	)
elseif(MSVC_VERSION EQUAL 1300) # VS 7
	string(CONCAT msvc_crt
		$<$<CONFIG:Debug>:MSVCR70D>
		$<$<CONFIG:Release>:MSVCR70>
	)
elseif(MSVC_VERSION EQUAL 1310) # VS 7.1
	string(CONCAT msvc_crt
		$<$<CONFIG:Debug>:MSVCR71D>
		$<$<CONFIG:Release>:MSVCR71>
	)
elseif(MSVC_VERSION EQUAL 1400) # VS 8
	string(CONCAT msvc_crt
		$<$<CONFIG:Debug>:MSVCR80D>
		$<$<CONFIG:Release>:MSVCR80>
	)
elseif(MSVC_VERSION EQUAL 1500) # VS 9
	string(CONCAT msvc_crt
		$<$<CONFIG:Debug>:MSVCR90D>
		$<$<CONFIG:Release>:MSVCR90>
	)
elseif(MSVC_VERSION EQUAL 1600) # VS 10
	string(CONCAT msvc_crt
		$<$<CONFIG:Debug>:MSVCR100D>
		$<$<CONFIG:Release>:MSVCR100>
	)
elseif(MSVC_VERSION EQUAL 1700) # VS 11
	string(CONCAT msvc_crt
		$<$<CONFIG:Debug>:MSVCR110D>
		$<$<CONFIG:Release>:MSVCR110>
	)
elseif(MSVC_VERSION EQUAL 1800) # VS 12
	string(CONCAT msvc_crt
		$<$<CONFIG:Debug>:MSVCR120D>
		$<$<CONFIG:Release>:MSVCR120>
	)
elseif(MSVC_VERSION GREATER 1800) # VS 14+
	string(CONCAT msvc_crt
		$<$<CONFIG:Debug>:UCRTBASED>
		$<$<CONFIG:Release>:UCRTBASE>
	)
else()
	set(msvc_crt NOTFOUND)
endif()

set(OMR_MSVC_CRT "${msvc_crt}" CACHE STRING "The MSVC runtime library")
