package kz.outlawstudio.viper;

import android.content.DialogInterface;
import android.text.Editable;
import android.view.View;
import android.widget.CompoundButton;

public class EventHandlers {
    static class AlertDialogClickListener implements DialogInterface.OnClickListener{
        static int id=1;

        int mId;

        public AlertDialogClickListener(){
            mId=id++;
        }

        @Override
        public void onClick(DialogInterface dialog, int which) {
            this.onClick(mId, dialog, which);
        }

        native void onClick(int id,Object dialog, int which);
    }

    static class CompoundButtonOnCheckedChangeListener implements CompoundButton.OnCheckedChangeListener{
        static int id=1;

        int mId;

        public CompoundButtonOnCheckedChangeListener(){
            mId=id++;
        }

        @Override
        public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
            this.onCheckedChanged(mId,buttonView,isChecked);
        }

        native void onCheckedChanged(int id,CompoundButton buttonView,boolean isChecked);
    }

    static class ViewOnClickListener implements View.OnClickListener{
        static int id=1;

        int mId;

        public ViewOnClickListener(){
            mId=id++;
        }

        @Override
        public void onClick(View v) {
            this.onClick(mId,v);
        }

        native void onClick(int id,View v);
    }

    static class TextViewTextChangedListener implements android.text.TextWatcher{
        static int id=1;

        int mId;

        public TextViewTextChangedListener(){
            mId=id++;
        }

        @Override
        public void onTextChanged(CharSequence s, int start, int before, int count) {
            this.onTextChanged(mId,s,start,before,count);
        }

        native void onTextChanged(int id,CharSequence s,int start, int before, int count);

        @Override
        public void beforeTextChanged(CharSequence s, int start, int count, int after) {
            this.beforeTextChanged(mId,s,start,count,after);
        }

        native void beforeTextChanged(int id,CharSequence s, int start, int count, int after);

        @Override
        public void afterTextChanged(Editable s) {
            this.afterTextChanged(mId,s);
        }

        native void afterTextChanged(int id,Editable s);
    }
}
