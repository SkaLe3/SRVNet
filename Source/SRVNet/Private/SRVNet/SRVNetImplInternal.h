#pragma once
#include <string>

namespace SRVNet::Platform
{
	bool PlatformInit(std::string& errorMsg);
	void PlatformShutdown();
}