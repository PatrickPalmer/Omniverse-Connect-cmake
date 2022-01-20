
cmake_minimum_required(VERSION 3.21)

project(OmniverseConnectCmake VERSION 0.5.0)

if (CMAKE_SOURCE_DIR STREQUAL CMAKE_BINARY_DIR)
    message(FATAL_ERROR "Do not build in-source, use a build directory.")
endif()

###############
### MODULES ###
###############

### Standard CMake modules

#include(CMakePackageConfigHelpers)
#include(GNUInstallDirs)
#include(InstallRequiredSystemLibraries)


# add in our CMake module scripts
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/CMake"
                              "${CMAKE_CURRENT_LIST_DIR}/CMake/Modules")



###############
### OPTIONS ###
###############

# copy connect libraries locally
option(COPY_CONNECT_LOCALLY "Copy Connect Libraries Locally" OFF)


################
### SETTINGS ###
################

# C++17 standard
set(CMAKE_CXX_STANDARD 17)

if (MSVC)
    add_compile_options(/EHsc)
endif()


# global use_folders property so that all generic targets go into CMakePredefinedTargets folder
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

if(MSVC)
    add_compile_definitions(WIN32)
    add_compile_definitions(_CRT_SECURE_NO_WARNINGS)
    add_compile_definitions(_WINSOCK_DEPRECATED_NO_WARNINGS)
    add_compile_definitions(NOMINMAX)
    add_compile_definitions(WIN32_LEAN_AND_MEAN)
    add_compile_definitions(_WINSOCKAPI_)

    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /MP")

    SET(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /MTd")
    SET(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /MT")  
    SET(CMAKE_CXX_FLAGS_RELWITHDEBINFO "${CMAKE_CXX_FLAGS_RELWITHDEBINFO} /MT")
endif(MSVC)

add_compile_definitions(BOOST_ALL_DYN_LINK)
add_compile_definitions(TBB_USE_DEBUG=$<IF:$<CONFIG:Debug>,1,0>)


#################################
### Omniverse Connect Library ###
#################################

FIND_PACKAGE(OmniverseConnectSample)
IF (NOT OmniverseConnectSample_FOUND)
    MESSAGE("Missing Omniverse Connect Sample directory. Skipping.")
    RETURN()
ENDIF()

# Copy over dependencies into project
if (COPY_CONNECT_LOCALLY)

    if (NOT EXISTS "${CMAKE_BINARY_DIR}/deps")
        file(MAKE_DIRECTORY "${CMAKE_BINARY_DIR}/deps")
    endif()

    if (NOT EXISTS "${CMAKE_BINARY_DIR}/deps/nv_usd")
        if (WIN32)
            execute_process(COMMAND robocopy /S "${OmniverseConnectSample_DIR}/_build/target-deps/nv_usd" "${CMAKE_BINARY_DIR}/deps/nv_usd" /NFL /NDL /NJH /NJS /nc /ns /np)
        endif()
    endif()
    if (NOT EXISTS "${CMAKE_BINARY_DIR}/deps/omni_client_library")
        if (WIN32)
            execute_process(COMMAND robocopy /S "${OmniverseConnectSample_DIR}/_build/target-deps/omni_client_library" "${CMAKE_BINARY_DIR}/deps/omni_client_library" /NFL /NDL /NJH /NJS /nc /ns /np)
        endif()
    endif()

    SET(OmniverseClient_ROOT ${CMAKE_BINARY_DIR}/deps/omni_client_library)
    SET(NVidiaUSD_ROOT ${CMAKE_BINARY_DIR}/deps/nv_usd)

else()

    # use libraries in place
    SET(OmniverseClient_ROOT ${OmniverseConnectSample_DIR}/_build/target-deps/omni_client_library)
    SET(NVidiaUSD_ROOT ${OmniverseConnectSample_DIR}/_build/target-deps/nv_usd)

endif()

###############
### PROJECT ###
###############

add_subdirectory(SimpleApp)


