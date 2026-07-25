#pragma once

#include <SRVNet/Config.h>

#if defined(SRVNET_EXPORTS)
#define SRVNET_API SRVNET_API_EXPORT
#else
#define SRVNET_API SRVNET_API_IMPORT
#endif