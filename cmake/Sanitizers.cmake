
function(srvn_enable_sanitizers target)

    if(SRVN_ENABLE_ASAN AND SRVN_ENABLE_TSAN)
        message(FATAL_ERROR
            "AddressSanitizer and ThreadSanitizer cannot be enabled together."
        )
    endif()

    if(SRVN_ENABLE_ASAN)
        if(SRVN_COMPILER_MSVC)
            target_compile_options(${target} PRIVATE
                /fsanitize=address
            )
            target_link_options(${target} PRIVATE
                /fsanitize=address
            )

        elseif(MINGW)
            message(WARNING "Address Sanitizer is not supported on MinGW GCC. Disabling ASan.")
            return()
        elseif(SRVN_COMPILER_CLANG OR SRVN_COMPILER_CLANG_CL OR SRVN_COMPILER_GCC)
            target_compile_options(${target} PRIVATE
                -fsanitize=address
                -fno-omit-frame-pointer
                -fno-sanitize-recover=all
            )
            target_link_options(${target} PRIVATE
                -fsanitize=address
            )
        else()
            message(WARNING
                "AddressSanitizer is not supported by ${CMAKE_CXX_COMPILER_ID}"
            )

        endif()
    endif()

    if(SRVN_ENABLE_UBSAN)
        if(SRVN_COMPILER_CLANG OR SRVN_COMPILER_CLANG_CL OR SRVN_COMPILER_GCC)
            target_compile_options(${target} PRIVATE
                -fsanitize=undefined
                -fno-omit-frame-pointer
                -fno-sanitize-recover=all
            )

            target_link_options(${target} PRIVATE
                -fsanitize=undefined
            )
        else()
            message(WARNING
                "UndefinedBehaviorSanitizer is not supported by ${CMAKE_CXX_COMPILER_ID}."
            )
        endif()
    endif()

    if(SRVN_ENABLE_TSAN)
        if(SRVN_COMPILER_CLANG OR SRVN_COMPILER_CLANG_CL OR SRVN_COMPILER_GCC)
            target_compile_options(${target} PRIVATE
                -fsanitize=thread
                -fno-omit-frame-pointer
                -fno-sanitize-recover=all
            )

            target_link_options(${target} PRIVATE
                -fsanitize=thread
            )
        else()
            message(WARNING
                "ThreadSanitizer is not supported by ${CMAKE_CXX_COMPILER_ID}."
            )
        endif()
    endif()

endfunction()