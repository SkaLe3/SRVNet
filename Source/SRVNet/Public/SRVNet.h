#pragma once

#include "SRVNet/Export.h"
#include "SRVNet/Version.h"
#include "SRVNet/SRVNetCore.h" // TODO: Make private, use interface instead

extern "C"
{
	SRVNET_API bool SRVNetInit(std::string& errorMsg);
	SRVNET_API void SRVNetKill();
}