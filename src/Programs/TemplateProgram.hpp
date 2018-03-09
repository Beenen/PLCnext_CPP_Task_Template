#pragma once
#include <Arp/System/Core/Arp.h>
#include <Arp/Plc/Esm/ProgramBase.hpp>
#include <Arp/System/Commons/Logging.h>

using namespace Arp;
using namespace Arp::Plc::Esm;

namespace TemplateLibrary {
	namespace TemplateComponent {
		class TemplateProgram : public ProgramBase, private Loggable<TemplateProgram> {
			public:
				TemplateProgram(const String& name);
				TemplateProgram(const TemplateProgram& arg) = delete;
				virtual ~TemplateProgram(void) = default;

				TemplateProgram& operator=(const TemplateProgram& arg) = delete;

				void Execute(void) override;

			private:
				bit OP_Bit = false;
				uint8 OP_Byte = 0x10;
		};
	}
}