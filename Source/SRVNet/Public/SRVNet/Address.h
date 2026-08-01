#pragma once

#include "SRVNet/Export.h"
#include <cstdint>

namespace SRVNet
{
	SRVNET_API class Address
	{
	public:
		Address();

		Address(uint8_t a,
				uint8_t b,
				uint8_t c,
				uint8_t d,
				uint16_t port);

		Address(uint32_t address, uint16_t port);

		uint32_t GetAddress() const;

		uint8_t GetA() const;
		uint8_t GetB() const;
		uint8_t GetC() const;
		uint8_t GetD() const;

		uint16_t GetPort() const;

	private:
		uint32_t m_Address;
		uint16_t m_Port;
	};
}