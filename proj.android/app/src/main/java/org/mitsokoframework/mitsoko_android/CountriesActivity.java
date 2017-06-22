package org.mitsokoframework.mitsoko_android;

import android.os.Bundle;
import android.widget.ListView;

import kz.outlawstudio.viper.BaseActivity;

public class CountriesActivity extends BaseActivity {
    ListView listView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_countries);
        listView = (ListView)findViewById(R.id.list);
    }
}
