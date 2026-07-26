
configure_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/Public/SRVNet/Version.h.in"
    "${CMAKE_CURRENT_BINARY_DIR}/Public/SRVNet/Version.h"
    @ONLY
)

file(GLOB_RECURSE SRVNET_SOURCES CONFIGURE_DEPENDS
    "Public/*.h"
    "Private/*.h"
    "Private/*.cpp"
)
if(SRVN_OS_WINDOWS)
    list(FILTER SRVNET_SOURCES EXCLUDE REGEX ".*/Unix/.*")
elseif(UNIX)
    list(FILTER SRVNET_SOURCES EXCLUDE REGEX ".*/Windows/.*")
endif()

set(SRVNET_GENERATED_SOURCES
    "${CMAKE_CURRENT_BINARY_DIR}/Public/SRVNet/Version.h"
)

add_library(SRVNet ${SRVNET_SOURCES} ${SRVNET_GENERATED_SOURCES})
add_library(SRVNet::SRVNet ALIAS SRVNet)

target_compile_features(SRVNet PUBLIC cxx_std_20)

target_include_directories(SRVNet
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/Public>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/Public>
    PRIVATE
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/Private>
)

# TODO: Add custom SRVN_BUILD_SHARED_LIBS
target_compile_definitions(SRVNet PRIVATE
    $<$<BOOL:${BUILD_SHARED_LIBS}>:SRVNET_EXPORTS>
)
target_compile_definitions(SRVNet PUBLIC
    $<$<NOT:$<BOOL:${BUILD_SHARED_LIBS}>>:SRVNET_STATIC>
)

# MSVC-only: keep iterator debug level consistent with build config to avoid
# ODR violations when mixing debug/release CRT objects.
if(SRVN_COMPILER_MSVC)
    target_compile_definitions(SRVNet PRIVATE
        $<$<CONFIG:Debug>:_ITERATOR_DEBUG_LEVEL=2>
        $<$<CONFIG:Release>:_ITERATOR_DEBUG_LEVEL=0>
    )
endif()

# Windows-specific definitions (applies to any compiler targeting Windows)
if(SRVN_OS_WINDOWS)
    target_compile_definitions(SRVNet PRIVATE
        WIN32_LEAN_AND_MEAN
        NOMINMAX
        _CRT_SECURE_NO_WARNINGS
        _WINSOCK_DEPRECATED_NO_WARNINGS
    )
    target_link_libraries(SRVNet PRIVATE ws2_32 iphlpapi winmm)
elseif(UNIX)
    find_package(Threads REQUIRED)
    target_link_libraries(SRVNet PRIVATE Threads::Threads)
endif()

set_target_warnings(SRVNet)
srvn_enable_sanitizers(SRVNet)
set_public_symbols_hidden(SRVNet)

set_target_properties(SRVNet PROPERTIES
    OUTPUT_NAME "SRVNet$<$<CONFIG:Debug>:-d>"
    FOLDER "Source/SRVNet"
    POSITION_INDEPENDENT_CODE ON
)


source_group(TREE ${CMAKE_CURRENT_SOURCE_DIR} FILES ${SRVNET_SOURCES})
source_group(
    TREE "${CMAKE_CURRENT_BINARY_DIR}/Public"
    PREFIX "Generated Files"
    FILES ${SRVNET_GENERATED_SOURCES}
)