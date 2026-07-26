#include <iostream>
#include <SRVNet.h>

#if 0
#include <winsock2.h>
#include <cstdint>
using int32 = int32_t;
#endif

int main(int argc, char* argv)
{
    (void)argc;
    (void*)argv;

    std::cout << "Running SRVNet v" << SRVN::Version::string << "\n";
    std::string error;
    
    if (!SRVNetInit(error))
    {
        std::cout << error << std::endl;
    }


#if 0
    // abstract sockets, support both tcpip and udp with polymorphism

    // UDP
    int32 handle = ::socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
    if (handle <= 0)
    {
        std::cout << "Failed to create socket\n";
        return false;
    }

	sockaddr_in address;
	address.sin_family = AF_INET;
	address.sin_addr.s_addr = INADDR_ANY;
	address.sin_port =
		::htons((unsigned short)port); // use port 0 to assign automatically
		// htons  - "host to network" converts "little or big-endian" to "big-endian"
		// htonl - "host to netwrok long"

	if (::bind(handle,
		(const sockaddr*)&address,
		sizeof(sockaddr_in)) < 0)
	{
		std::cout << "failed to bind socket\n";
		return false;
	}

	
	//If socket is set to blocking mode, recvfrom will not return until a packet is available to read  
	 
	DWORD nonBlocking = 1;
	if (ioctlsocket(handle,
		FIONBIO,
		&nonBlocking) != 0)
	{
		std::cout << "failed to set non-blocking\n";
		return false;
	}
	// now socket is in non-blocking mode. recvfrom will return immediately

	// there's no connections, so we can send UDP packets to any IP

	/** Sending a packet to a specific address */
	int sent_bytes =
		::sendto(handle,
			(const char*)packet_data,
			packet_size,
			0,
			(sockaddr*)&address,
			sizeof(sockaddr_in));

	if (sent_bytes != packet_size)
	{
		std::cout << "failed to send packet\n";
		return false;
	}

	/** Creating an address structure used above */
	unsigned int a = 207;
	unsigned int b = 45;
	unsigned int c = 186;
	unsigned int d = 98;
	unsigned short port = 30000;

	unsigned int address = (a << 24) |
		(b << 16) |
		(c << 8) |
		d;

	sockaddr_in addr;
	addr.sin_family = AF_INET;
	addr.sin_addr.s_addr = htonl(address);
	addr.sin_port = htons(port);

	/** Receiving incoming packets */
	while (true)
	{
		unsigned char packet_data[256];

		unsigned int max_packet_size =
			sizeof(packet_data);

#if PLATFORM == PLATFORM_WINDOWS
		typedef int socklen_t;
#endif

		sockaddr_in from;
		socklen_t fromLength = sizeof(from);

		int bytes = recvfrom(socket,
			(char*)packet_data,
			max_packet_size,
			0,
			(sockaddr*)&from,
			&fromLength);

		if (bytes <= 0)
			break;

		unsigned int from_address =
			ntohl(from.sin_addr.s_addr);

		unsigned int from_port =
			ntohs(from.sin_port);

		// process received packet
	}

	/** closing a socket */
#if PLATFORM == PLATFORM_MAC || 
	PLATFORM == PLATFORM_UNIX
		close(socket);
#elif PLATFORM == PLATFORM_WINDOWS
	closesocket(socket);
#endif


	// =============================================

    // TCP
	socket_t s = ::socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
	m_Handle = (s == INVALID_SOCKET) ? nullptr : reinterpret_cast<void*>(s);

	sockaddr_in addr{};
	addr.sin_family = AF_INET;
	addr.sin_port = htons(port);
	addr.sin_addr.s_addr = INADDR_ANY;

	socket_t s = reinterpret_cast<socket_t>(m_Handle);
	return ::bind(s, (sockaddr*)&addr, sizeof(addr)) == 0;


#endif





    SRVNetKill();

    return 0;
}