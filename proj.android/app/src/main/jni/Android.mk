LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

# include $(LOCAL_PATH)/sqlite/Android.mk

# LOCAL_PATH := $(call my-dir)
# include $(CLEAR_VARS)

# LOCAL_STATIC_LIBRARIES := sqlite  
LOCAL_MODULE    := NI
LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../../../../Core/ \
					$(LOCAL_PATH)/../../../../../Core/libs/ 
# LOCAL_SRC_FILES := NI.cpp
FILE_LIST := $(wildcard $(LOCAL_PATH)/*.cpp)
FILE_LIST += $(wildcard $(LOCAL_PATH)/../../../../../Core/**/*.cpp)
FILE_LIST += $(wildcard $(LOCAL_PATH)/../../../../../Core/**/**/*.cpp)
FILE_LIST += $(wildcard $(LOCAL_PATH)/../../../../../Core/**/**/**/*.cpp)
FILE_LIST += $(wildcard $(LOCAL_PATH)/../../../../../Core/**/**/**/**/*.cpp)
FILE_LIST += $(wildcard $(LOCAL_PATH)/../../../../../Core/**/**/**/**/**/*.cpp)
FILE_LIST += $(wildcard $(LOCAL_PATH)/../../../../../Core/**/**/**/**/**/**/*.cpp)
FILE_LIST += $(wildcard $(LOCAL_PATH)/**/**/*.cpp)
LOCAL_SRC_FILES := $(FILE_LIST:$(LOCAL_PATH)/%=%)

LOCAL_LDLIBS := -L$(SYSROOT)/usr/lib
LOCAL_LDLIBS += -llog -ldl -landroid

# LOCAL_SHARED_LIBRARIES += sqlite

include $(BUILD_SHARED_LIBRARY)

$(call import-add-path, $(LOCAL_PATH))
# $(call import-module,sqlite)

