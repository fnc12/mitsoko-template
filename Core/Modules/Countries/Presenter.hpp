
#pragma once

#include "Mitsoko/Presenter.hpp"
#include "View.hpp"

#include "DataModel/Country.hpp"

#include <vector>

namespace Modules {
    
    namespace Countries{
        
        using DataModel::Country;
        
        struct Presenter : public Mitsoko::Presenter<View>, Mitsoko::Argumentable<std::vector<Country>, Presenter> {
            
            void init(std::vector<Country> countries);
            
        protected:
            std::vector<Country> countries;
        };
    }
}

