package kz.outlawstudio.viper;

import android.os.Looper;

import kz.outlawstudio.viper.NI;

public class BackgroundRunnable implements Runnable {
    int mId;

    public BackgroundRunnable(int id) {
        mId = id;
    }

    @Override
    public void run() {
//        System.out.println("background code "+mId);
        final boolean isMainThread=Looper.myLooper() == Looper.getMainLooper();
        NI.shared().postBackgroundCode(mId, isMainThread);
//        System.out.println("/background code "+mId);
//        new Handler().post()
    }
}
