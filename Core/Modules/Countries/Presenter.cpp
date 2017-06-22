
#include "Presenter.hpp"

#include <iostream>

using std::cout;
using std::endl;

using namespace Mitsoko;

void Modules::Countries::Presenter::init(std::vector<Country> countries) {
    this->countries = std::move(countries);
    cout << "this->countries.size = " << this->countries.size() << endl;
    view.setTitle("Countries(" + std::to_string(this->countries.size()) + ")");
    view.createDataSource = [=] {
        DataSource res;
        res.getSectionsCountLambda = [=]{
            return 1;
        };
        res.getRowsCountLambda = [=](int section) {
            return this->countries.size();
        };
        res.getItemIdLambda = [=](int section, int row) -> std::string {
            if(row < this->countries.size()){
                return std::to_string(this->countries[row].cid);
            }else{
                return {};
            }
        };
        res.getItemLambda = [=](int section, int row) -> CountryView {
            if(row < this->countries.size()){
                return {this->countries[row].title};
            }else{
                return {};
            }
        };
        return res;
    };
}
