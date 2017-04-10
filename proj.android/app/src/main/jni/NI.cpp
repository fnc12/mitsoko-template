
#include <jni.h>

#include "Mitsoko/ViperGod.hpp"
#include "Mitsoko/Dispatch.hpp"
#include "Mitsoko/Url/Request.hpp"

#include <iostream>
#include <algorithm>

using std::cout;
using std::endl;

extern "C"{
    
    static const char* cStringFromClientString(JNIEnv *env,jstring s);
    static jstring clientStringFromStdString(JNIEnv *env,const std::string&);
    
    jint JNI_OnLoad(JavaVM *vm, void *reserved){
        // Get JNI Env for all function calls
        JNIEnv* env;
        if (vm->GetEnv((void **) &env, JNI_VERSION_1_6) != JNI_OK) {
            cout<<"GetEnv failed."<<endl;
            return -1;
        }
        
        java::lang::JNI e(env);
        Mitsoko::Dispatch::initMainThreadHandler();
        std::cout.rdbuf(new androidbuf);
        return JNI_VERSION_1_6;
    }
    
    void Java_kz_outlawstudio_viper_NI_urlResponseReceived(JNIEnv *env,
                                                           jobject thiz,
                                                           jint requestId,
                                                           jobject response,
                                                           jbyteArray data,
                                                           jobject error)
    {
        java::lang::JNI e(env);
        Mitsoko::Url::Request::urlResponseReceived(requestId,
                                                   response,
                                                   data,
                                                   error);
    }
    
    void Java_kz_outlawstudio_viper_NI_urlResponseImageReceived(JNIEnv *env,
                                                                jobject thiz,
                                                                jint requestId,
                                                                jobject response,
                                                                jobject bitmap,
                                                                jobject error)
    {
        java::lang::JNI e(env);
        Mitsoko::Url::Request::urlResponseImageReceived(requestId,
                                                        response,
                                                        bitmap,
                                                        error);
    }
    
    void Java_kz_outlawstudio_viper_NI_setAppId(JNIEnv *env,jobject thiz,jstring appId){
        java::lang::JNI::appId = cStringFromClientString(env,appId);
        auto &appNamespace = java::lang::JNI::appNamespace;
        appNamespace = java::lang::JNI::appId;
        std::replace(appNamespace.begin(),
                     appNamespace.end(),
                     '.',
                     '/');
    }
    
    void Java_kz_outlawstudio_viper_NI_onActivityResult(JNIEnv *env,jobject thiz,jint viewId,jint requestCode,jint resultCode,jobject data){
        java::lang::JNI e(env);
        Mitsoko::God::shared.onActivityResult(viewId,requestCode,resultCode,data);
    }
    
    //  mitsoko dispatch..
    
    void Java_kz_outlawstudio_viper_NI_postBackgroundCode(JNIEnv *env,jobject thiz,jint callbackId,jboolean isMainThread){
        java::lang::JNI e(env);
        Mitsoko::Dispatch::postCallback(callbackId,isMainThread);
    }
    
    //  mitsoko view..
    
    void Java_kz_outlawstudio_viper_NI_sendMessageToView(JNIEnv *env,jobject thiz,jint viewId,jint messageCode,jstring arguments){
        java::lang::JNI e(env);
        Mitsoko::God::shared.sendMessageToView(viewId, int(messageCode),cStringFromClientString(env,arguments));
    }
    
    void Java_kz_outlawstudio_viper_NI_viewWillDisappearWithId(JNIEnv *env,jobject thiz,jint viewId){
        java::lang::JNI e(env);
        Mitsoko::God::shared.viewWillDisappear(viewId);
    }
    
    void Java_kz_outlawstudio_viper_NI_viewDidAppearWithId(JNIEnv *env,jobject thiz,jint viewId){
        java::lang::JNI e(env);
        Mitsoko::God::shared.viewDidAppear(viewId);
    }
    
    void Java_kz_outlawstudio_viper_NI_viewWillAppearWithId(JNIEnv *env,jobject thiz,jint viewId){
        java::lang::JNI e(env);
        Mitsoko::God::shared.viewWillAppear(viewId);
    }
    
    jint Java_kz_outlawstudio_viper_NI_viewCreated(JNIEnv *env,jobject thiz,jobject view,jstring className){
        java::lang::JNI e(env);
        auto v = env->NewGlobalRef(view);
        auto res = Mitsoko::God::shared.createView(cStringFromClientString(env,className), (const void*)v);
        cout<<"view created "<<res<<" "<<cStringFromClientString(env,className)<<endl;
        return res;
    }
    
    void Java_kz_outlawstudio_viper_NI_viewDestroyed(JNIEnv *env,jobject thiz,jint viewId){
        java::lang::JNI e(env);
        auto v = Mitsoko::God::shared.destroyView(viewId);
        env->DeleteGlobalRef((jobject)v);
    }
    
    //  ViperTableViewAdapter
    
    void Java_kz_outlawstudio_viper_ViperTableViewAdapter_onHeaderCreated(JNIEnv* env,jobject thiz,jint adapterId,jobject headerView,jint section){
        java::lang::JNI e(env);
        Mitsoko::TableListAdapter::headerCreated((const void*)(intptr_t)adapterId,
                                                 (const void*)headerView,
                                                 int(section));
    }
    
    jstring Java_kz_outlawstudio_viper_ViperTableViewAdapter_getHeaderLayoutName(JNIEnv* env,jobject thiz,jint adapterId,jint section){
        java::lang::JNI e(env);
        return clientStringFromStdString(env, Mitsoko::TableListAdapter::headerViewClassName((const void*)(intptr_t)adapterId,
                                                                                             int(section)));
    }
    
    jdouble Java_kz_outlawstudio_viper_ViperTableViewAdapter_getHeaderHeight(JNIEnv* env,jobject thiz,jint adapterId,jint section){
        java::lang::JNI e(env);
        return Mitsoko::TableListAdapter::headerHeight((const void*)(intptr_t)adapterId, int(section));
    }
    
    void Java_kz_outlawstudio_viper_ViperTableViewAdapter_didSelectRow(JNIEnv* env,jobject thiz,jobject listView,jint section,jint row){
        java::lang::JNI e(env);
        Mitsoko::TableListAdapter::didSelectRow(listView, section, row, env);
    }
    
    void Java_kz_outlawstudio_viper_ViperTableViewAdapter_onDisplayRow(JNIEnv* env,jobject thiz,jobject listView,jobject rowView,jint section,jint row){
        java::lang::JNI e(env);
        Mitsoko::TableListAdapter::willDisplayCell(listView, rowView, section, row, env);
    }
    
    void Java_kz_outlawstudio_viper_ViperTableViewAdapter_onRowCreated(JNIEnv* env,jobject thiz,jobject listView,jobject rowView,jint section,jint row){
        java::lang::JNI e(env);
        Mitsoko::TableListAdapter::cellCreated(listView, rowView, section, row, env);
    }
    
    jstring Java_kz_outlawstudio_viper_ViperTableViewAdapter_getRowLayoutName(JNIEnv* env,jobject thiz,jobject listView,jint section,jint row){
        java::lang::JNI e(env);
        return clientStringFromStdString(env, Mitsoko::TableListAdapter::cellClassName(listView, section, row, env));
    }
    
    jstring Java_kz_outlawstudio_viper_ViperTableViewAdapter_getRowId(JNIEnv* env,jobject thiz,jobject listView,jint section,jint row){
        java::lang::JNI e(env);
        return clientStringFromStdString(env, Mitsoko::TableListAdapter::rowId(listView, section, row, env));
    }
    
    jint Java_kz_outlawstudio_viper_ViperTableViewAdapter_getSectionsCount(JNIEnv* env,jobject thiz,jint adapterId){
        java::lang::JNI e(env);
        return Mitsoko::TableListAdapter::sectionsCount((const void*)(intptr_t)adapterId, env);
    }
    
    jint Java_kz_outlawstudio_viper_ViperTableViewAdapter_getRowsCount(JNIEnv* env,jobject thiz,jobject listView,jint section){
        java::lang::JNI e(env);
        return Mitsoko::TableListAdapter::rowsCount(listView, int(section), env);
    }
    
    void Java_kz_outlawstudio_viper_EventHandlers_00024AlertDialogClickListener_onClick(JNIEnv *env, jobject thiz, jint id, jobject dialogInterface, jint which){
        java::lang::JNI e(env);
        android::app::AlertDialog::Builder::alertDialogClickListener_onClick(id, dialogInterface, which);
    }
    
    void Java_kz_outlawstudio_viper_EventHandlers_00024CompoundButtonOnCheckedChangeListener_onCheckedChanged(JNIEnv *env, jobject thiz, jint id, jobject buttonView, jboolean isChecked){
        java::lang::JNI e(env);
        android::widget::CompoundButton::onCheckedChanged(id, buttonView, isChecked);
    }
    
    void Java_kz_outlawstudio_viper_EventHandlers_00024ViewOnClickListener_onClick(JNIEnv *env, jobject thiz, jint id, jobject v){
        java::lang::JNI e(env);
        android::view::View::onClick(id, v);
    }
    
    void Java_kz_outlawstudio_viper_EventHandlers_00024TextViewTextChangedListener_onTextChanged(JNIEnv *env, jobject thiz, jint id, jobject s, jint start, jint before, jint count){
        java::lang::JNI e(env);
        android::widget::TextView::TextWatcherEventHandler::textViewOnTextChanged(id, s, start, before, count);
    }
    
    void Java_kz_outlawstudio_viper_EventHandlers_00024TextViewTextChangedListener_beforeTextChanged(JNIEnv *env, jobject thiz, jint id, jobject s, jint start, jint before, jint count){
        java::lang::JNI e(env);
        android::widget::TextView::TextWatcherEventHandler::textViewBeforeTextChanged(id, s, start, before, count);
    }
    
    void Java_kz_outlawstudio_viper_EventHandlers_00024TextViewTextChangedListener_afterTextChanged(JNIEnv *env, jobject thiz, jint id, jobject ed){
        java::lang::JNI e(env);
        android::widget::TextView::TextWatcherEventHandler::textViewAfterTextChanged(id, ed);
    }
    
    static const char* cStringFromClientString(JNIEnv *env,jstring s){
        return env->GetStringUTFChars(s, JNI_FALSE);
    }
    
    static jstring clientStringFromStdString(JNIEnv *env,const std::string &str){
        jbyteArray array = env->NewByteArray(str.size());
        env->SetByteArrayRegion(array, 0, str.size(), (const jbyte*)str.c_str());
        jstring strEncode = env->NewStringUTF("UTF-8");
        jclass cls = env->FindClass("java/lang/String");
        jmethodID ctor = env->GetMethodID(cls, "<init>", "([BLjava/lang/String;)V");
        jstring object = (jstring) env->NewObject(cls, ctor, array, strEncode);
        return object;
    }
    
}
