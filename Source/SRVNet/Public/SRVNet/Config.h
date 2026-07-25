#pragma once

#if defined(_WIN32)

#define SRVNET_SYSTEM_WINDOWS

#ifndef NOMINMAX
#define NOMINMAX
#endif

#elif defined(__unix__)

#if defined(__ANDROID__)
#define SRVNET_SYSTEM_ANDROID
#elif defined(__linux__)
#define SRVNET_SYSTEM_LINUX
#else
#error This UNIX operating system is not supported by SRVNet library
#endif

#else
#error This operating system is not supported by SRVN library
#endif

// Ensure minimum C++ language standard
#if (defined(_MSVC_LANG) && _MSVC_LANG < 202002L) || (!defined(_MSVC_LANG) && __cplusplus < 202002L)
#error "SRVNet requires C++20 or newer. Please enable /std:c++20 (MSVC) or -std=c++20 (GCC/Clang)."
#endif

#if !defined(NDEBUG)
#define SRVNET_DEBUG
#endif


#if !defined(SRVNET_STATIC)

#if defined(SRVNET_SYSTEM_WINDOWS)

#define SRVNET_API_EXPORT __declspec(dllexport)
#define SRVNET_API_IMPORT __declspec(dllimport)

#ifdef _MSC_VER

#pragma warning(disable : 4251) // Using standard library types in our own exported types is okay
#pragma warning(disable : 4275) // Exporting types derived from the standard library is okay

#endif

#else // Linux

#define SRVNET_API_EXPORT [[gnu::visibility("default")]]
#define SRVNET_API_IMPORT [[gnu::visibility("default")]]

#endif

#else

#define SRVNET_API_EXPORT
#define SRVNET_API_IMPORT

#endif
