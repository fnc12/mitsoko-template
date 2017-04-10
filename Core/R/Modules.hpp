
#pragma once

#include <tuple>
#include "Mitsoko/Module.hpp"

#include "Modules/Start/Presenter.hpp"

#define MODULE(X) Viper::Module<X::View, X::Presenter>
namespace R {
	using namespace Modules;
	typedef std::tuple<
	MODULE(Modules::Start)
	> ModulesTuple;
}

#undef MODULE
