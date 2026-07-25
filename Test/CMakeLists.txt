# Test suite for SRVNet.
include(FetchContent)

FetchContent_Declare(Catch2
    GIT_REPOSITORY https://github.com/catchorg/Catch2.git
    GIT_TAG v3.8.0
    GIT_SHALLOW ON)
FetchContent_MakeAvailable(Catch2)

list(APPEND CMAKE_MODULE_PATH ${catch2_SOURCE_DIR}/extras)
include(Catch)

target_compile_features(Catch2 PRIVATE cxx_std_20)

# Suppress Catch2 warnings from polluting our build output
set_target_properties(Catch2 PROPERTIES
    COMPILE_OPTIONS ""
    EXPORT_COMPILE_COMMANDS OFF
    UNITY_BUILD ON
    UNITY_BUILD_BATCH_SIZE 256
)
set_target_properties(Catch2WithMain PROPERTIES EXPORT_COMPILE_COMMANDS OFF)
set_target_properties(Catch2 Catch2WithMain PROPERTIES FOLDER "Dependencies")

get_target_property(CATCH2_INCLUDE_DIRS Catch2 INTERFACE_INCLUDE_DIRECTORIES)
target_include_directories(Catch2 SYSTEM INTERFACE ${CATCH2_INCLUDE_DIRS})

# Test utilities library (shared helpers, no main — Catch2WithMain provides that)
add_library(srvn-test-main STATIC
    TestUtilities/SRVNetUtil.h
    TestUtilities/SRVNetUtil.cpp
)
target_include_directories(srvn-test-main PUBLIC TestUtilities)
target_link_libraries(srvn-test-main PUBLIC SRVNet::SRVNet Catch2::Catch2WithMain)
set_target_warnings(srvn-test-main)
srvn_enable_sanitizers(srvn-test-main)
set_target_properties(srvn-test-main PROPERTIES FOLDER "Test")

# -----------------------
# Placeholder for future test enable/disable options (e.g. SRVN_RUN_X_TESTS)
# For now — always run all available tests
# -----------------------

add_subdirectory(SRVNet)

if(SRVN_OS_ANDROID)
    # We can only write to the tmp directory on the Android virtual device
    set(TARGET_DIR "/data/local/tmp")

    # Android support placeholder. Not supported right now
endif()

# -----------------------
# Test coverage placeholder
# -----------------------

add_custom_target(runtests DEPENDS test-srvn)