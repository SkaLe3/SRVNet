#include "SRVNet/SRVNetImpl.h"
#include "SRVNet/SRVNetImplInternal.h"
#include <atomic>

std::atomic<int> s_ActiveImplementationRefCount(0);

namespace SRVNet
{

	bool SRVNetImplementationAddRef(std::string& errorMsg)
	{

		// TODO: Assert that the caller holds the global runtime lock.
		if (s_ActiveImplementationRefCount.load(std::memory_order_acquire) == 0)
		{
			if (!Platform::PlatformInit(errorMsg))
			{
				return false;
			}
		}

		s_ActiveImplementationRefCount.fetch_add(1, std::memory_order_acq_rel);

		// TODO: AtExitHandler

		return true;
	}

	void SRVNetImplementationDecRef()
	{
		if (s_ActiveImplementationRefCount.fetch_sub(1, std::memory_order_acq_rel) == 1)
		{
			Platform::PlatformShutdown();
		}
	}
}