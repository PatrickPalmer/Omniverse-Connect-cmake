# Locate Omniverse Client
# lightweight find module 

# This module defines
# OmniverseClient_FOUND, if false, do not use
# OmniverseClient_INCLUDE_DIR, where to find the headers
# OmniverseClient_LIBRARY_DIR
# OmniverseClient_LIBRARIES
#

# include directory is shared for both debug and release

FIND_PATH(OmniverseClient_INCLUDE_DIR 
    NAMES "OmniClient.h"
    PATHS
    ${OmniverseClient_ROOT}/include
    NO_DEFAULT_PATH
)

FIND_PATH(OmniverseClient_LIBRARY_DIR_RELEASE
    NAMES "OmniClient.lib"
    PATHS
    ${OmniverseClient_ROOT}/release
    NO_DEFAULT_PATH
)

FIND_PATH(OmniverseClient_LIBRARY_DIR_DEBUG 
    NAMES "OmniClient.lib"
    PATHS
    ${OmniverseClient_ROOT}/debug
    NO_DEFAULT_PATH
)

# Created as a generator expressed so it can more useful
SET(OmniverseClient_LIBRARY_DIR $<IF:$<CONFIG:Debug>,${OmniverseClient_LIBRARY_DIR_DEBUG},${OmniverseClient_LIBRARY_DIR_RELEASE}>)

mark_as_advanced(
    OmniverseClient_LIBRARY_DIR_RELEASE
    OmniverseClient_LIBRARY_DIR_DEBUG
)


FIND_LIBRARY(OmniverseClient_LIBRARIES_RELEASE
    NAMES "OmniClient.lib"
    PATHS
    ${OmniverseClient_LIBRARY_DIR_RELEASE}
)

FIND_LIBRARY(OmniverseClient_LIBRARIES_DEBUG
    NAMES "OmniClient.lib"
    PATHS
    ${OmniverseClient_LIBRARY_DIR_DEBUG}
)


SET(OmniverseClient_LIBRARIES debug "${OmniverseClient_LIBRARIES_DEBUG}" optimized "${OmniverseClient_LIBRARIES_RELEASE}")

mark_as_advanced(
    OmniverseClient_LIBRARIES_RELEASE
    OmniverseClient_LIBRARIES_DEBUG
)

include(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(
    OmniverseClient
    REQUIRED_VARS 
        OmniverseClient_INCLUDE_DIR                                  
        OmniverseClient_LIBRARY_DIR                                  
        OmniverseClient_LIBRARIES
)


