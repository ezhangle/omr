##############################################################################
#
# (c) Copyright IBM Corp. 2017
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

if(OMR_PLATFORM_)
	return()
endif()
set(OMR_PLATFORM_ 1)

include(OmrAssert)
include(OmrDetectSystemInformation)
include(OmrUtility)

###
### Platform flags
### TODO: arch flags. Defaulting to x86-64

omr_detect_system_information()

# Pickup OS info 
include(platform/os/${OMR_HOST_OS})

# Pickup Arch Info
include(platform/arch/${OMR_HOST_ARCH})

# Pickup toolconfig based on platform
include(platform/toolcfg/${OMR_TOOLCONFIG})

# Verify toolconfig!
include(platform/toolcfg/verify)

add_definitions(
	${OMR_OS_DEFINITIONS}
	${OMR_ARCH_DEFINITIONS}
)

omr_append_flags(CMAKE_C_FLAGS   ${OMR_OS_COMPILE_OPTIONS})
omr_append_flags(CMAKE_CXX_FLAGS ${OMR_OS_COMPILE_OPTIONS})

if(OMR_HOST_OS STREQUAL "linux")
	if(OMR_WARNINGS_AS_ERRORS)
		omr_append_flags(CMAKE_C_FLAGS   ${OMR_WARNING_AS_ERROR_FLAG})
		omr_append_flags(CMAKE_CXX_FLAGS ${OMR_WARNING_AS_ERROR_FLAG})
	endif()
endif()


# interface library for exporting symbols from dynamic library
# currently does nothing except on zos
add_library(omr_shared INTERFACE)

# If the OS requires global setup, do it here. 
if(COMMAND omr_os_global_setup)
	omr_os_global_setup()
endif()

# And now the toolconfig setup
if(COMMAND omr_toolconfig_global_setup)
	omr_toolconfig_global_setup()
endif()


###
### Flags we aren't using
###

# TODO: SPEC

# TODO: OMR_HOST_ARCH
# TODO: OMR_TARGET_DATASIZE
# TODO: OMR_TOOLCHAIN
# TODO: OMR_CROSS_CONFIGURE
# TODO: OMR_RTTI

