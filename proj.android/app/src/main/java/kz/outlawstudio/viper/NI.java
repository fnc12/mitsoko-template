package kz.outlawstudio.viper;

import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.util.Log;

import org.mitsokoframework.mitsoko_android.BuildConfig;


public class NI {
    static final NI _shared=new NI();

    static {
        try{
            System.loadLibrary("crystax");
        }catch (UnsatisfiedLinkError ule){
            Log.e("Mitsoko", "WARNING: Could not load native library: " + ule.getMessage());
        }
        try {
            System.loadLibrary("NI");

            /**
             * Next line firstly was in constructor but it turned out that `System.loadLibrary("NI");`
             * line executed before `NI` constructor so I changed this line's place into here.
             */
            _shared.setAppId(BuildConfig.APPLICATION_ID);
        } catch (UnsatisfiedLinkError ule) {
            Log.e("Mitsoko", "WARNING: Could not load native library: " + ule.getMessage());
        }
    }

    NI(){}

    public static NI shared(){
        return _shared;
    }

    public native void onActivityResult(int viewId, int requestCode, int resultCode, Intent data);

    //  viper dispatch..
    public native void postBackgroundCode(int callbackId, boolean isMainThread);

    //  storage..
//    public native void setDocumentsPath(String documentsPath);

    //  mitsoko view..
    public native void sendMessageToView(int viewId, int messageCode, String arguments);
    public void sendMessageToView(int viewId, int messageCode){
        sendMessageToView(viewId, messageCode, "");
    }
    public native void viewWillDisappearWithId(int viewId);
    public native void viewDidAppearWithId(int viewId);
    public native void viewWillAppearWithId(int viewId);
    public native int viewCreated(Object view,String className);
    public native void viewDestroyed(int viewId);

    public static int getResourseId(Context context, String resourseId, String folderName){
        return context.getResources().getIdentifier(resourseId, folderName, context.getPackageName());
    }

    public native void setAppId(String appId);

    public native void urlResponseReceived(int requestId,
                                           Network.ResponseTuple.Response response,
                                           byte[] data,
                                           Network.ResponseTuple.Error error);

    public native void urlResponseImageReceived(int requestId,
                                                Network.ResponseTuple.Response response,
                                                Bitmap bitmap,
                                                Network.ResponseTuple.Error error);


}
