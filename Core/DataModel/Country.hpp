//
//  Country.hpp
//  mitsoko_ios
//
//  Created by John Zakharov on 09.06.17.
//  Copyright © 2017 Mitsoko. All rights reserved.
//

#ifndef Country_hpp
#define Country_hpp

#include <string>
#include <json/json.hpp>

namespace DataModel {
    
    struct Country {
        int cid;
        std::string title;
    };
    
    using nlohmann::json;
    
    void to_json(json &j, const Country &o);
    
    void from_json(const json &j, Country &o);
}

#endif /* Country_hpp */
