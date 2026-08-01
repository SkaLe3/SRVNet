#pragma once

#include "SRVNet/Export.h"
#include "SRVNet/Address.h"
#include <cstdint>

namespace SRVNet
{
	class SRVNET_API Socket
	{
	public:
		Socket();
		~Socket();

		bool Open(uint16_t port);
		void Close();
		bool IsOpen() const;
		bool Send(const Address& destination, const void* data, int32_t size);
		bool Receive(Address& sender, void* data, int32_t size);

	protected:
		enum class Type
		{
			Tcp, Udp
		};

	private:
		int32_t m_Handle;
		Type m_Type;
		bool m_IsBlocking(true);
	};
}