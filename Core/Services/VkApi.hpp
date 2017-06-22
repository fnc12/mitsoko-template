//
//  VkApi.hpp
//  mitsoko_ios
//
//  Created by John Zakharov on 09.06.17.
//  Copyright © 2017 Mitsoko. All rights reserved.
//

#ifndef VkApi_hpp
#define VkApi_hpp

#include <functional>
#include <vector>

#include "DataModel/Country.hpp"

namespace Services {
    
    using namespace DataModel;
    
    struct VkApi {
        static VkApi shared;
        
        void requestCountries(const std::string &lang,
                              std::function<void(std::vector<Country>, std::string)> cb);
    };
}

#endif /* VkApi_hpp */
