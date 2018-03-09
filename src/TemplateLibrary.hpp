#pragma once
#include <Arp/System/Core/Arp.h>
#include <Arp/System/Core/AppDomain.hpp>
#include <Arp/System/Core/Singleton.hxx>
#include <Arp/System/Core/Library.h>
#include <Arp/System/Acf/LibraryBase.hpp>

using namespace Arp;
using namespace Arp::System::Acf;

namespace TemplateLibrary {
	class TemplateLibrary : public LibraryBase, public Singleton<TemplateLibrary> {
		public:
			typedef Singleton<TemplateLibrary> TSingletonBase;

			TemplateLibrary(AppDomain& appDomain);
			virtual ~TemplateLibrary(void) = default;

			static void Main(AppDomain& appDomain);
			static ILibrary* GetInstance(void);

		private:
			TemplateLibrary(const TemplateLibrary& arg) = delete;
			TemplateLibrary& operator=(const TemplateLibrary& arg) = delete;
	};

	extern "C" void DynamicLibrary_Main(AppDomain& appDomain);
	extern "C" ILibrary* DynamicLibrary_GetInstance(void);
}
