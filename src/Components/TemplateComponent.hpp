#pragma once
#include <Arp/System/Core/Arp.h>
#include <Arp/System/Acf/ComponentBase.hpp>
#include <Arp/System/Acf/IApplication.hpp>
#include <Arp/Plc/Esm/IProgramComponent.hpp>

#include "ProgramProviders/TemplateProgramProvider.hpp"

using namespace Arp;
using namespace Arp::System::Acf;

namespace TemplateLibrary {
	class TemplateComponent : public ComponentBase, public IProgramComponent {
		public:
			TemplateComponent(IApplication& application, const String& name);
			virtual ~TemplateComponent(void) = default;

			static IComponent::Ptr Create(IApplication& application, const String& componentName);

			void Initialize(void) override;
			void LoadSettings(const String& settingsPath) override;
			void SetupSettings(void) override;
			void SubscribeServices(void) override;
			void LoadConfig(void) override;
			void SetupConfig(void) override;
			void ResetConfig(void) override;
			void PublishServices(void) override;
			void Dispose(void) override;
			void PowerDown(void) override;

			IProgramProvider* GetProgramProvider(void) override;

		private:
			TemplateComponent(const TemplateComponent& arg) = delete;
			TemplateComponent& operator=(const TemplateComponent& arg) = delete;

			TemplateProgramProvider programProvider;
	};

	inline TemplateComponent::TemplateComponent(IApplication& application, const String& name) : ComponentBase(application, name, ComponentCategory::Custom, Version(0)) {
	}

	inline IComponent::Ptr TemplateComponent::Create(IApplication& application, const String& componentName) {
		return IComponent::Ptr(new TemplateComponent(application, componentName));
	}

	inline IProgramProvider* TemplateComponent::GetProgramProvider() {
		return &programProvider;
	}
}