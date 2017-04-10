
#pragma once

#include "Mitsoko/View.hpp"

namespace Modules {
    
	namespace Start{
        
        using android::widget::EditText;
        using android::widget::Button;
        
        struct View : public Mitsoko::View {
            static const std::string viewName;
#ifdef __APPLE__
            FIELD_DECL(UI::TextField, textField);
            FIELD_DECL(UI::Button, mainBtn);
#else
            FIELD_DECL(EditText, editText);
            FIELD_DECL(Button, mainBtn);
#endif
            void init();
            
            void setTitle(const std::string &value);
            
            void setMainBtnTitle(const std::string &value);
            
            void showAlert(const std::string &title, const std::string &message, std::function<void()> dismissedCallback);
            
            std::string textFromTextField();
            
            void setTextFieldText(const std::string &value);
        
            std::function<void()> mainBtnTouched;
        };
	}
}
