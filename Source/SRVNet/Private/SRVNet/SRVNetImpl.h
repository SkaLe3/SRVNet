#pragma once
#include <string>

namespace SRVNet
{

	extern bool SRVNetImplementationAddRef(std::string& errorMsg);
	extern void SRVNetImplementationDecRef();

}