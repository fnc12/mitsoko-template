//
//  VkApi.cpp
//  mitsoko_ios
//
//  Created by John Zakharov on 09.06.17.
//  Copyright © 2017 Mitsoko. All rights reserved.
//

#include "VkApi.hpp"
#include "Mitsoko/Url/Request.hpp"

Services::VkApi Services::VkApi::shared;

using namespace Mitsoko::Url;

using nlohmann::json;

void Services::VkApi::requestCountries(const std::string &lang,
                                       std::function<void(std::vector<Country>, std::string)> cb)
{
    Request request;
    //  https://api.vk.com/method/database.getCountries?lang=en
    request.url("https://api.vk.com/method/database.getCountries", {
        { "lang", lang },
    });
    request.timeout(10);
    request.performAsync([=](Response response, std::vector<char> data, Error error){
        if(response){
            auto statusCode = response.statusCode();
            if(statusCode == 200){
                try{
                    std::string dataString{ data.begin(), data.end() };
                    auto j = json::parse(dataString);
                    auto countries = j["response"].get<std::vector<Country>>();
                    cb(std::move(countries), {});
                }catch(std::domain_error e){
                    cb({}, e.what());
                }catch(...){
                    cb({}, "Invalid data");
                }
            }else{
                std::string errorText{ data.begin(), data.end() };
                if(!errorText.length()){
                    errorText = "Undefined error";
                }
                cb({}, errorText);
            }
        }else{
            cb({}, error.message());
        }
    });
}
