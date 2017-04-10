package kz.outlawstudio.viper;

import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.os.Bundle;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;


public class BaseActivity extends AppCompatActivity {
    protected final NI ni = NI.shared();
    protected int viewId = -1;
//    String arguments = "";
//    ProgressDialog progress = null;
    boolean initializedInCore=false;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

//        arguments = getIntent().getStringExtra("arguments");
    }

    @Override
    protected void onResume() {
        super.onResume();
        if(!this.initializedInCore){
            this.initializedInCore=true;
            final Class<?> enclosingClass = getClass().getEnclosingClass();
            String className;
            if (enclosingClass != null) {
                className = enclosingClass.getName();
            } else {
                className = getClass().getName();
            }
            viewId = ni.viewCreated(this, className.replace(".", "/"));
        }
        ni.viewWillAppearWithId(viewId);
        ni.viewDidAppearWithId(viewId);
    }

    @Override
    protected void onStop() {
        super.onStop();
        ni.viewWillDisappearWithId(viewId);
    }

    @Override
    protected void onDestroy() {
        System.out.println("view destroyed "+viewId);
        ni.viewDestroyed(viewId);

        super.onDestroy();
//        ni.viewDestroyed(viewId);
    }

    /*public void hideProgress() {
        if (this.progress != null) {
            this.progress.dismiss();
            this.progress = null;
        }
    }

    public void showProgress() {
        if (null == this.progress) {
            this.progress = new ProgressDialog(this);
            this.progress.setTitle("");
            this.progress.setOnCancelListener(new DialogInterface.OnCancelListener() {
                @Override
                public void onCancel(DialogInterface dialog) {
                    progress = null;
                }
            });
            this.progress.show();
        }
    }*/

    /*public void showError(String errorText) {
        final AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle(R.string.error);
        builder.setMessage(errorText);
        builder.setPositiveButton(android.R.string.ok, new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                //..
            }
        });
        builder.create().show();
    }*/
}
