
#include "Presenter.hpp"

#include <iostream>

using std::cout;
using std::endl;

using namespace Mitsoko;

void Modules::Start::Presenter::init() {
    cout << "Hi!" << endl;
    view.setTitle("Hi from C++!");
    view.setMainBtnTitle("Go");
    view.mainBtnTouched = [=] {
        auto text = view.textFromTextField();
        if(text.length()){
            view.showAlert("Great!", "Your input: " + text, [=]{
                view.setTextFieldText("");
            });
        }else{
            view.showAlert("Hey", "You input nothing. Please type something into text field", {});
        }
    };
}
