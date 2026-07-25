#pragma once

#if defined(SRVNET_STATIC)
    #define SRVNET_API
#else
    #if defined(_WIN32) || defined(__CYGWIN__)
        #if defined(SRVNET_EXPORTS)
            #define SRVNET_API __declspec(dllexport)
        #else
            #define SRVNET_API __declspec(dllimport)
        #endif
    #else
        #if defined(__GNUC__) && __GNUC__ >= 4
            #define SRVNET_API __attribute__((visibility("default")))
        #else
            #define SRVNET_API
        #endif
    #endif
#endif
