#include "SRVNet/SRVNetImpl.h"
#include "SRVNet/Config.h"
#include "SRVNet/SocketImpl.h"

#include <atomic>
#include <string>

#include <winsock2.h>
#include <ws2tcpip.h>
#include <mmsystem.h>

// TODO: Move refcounting outside of platform specific files
std::atomic<int> s_ActiveImplementationRefCount(0);

namespace SRVNet
{

	bool SRVNetImplementationAddRef(std::string& errorMsg)
	{
		// TODO: Assert that the caller holds the global runtime lock.


		if (s_ActiveImplementationRefCount.load(std::memory_order_acquire) == 0)
		{
			WORD versionRequested = MAKEWORD(2, 2);
			WSAData wsaData = {0};
			if (::WSAStartup(versionRequested, &wsaData) != 0)
			{
				errorMsg = "WSAStartup failed";
				return false;
			}

			if (LOBYTE(wsaData.wVersion) != 2 || HIBYTE(wsaData.wVersion) != 1)
			{
				::WSACleanup();
				return false;
			}

			if (::timeBeginPeriod(1) != 0)
			{
				::WSACleanup();
				errorMsg = "timeBeginPeriod failed";
				return false;
			}
		}

		s_ActiveImplementationRefCount.fetch_add(1, std::memory_order_acq_rel);

		// TODO: AtExitHandler

		return true;
	}

	void SRVNetImplementationDecRef()
	{
		::WSACleanup();
	}
}