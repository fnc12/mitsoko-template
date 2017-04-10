package org.mitsokoframework.mitsoko_android;

import android.graphics.Color;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.Button;
import android.widget.EditText;

import kz.outlawstudio.viper.BaseActivity;

public class StartActivity extends BaseActivity {
    EditText editText;
    Button mainBtn;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_start);

        editText = (EditText)findViewById(R.id.edit);
        mainBtn = (Button)findViewById(R.id.main);
    }
}
