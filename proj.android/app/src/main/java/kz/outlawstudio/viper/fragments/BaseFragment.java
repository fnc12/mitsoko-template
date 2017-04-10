package kz.outlawstudio.viper.fragments;


import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v7.app.AlertDialog;

import kz.outlawstudio.viper.NI;
//import kz.outlawstudio.groozim.R;

public class  BaseFragment extends Fragment {
    protected final NI ni= NI.shared();
    protected int viewId=-1;
    String arguments="";
//    ProgressDialog progress=null;
    boolean initializedInCore=false;

    public BaseFragment() {
        // Required empty public constructor
//        final Activity activity=getActivity();
//        new ViperTableViewAdapter(new ListView(getActivity()),getActivity());
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
//        arguments=getIntent().getStringExtra("arguments");

    }

    @Override
    public void onResume() {
//        System.out.println("onResume "+viewId);
        super.onResume();
        if(!this.initializedInCore){
            this.initializedInCore=true;
            final Class<?> enclosingClass = getClass().getEnclosingClass();
            String className;
            if (enclosingClass != null) {
                className=enclosingClass.getName();
            } else {
                className=getClass().getName();
            }
            viewId=ni.viewCreated(this,className.replace(".","/"));
            System.out.println("created: "+className+" ("+viewId+")");
        }
//        System.out.println("ni.viewWillAppearWithId("+viewId+");");
        ni.viewWillAppearWithId(viewId);
//        System.out.println("ni.viewDidAppearWithId("+viewId+");");
        ni.viewDidAppearWithId(viewId);
//        System.out.println("/onResume "+viewId);
    }

    @Override
    public void onStop() {
        super.onStop();
        ni.viewWillDisappearWithId(viewId);
    }

    @Override
    public void onDestroy() {
        System.out.println("view destroyed "+viewId);
        ni.viewDestroyed(viewId);
        viewId=-1;
        super.onDestroy();
    }

    /*public void showProgress(){
        if(null==this.progress){
            this.progress = new ProgressDialog(getActivity());
            this.progress.setTitle("");
            this.progress.setOnCancelListener(new DialogInterface.OnCancelListener() {
                @Override
                public void onCancel(DialogInterface dialog) {
                    progress=null;
                }
            });
            this.progress.show();
        }
    }

    public void hideProgress(){
        if(this.progress!=null){
            this.progress.dismiss();
            this.progress=null;
        }
    }*/

    /*public void showError(String errorText){
        final AlertDialog.Builder builder=new AlertDialog.Builder(getActivity());
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

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        ni.onActivityResult(viewId,requestCode,resultCode,data);
    }

}
