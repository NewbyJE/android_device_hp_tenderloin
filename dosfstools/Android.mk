ifeq ($(BOARD_USES_CUSTOM_FSCK_MSDOS),true)

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SRC_FILES := src/boot.c src/check.c src/common.c \
	src/fat.c src/file.c src/io.c src/lfn.c src/fsck_msdos_main.c
LOCAL_CFLAGS := -O2 -W -Wall -D_USING_BIONIC_ -DUSE_ANDROID_RETVALS
LOCAL_CFLAGS += -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
LOCAL_MODULE := libfsck_msdos
LOCAL_MODULE_TAGS := optional
include $(BUILD_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_SRC_FILES := src/fsck_msdos.c
LOCAL_CFLAGS := -O2 -W -Wall -D_USING_BIONIC_ -DUSE_ANDROID_RETVALS
LOCAL_CFLAGS += -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
LOCAL_MODULE := fsck_msdos
LOCAL_MODULE_TAGS :=
LOCAL_STATIC_LIBRARIES := libfsck_msdos
LOCAL_SYSTEM_SHARED_LIBRARIES := libc
include $(BUILD_EXECUTABLE)

endif
