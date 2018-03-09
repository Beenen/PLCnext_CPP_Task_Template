#include "TemplateLibrary.hpp"
#include "Components/TemplateComponent.hpp"
#include <Arp/System/Core/TypeName.hxx>

namespace TemplateLibrary {
	TemplateLibrary::TemplateLibrary(AppDomain& appDomain) : LibraryBase(appDomain) {
		this->componentFactory.AddFactoryMethod("TemplateComponent", &TemplateComponent::Create);
	}

	void TemplateLibrary::Main(AppDomain& appDomain) {
		TSingletonBase::CreateInstance(appDomain);
	}

	ILibrary* TemplateLibrary::GetInstance() {
		return &TSingletonBase::GetInstance();
	}

	extern "C" void DynamicLibrary_Main(AppDomain& appDomain) {
		TemplateLibrary::Main(appDomain);
	}

	extern "C" ILibrary* DynamicLibrary_GetInstance() {
		return TemplateLibrary::GetInstance();
	}
}
