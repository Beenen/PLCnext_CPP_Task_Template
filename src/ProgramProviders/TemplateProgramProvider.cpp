#include "TemplateProgramProvider.hpp"
#include "Programs/TemplateProgram.hpp"

namespace TemplateLibrary {
	IProgram* TemplateProgramProvider::CreateProgram(const String& programName, const String& programType) {
		if(programType == "TemplateProgram") {
			return new TemplateComponent::TemplateProgram(programName);
		}
		return nullptr;
	}
}