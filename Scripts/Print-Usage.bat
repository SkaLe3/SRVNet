@echo off
setlocal
REM ==============================================================================
REM SRVNet CMake Options & Build Helper Usage
REM ==============================================================================

echo ==============================================================================
echo                      SRVNet CMake Build System ^& Usage
echo ==============================================================================
echo.
echo [1] Available SRVNet CMake Options:
echo ------------------------------------------------------------------------------
echo   Option                     Default  Description
echo   -------------------------  -------  ----------------------------------------
echo   BUILD_SHARED_LIBS          OFF      Build SRVNet as shared (.dll/.so) library
echo   SRVN_BUILD_SAMPLES         OFF      Build sample/example executables (Sandbox)
echo   SRVN_BUILD_TESTS           OFF      Build test suite targets
echo   SRVN_WARNINGS_AS_ERRORS    OFF      Treat compiler warnings as fatal errors
echo   SRVN_GENERATE_PDB          ON       Generate PDB debug symbols (MSVC only)
echo.
echo   SRVN_ENABLE_ASAN           OFF      Enable Address Sanitizer
echo   SRVN_ENABLE_UBSAN          OFF      Enable Undefined Behaviour Sanitizer (Clang/GCC)
echo   SRVN_ENABLE_TSAN           OFF      Enable Thread Sanitizer (Clang/GCC)
echo.
echo [2] Standard CMake Options:
echo ------------------------------------------------------------------------------
echo   CMAKE_BUILD_TYPE           Release  Choose configuration: Debug, Release
echo.
echo [3] Helper Build Scripts (in Scripts/):
echo ------------------------------------------------------------------------------
echo   Windows (Batch):
echo     Print-Usage.bat           - Display this usage information
echo     Clean.bat                 - Remove the Build directory
echo     Gen-VS-Project-Files.bat  - Generate Visual Studio 2022 solution ONLY
echo     Build-MSVC.bat            - Generate AND build MSVC (Debug, Release, ASan)
echo     Build-Clang-Windows.bat   - Generate AND build Clang on Windows
echo     Build-GCC-Windows.bat     - Generate AND build GCC (MinGW) on Windows
echo.
echo   Linux (Shell Scripts in Scripts/Linux/):
echo     print_usage.sh            - Display usage on Linux
echo     build_gcc.sh              - Generate and build with GCC (Debug/Release/Sanitizers)
echo     build_clang.sh            - Generate and build with Clang (Debug/Release/Sanitizers)
echo.
echo ==============================================================================
pause
