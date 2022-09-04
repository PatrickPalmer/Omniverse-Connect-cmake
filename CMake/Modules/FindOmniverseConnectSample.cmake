# Locate Omniverse Connect Sample Directory

# Users may adjust the behaviors of this module by modifying these variables.
#     OmniverseConnectSample_ROOT - install location
# This module defines
#     OmniverseConnectSample_FOUND - if false, do not use
#     OmniverseConnectSample_DIR - where to find the headers
#

SET(OmniverseConnectSample_VERSION "200.0.0")

FIND_PATH(OmniverseConnectSample_DIR 
    NAMES "run_omniSimpleSensor.bat"
    PATHS
      ${OmniverseConnectSample_ROOT}
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

