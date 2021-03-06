LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)
#
## TP Application
#
#
#LOCAL_C_INCLUDES:= uim.h

LOCAL_ADDITIONAL_DEPENDENCIES := $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr
LOCAL_SRC_FILES:= \
	ts_srv.c \
	digitizer.c
LOCAL_CFLAGS:= -g -c -W -Wall -O2 -mtune=cortex-a9 -mfpu=neon -mfloat-abi=softfp -funsafe-math-optimizations -D_POSIX_SOURCE
LOCAL_C_INCLUDES:= $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include
LOCAL_CFLAGS += -DTPTS_ALOG
LOCAL_MODULE:=ts_srv
LOCAL_MODULE_TAGS:= eng
LOCAL_SHARED_LIBRARIES := liblog
LOCAL_LDLIBS := -L$(SYSROOT)/usr/lib -llog
include $(BUILD_EXECUTABLE)


## static ts_srv for touch-based recoveries
include $(CLEAR_VARS)
LOCAL_ADDITIONAL_DEPENDENCIES := $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr
LOCAL_SRC_FILES:= \
	ts_srv.c \
	digitizer.c
LOCAL_CFLAGS:= -g -c -W -Wall -O2 -mtune=cortex-a9 -mfpu=neon -mfloat-abi=softfp -funsafe-math-optimizations -D_POSIX_SOURCE
LOCAL_C_INCLUDES:= $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include
LOCAL_MODULE := ts_srv_static
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/sbin
LOCAL_STATIC_LIBRARIES := libc libstdc++ libm
LOCAL_FORCE_STATIC_EXECUTABLE := true
include $(BUILD_EXECUTABLE)


## ts_srv_set application for changing modes of touchscreen operation
## used to set finger or stylus mode
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
	ts_srv_set.c
LOCAL_CFLAGS:= -g -c -W -Wall -O2 -mtune=cortex-a9 -mfpu=neon -mfloat-abi=softfp -funsafe-math-optimizations -D_POSIX_SOURCE
LOCAL_C_INCLUDES:= $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include
LOCAL_CFLAGS += -DTPTS_ALOG
LOCAL_MODULE:=ts_srv_set
LOCAL_MODULE_TAGS:= eng
LOCAL_SHARED_LIBRARIES := liblog
LOCAL_LDLIBS := -L$(SYSROOT)/usr/lib -llog
include $(BUILD_EXECUTABLE)
