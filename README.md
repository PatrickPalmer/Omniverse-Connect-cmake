# Omniverse Connector Sample using CMake Build generator

NVidia had provided [instructions](https://forums.developer.nvidia.com/t/creating-an-omniverse-usd-app-from-the-connect-sample/189557) to hand wire in the Omniverse Connector Sample into a Visual Studio project.  For more structured C++ projects, cmake is common.  This repo codifies the steps in the NVidia document into a cmake project.  This should be considered a lightweight simple integration though and not the level you'd expect if NVidia USD was packaged for distribution.  Proper USD Cmake module should use modern CMake with optional loading of USD components and using target properties.  But this is enough to get started.   Currently hardwired to Connect Sample v 200.0.0.


## Setup

 * Windows 10.
 * Visual Studio 2019. 
 * cmake v3.21 or greater.
 * NVidia Omniverse with Connector Sample installed locally.
   * Hardwired to version 200.0.0.
   * Installed in the default local users home directory in %LOCALAPPDATA%/ov/pkg.
   * Run build.bat in the Connector Sample directory to download the required header and library files for OmniVerse Client and USD.

## Build

```
mkdir build
cd build
cmake -G "Visual Studio 16 2019" -A x64 ..
```

NVidia suggests copying the NVidia USD and Omniverse Client libraries locally. By default, this isn't done.  To do it, add the option COPY_CONNECT_LOCALLY to cmake to copy the libraries into the build deps directory.

```
cmake -G "Visual Studio 16 2019" -A x64 -DCOPY_CONNECT_LOCALLY=ON ..
```

If the Omniverse Client libraries are not installed in the default location of %LOCALAPPDATA%\ov\pkg, set the OmniverseConnectSample_ROOT variable.

```
cmake -G "Visual Studio 16 2019" -A x64 -DOmniverseConnectSample_ROOT=D:/Omniverse/Library/connectsample-200.0.0 ..
```

## Reference

 * https://forums.developer.nvidia.com/t/creating-an-omniverse-usd-app-from-the-connect-sample/189557


