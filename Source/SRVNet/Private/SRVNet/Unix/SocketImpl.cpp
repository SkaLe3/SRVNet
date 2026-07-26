#include "SRVNet/SRVNetImpl.h"
#include <string>

namespace SRVNet
{

	bool SRVNetImplementationAddRef(std::string& errorMsg)
	{
		(void) errorMsg;
		return true;
	}

	void SRVNetImplementationDecRef()
	{
		
	}


}