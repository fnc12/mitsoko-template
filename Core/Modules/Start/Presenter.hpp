
#pragma once

#include "Mitsoko/Presenter.hpp"
#include "View.hpp"

namespace Modules {
    namespace Start{
        struct Presenter : public Mitsoko::Presenter<View> {
            
            void init();
            
        };
    }
}

