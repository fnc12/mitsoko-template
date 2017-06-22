package org.mitsokoframework.mitsoko_android;

import android.app.ProgressDialog;
import android.graphics.Color;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.Button;
import android.widget.EditText;

import kz.outlawstudio.viper.BaseActivity;

public class StartActivity extends BaseActivity {
//    EditText editText;
    Button mainBtn;

    ProgressDialog progressDialog = null;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_start);

//        editText = (EditText)findViewById(R.id.edit);
        mainBtn = (Button)findViewById(R.id.main);
    }

    void showProgress() {
        if(progressDialog == null) {
            progressDialog = new ProgressDialog(this);
            progressDialog.setTitle("Loading");
            progressDialog.show();
        }
    }

    void hideProgress() {
        if(progressDialog != null) {
            progressDialog.hide();
            progressDialog = null;
        }
    }
}
