#include "SRVNet/SRVNetImplInternal.h"
#include "SRVNet/Config.h"


#include <string>

#include <winsock2.h>
#include <ws2tcpip.h>
#include <mmsystem.h>


namespace SRVNet::Platform
{

	bool PlatformInit(std::string& errorMsg)
	{
		WORD versionRequested = MAKEWORD(2, 2);
		WSAData wsaData = { 0 };
		if (::WSAStartup(versionRequested, &wsaData) != 0)
		{
			errorMsg = "WSAStartup failed";
			return false;
		}

		if (LOBYTE(wsaData.wVersion) != 2 || HIBYTE(wsaData.wVersion) != 2)
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

		return true;
	}	
	
	void PlatformShutdown()
	{
		::timeEndPeriod(1);
		::WSACleanup();
	}
}