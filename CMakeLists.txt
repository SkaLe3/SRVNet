cmake_minimum_required(VERSION 3.20)

# Prevent in-source builds (must use CMAKE_SOURCE_DIR — PROJECT_SOURCE_DIR is not yet set before project())
if(CMAKE_SOURCE_DIR STREQUAL CMAKE_BINARY_DIR)
    message(FATAL_ERROR "In-source builds are not allowed. Run cmake from a separate build directory, e.g.: cmake -B build")
endif()

project(SRVNet
    VERSION 1.0.0
    DESCRIPTION "High-performance C++ Networking Library"
    LANGUAGES CXX
)

# ------------------------------------------------------------------------------
# C++ Standard Configuration
# ------------------------------------------------------------------------------
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# ------------------------------------------------------------------------------
# Project Options
# ------------------------------------------------------------------------------
option(BUILD_SHARED_LIBS    "Build SRVNet as a shared library"           OFF)
option(SRVN_BUILD_SAMPLES   "Build the SRVNet sample executables"        OFF)
option(SRVN_BUILD_TESTS     "Build the SRVNet test suite"                OFF)

# Sanitizers
option(SRVN_ENABLE_ASAN "Enable Address Sanitizer" OFF)
option(SRVN_ENABLE_UBSAN "Enable Undefined Behaviour Sanitizer" OFF)
option(SRVN_ENABLE_TSAN "Enable Thread Sanitizer " OFF)

# Default build type for single-configuration generators
if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
    set(CMAKE_BUILD_TYPE Release CACHE STRING "Choose the type of build (Debug or Release)" FORCE)
    set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release")
endif()

# IDE Solution Folders
set_property(GLOBAL PROPERTY USE_FOLDERS ON)
set_property(GLOBAL PROPERTY PREDEFINED_TARGETS_FOLDER "CMake")

# ------------------------------------------------------------------------------
# Project Modules & Output Locations
# ------------------------------------------------------------------------------
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

include(Config)
include(CompilerWarnings)
include(Macros)

# Centralized output directory: Binaries/<Platform>/<Config>
set(BASE_OUTPUT_DIR "${CMAKE_BINARY_DIR}/Binaries/${PLATFORM_NAME}")

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${BASE_OUTPUT_DIR}/$<CONFIG>")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${BASE_OUTPUT_DIR}/$<CONFIG>")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${BASE_OUTPUT_DIR}/$<CONFIG>")

# ------------------------------------------------------------------------------
# Targets
# ------------------------------------------------------------------------------
add_subdirectory(Source/SRVNet)

if(SRVN_BUILD_SAMPLES)
    add_subdirectory(Samples)
endif()

if(SRVN_BUILD_TESTS)
    enable_testing()
    add_subdirectory(Test)
endif()
