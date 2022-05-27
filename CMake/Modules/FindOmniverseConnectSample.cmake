# Locate Omniverse Connect Sample Directory

# This module defines
# OmniverseConnectSample_FOUND, if false, do not use
# OmniverseConnectSample_DIR, where to find the headers
#

SET(OmniverseConnectSample_VERSION "104.1.0")

FIND_PATH(OmniverseConnectSample_DIR 
    NAMES "run_sample.bat"
    PATHS
      $ENV{LOCALAPPDATA}/ov/pkg
    PATH_SUFFIXES
      connectsample-${OmniverseConnectSample_VERSION}
    NO_DEFAULT_PATH
)


include(FindPackageHandleStandardArgs)

FIND_PACKAGE_HANDLE_STANDARD_ARGS(
    OmniverseConnectSample
    REQUIRED_VARS 
        OmniverseConnectSample_DIR
    VERSION_VAR
        OmniverseConnectSample_VERSION
)

