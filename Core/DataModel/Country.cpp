//
//  Country.cpp
//  mitsoko_ios
//
//  Created by John Zakharov on 09.06.17.
//  Copyright © 2017 Mitsoko. All rights reserved.
//

#include "Country.hpp"

namespace Keys {
    const std::string cid = "cid";
    const std::string title = "title";
}

void DataModel::to_json(json &j, const Country &o) {
    using namespace Keys;
    j = {
        { cid, o.cid },
        { title, o.title },
    };
}

void DataModel::from_json(const json &j, Country &o) {
    using namespace Keys;
    o.cid = j[cid];
    o.title = j[title];
}
