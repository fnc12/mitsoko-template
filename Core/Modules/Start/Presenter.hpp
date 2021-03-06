
#pragma once

#include "Mitsoko/Presenter.hpp"
#include "View.hpp"

#include "Services/VkApi.hpp"
#include "DataModel/Country.hpp"

#include <vector>

namespace Modules {
    
    namespace Start{
        
        using Services::VkApi;
        
        using DataModel::Country;
        
        struct Presenter : public Mitsoko::Presenter<View> {
            
            void init();
            
        protected:
            
            VkApi &api = VkApi::shared;
            std::vector<Country> countries;
            
        };
    }
}

