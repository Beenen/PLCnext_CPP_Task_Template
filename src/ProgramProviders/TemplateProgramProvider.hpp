#pragma once
#include <Arp/System/Core/Arp.h>
#include <Arp/Plc/Esm/IProgramProvider.hpp>

using namespace Arp;
using namespace Arp::Plc::Esm;

namespace TemplateLibrary {
	class TemplateProgramProvider : public IProgramProvider {
		public:
			TemplateProgramProvider(void) = default;
			TemplateProgramProvider(const TemplateProgramProvider& arg) = delete;
			~TemplateProgramProvider(void) = default;

			TemplateProgramProvider& operator=(const TemplateProgramProvider& arg) = delete;

			IProgram* CreateProgram(const String& programName, const String& programType) override;
	};
}