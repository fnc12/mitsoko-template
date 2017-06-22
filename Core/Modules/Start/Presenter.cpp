
#include "Presenter.hpp"

#include "Modules/Countries/Presenter.hpp"

#include <iostream>

using std::cout;
using std::endl;

using namespace Mitsoko;

using namespace DataModel;

void Modules::Start::Presenter::init() {
    cout << "Hi!" << endl;
    view.setTitle("Table list view example");
    view.setMainBtnTitle("Request countries");
    view.mainBtnTouched = [=] {
        view.showProgress();
        api.requestCountries("en",
                             [=](std::vector<Country> countries, std::string errorText){
                                 view.hideProgress();
                                 if(!errorText.length()){
                                     cout << "countries = " << countries.size() << endl;
                                     this->countries = std::move(countries);
                                     wireframe.open<Countries::Presenter>(NavigationPusher(), ActivityStarter(), argument(this->countries));
                                 }else{
//                                     cout << "error = " << errorText << endl;
                                 }
                             });
    };
}
