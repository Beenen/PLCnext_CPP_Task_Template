#include "TemplateProgram.hpp"

namespace TemplateLibrary {
	namespace TemplateComponent {
		TemplateProgram::TemplateProgram(const String& name) : ProgramBase(name) {
			AddPortInfo("OP_Bit", this->OP_Bit);
			AddPortInfo("OP_Byte", this->OP_Byte);
		}

		void TemplateProgram::Execute() {
			this->OP_Bit = this->OP_Bit ? false : true;
			this->OP_Byte = (this->OP_Byte & 0x40) > 0 ? 0x02 : this->OP_Byte << 1;
		}
	}
}