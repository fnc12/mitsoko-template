
#pragma once

#include "Mitsoko/View.hpp"

namespace Modules {
    
	namespace Countries{
        
        using android::widget::ListView;
        
        struct CountryView {
            std::string title;
        };
        
        typedef Mitsoko::DataSource<CountryView> DataSource;
        
        struct View : public Mitsoko::View {
            
            static const std::string viewName;
            
            void init();
            
            void setTitle(const std::string &value);
            
            std::function<DataSource()> createDataSource;
            
        protected:
#ifdef __APPLE__
            FIELD_DECL(UI::TableView, tableView);
#else
            FIELD_DECL(ListView, listView);
#endif
        };
	}
}
