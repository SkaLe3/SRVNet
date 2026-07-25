include(${CMAKE_CURRENT_LIST_DIR}/CompilerWarnings.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/Sanitizers.cmake)

# Hide all non-explicitly-exported symbols from the ABI (library targets only)
function(set_public_symbols_hidden target)
    set_target_properties(${target} PROPERTIES
        CXX_VISIBILITY_PRESET hidden
        VISIBILITY_INLINES_HIDDEN YES
    )
endfunction()

# Add a new SRVNet sample executable.
# Usage: srvn_add_example(<target> SOURCES <files...> [DEPENDS <libs...>])
function(srvn_add_example target)
    cmake_parse_arguments(THIS "" "" "SOURCES;DEPENDS" ${ARGN})

    if(NOT THIS_SOURCES)
        message(FATAL_ERROR "srvn_add_example: SOURCES is required")
    endif()

    add_executable(${target} ${THIS_SOURCES})

    set_target_warnings(${target})
    srvn_enable_sanitizers(${target})

    set_target_properties(${target} PROPERTIES
        DEBUG_POSTFIX -d
        FOLDER "Samples"
    )

    source_group(TREE ${CMAKE_CURRENT_SOURCE_DIR} FILES ${THIS_SOURCES})

    if(THIS_DEPENDS)
        target_link_libraries(${target} PRIVATE ${THIS_DEPENDS})
    endif()
endfunction()

# Add a new SRVNet test executable.
# Intentionally does NOT link a custom test-main — Catch2 (or another framework)
# provides its own main. Just link the framework via DEPENDS.
# Usage: srvn_add_test(<target> SOURCES <files...> [DEPENDS <libs...>])
function(srvn_add_test target)
    cmake_parse_arguments(THIS "" "" "SOURCES;DEPENDS" ${ARGN})

    if(NOT THIS_SOURCES)
        message(FATAL_ERROR "srvn_add_test: SOURCES is required")
    endif()

    add_executable(${target} ${THIS_SOURCES})

    set_target_warnings(${target})
    srvn_enable_sanitizers(${target})

    set_target_properties(${target} PROPERTIES
        FOLDER "Test"
        DEBUG_POSTFIX -d
    )

    source_group(TREE ${CMAKE_CURRENT_SOURCE_DIR} FILES ${THIS_SOURCES})

    if(THIS_DEPENDS)
        target_link_libraries(${target} PRIVATE ${THIS_DEPENDS})
    endif()

    add_test(NAME ${target} COMMAND ${target})
endfunction()