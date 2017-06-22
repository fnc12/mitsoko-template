
#include "View.hpp"

#include <iostream>

using std::cout;
using std::endl;

using namespace Mitsoko;

using android::support::v7::app::AppCompatActivity;

using android::widget::TextView;

const std::string Modules::Countries::View::viewName =
#ifdef __APPLE__
"CountriesVC";
#else
"org/mitsokoframework/mitsoko_android/CountriesActivity";
#endif

void Modules::Countries::View::init(){
    Adapter<CountryView> adapter(createDataSource());
    adapter.getViewClassLambda = [=](int section, int row, const CountryView &item) {
#ifdef __APPLE__
        return "UITableViewCell";
#else
        return "country_row";
#endif
    };
    adapter.onCreateCellLambda = [=](const void *cellHandle, int section, int row, const CountryView &item) {
#ifdef __APPLE__
        UI::TableView::Cell cell(cellHandle);
        cell.textLabel().setText(item.title);
#else
        android::view::View cell(cellHandle);
        AppCompatActivity activity(handle);
        auto titleTextView = (TextView)cell.findViewById("title", activity);
        titleTextView.setText(item.title);
#endif
    };
#ifdef __APPLE__
    adapterIds.push_back(tableView().setAdapter(adapter));
#else
    AppCompatActivity activity(handle);
    adapterIds.push_back(listView().setAdapter(adapter, activity));
#endif
}

void Modules::Countries::View::setTitle(const std::string &value) {
#ifdef __APPLE__
    UI::ViewController vc(handle);
    vc.navigationItem().setTitle(value);
#else
    AppCompatActivity activity(handle);
    activity.getSupportActionBar().setTitle(value);
#endif
}
