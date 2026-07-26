#include "SRVNet/SRVNetCore.h"
#include "SRVNet/SRVNetImpl.h"
#include "SRVNet.h"

namespace SRVNet
{

	bool SRVNetCore::InitSRVNet(std::string& errorMsg)
	{
		if (m_bHasImplementationRef) 	// TODO: Convert to assert
		{
			errorMsg = "Initialized SRVNetCore twice";
			return false;
		}

		if (!InitImplementation(errorMsg))
		{
			return false;
		}

		return true;
	}

	void SRVNetCore::Destroy()
	{
		// TODO: Assert that the caller holds the global runtime lock.

		// Free resources outside of destructor to be able to call virtual functions
		FreeResources();
		delete this;
	}

	void SRVNetCore::FreeResources()
	{
		if (m_bHasImplementationRef)
		{
			m_bHasImplementationRef = false;
			SRVNetImplementationDecRef();
		}
	}

	bool SRVNetCore::InitImplementation(std::string& errorMsg)
	{
		if (m_bHasImplementationRef)
			return true;
		if (!SRVNetImplementationAddRef(errorMsg))
			return false;

		m_bHasImplementationRef = true;
		return true;
	}

}

using namespace SRVNet;

static SRVNetCore* s_SRVNCore = nullptr;

SRVNET_API bool SRVNetInit(std::string& errorMsg)
{
	// TODO: Lock mutex here

	if (s_SRVNCore)
	{
		// TODO: Assert
		return true;
	}

	SRVNetCore* SRVNetCoreInstance = new SRVNetCore();
	if (!SRVNetCoreInstance->InitSRVNet(errorMsg))
	{
		// TODO: Destroy
		return false;
	}
	s_SRVNCore = SRVNetCoreInstance;
	return true;
}

SRVNET_API void SRVNetKill()
{
	// TODO: Locko mutex here
	if (s_SRVNCore)
	{
		s_SRVNCore->Destroy();
		s_SRVNCore = nullptr;
	}
}