
#pragma once

#include <map>
#include <string>

namespace R {
    typedef std::map<std::string, std::string> LocalizedStringsMap;
    typedef std::map<std::string,LocalizedStringsMap> LocalizedStringsMaps;
    static const LocalizedStringsMaps& localizedStrings(){
        static LocalizedStringsMaps res{
            {"en",{
                {"done","Done"},
            }},
            {"ru",{
                {"done","Готово"},
            }},
        };
        return res;
    }
}
