LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
LOCAL_MODULE := camera.tenderloin
LOCAL_MODULE_TAGS := optional
LOCAL_PRELINK_MODULE := false

LOCAL_SRC_FILES := QualcommCameraHardware.cpp
LOCAL_SRC_FILES += cameraHAL.cpp

LOCAL_CFLAGS := -DDLOPEN_LIBMMCAMERA=1 -DHW_ENCODE
LOCAL_CFLAGS += -DNUM_PREVIEW_BUFFERS=4 -D_ANDROID_
LOCAL_CFLAGS += -DUSE_NEON_CONVERSION

ifeq ($(strip $(TARGET_USES_ION)),true)
LOCAL_CFLAGS += -DUSE_ION
endif

ifeq ($(BOARD_DEBUG_MEMLEAKS),true)
    LOCAL_CFLAGS += -DHEAPTRACKER
endif

LOCAL_C_INCLUDES := $(TOP)/frameworks/base/include
LOCAL_C_INCLUDES += $(TARGET_OUT_HEADERS)/mm-camera
LOCAL_C_INCLUDES += $(TARGET_OUT_HEADERS)/mm-still/jpeg
LOCAL_C_INCLUDES += $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include
LOCAL_C_INCLUDES += $(TOP)/hardware/qcom/display-legacy/libgralloc \
                    $(TOP)/hardware/qcom/display-legacy/libgenlock

LOCAL_SHARED_LIBRARIES := libutils libui libcamera_client liblog libcutils
LOCAL_SHARED_LIBRARIES += libgenlock libbinder libdl libhardware

ifeq ($(BOARD_DEBUG_MEMLEAKS),true)
    LOCAL_SHARED_LIBRARIES += libheaptracker
endif

include $(BUILD_SHARED_LIBRARY)
