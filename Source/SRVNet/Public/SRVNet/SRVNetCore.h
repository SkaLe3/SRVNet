#pragma once
#include "SRVNet/Export.h"

#include <string>

namespace SRVNet
{
	class SRVNetCore
	{
	public:
		bool InitSRVNet(std::string& errorMsg);
		bool IsInitialized() const { return m_bHasImplementationRef; }

		void Destroy();
		virtual void FreeResources();

	protected:
		bool InitImplementation(std::string& errorMsg);

	protected:
		bool m_bHasImplementationRef;
	};
}