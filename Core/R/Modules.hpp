
#pragma once

#include <tuple>
#include "Mitsoko/Module.hpp"

#include "Modules/Start/Presenter.hpp"

#include "Modules/Countries/Presenter.hpp"

#define MODULE(X) Viper::Module<X::View, X::Presenter>
namespace R {
	using namespace Modules;
	typedef std::tuple<
	MODULE(Modules::Start),
	MODULE(Modules::Countries)
	> ModulesTuple;
}

#undef MODULE
