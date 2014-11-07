# inherit from the proprietary version
-include vendor/hp/tenderloin/BoardConfigVendor.mk

TARGET_SPECIFIC_HEADER_PATH := device/hp/tenderloin/include

TARGET_NO_BOOTLOADER := true
TARGET_NO_KERNEL := false
TARGET_NO_RADIOIMAGE := true

TARGET_BOOTLOADER_BOARD_NAME := tenderloin
TARGET_BOARD_PLATFORM := msm8660
TARGET_BOARD_PLATFORM_GPU := qcom-adreno200
BOARD_USES_ADRENO_200 := true

TARGET_ARCH := arm
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_VARIANT := scorpion
TARGET_CPU_SMP := true

COMMON_GLOBAL_CFLAGS += -DREFRESH_RATE=59 -DQCOM_HARDWARE -DQCOM_BSP -DNEEDS_VECTORIMPL_SYMBOLS -DICS_CAMERA_BLOB

# Boot animation
TARGET_SCREEN_HEIGHT := 768
TARGET_SCREEN_WIDTH := 1024

# Wifi related defines
BOARD_WLAN_DEVICE := ath6kl
# ATH6KL uses NL80211 driver
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_ath6kl
# Station/client mode
WIFI_DRIVER_MODULE_NAME := "ath6kl"
WIFI_DRIVER_MODULE_PATH := "/system/lib/modules/ath6kl.ko"
# ATH6KL uses hostapd built from source
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_ath6kl
# FW path parameters (todo: temp, should be ignored)
WIFI_DRIVER_FW_PATH_STA := "sta"
WIFI_DRIVER_FW_PATH_AP  := "ap"
WIFI_DRIVER_FW_PATH_P2P := "p2p"
WIFI_DRIVER_FW_PATH_PARAM := ""

# Audio
BOARD_USES_LEGACY_ALSA_AUDIO := true
TARGET_QCOM_AUDIO_VARIANT := caf
COMMON_GLOBAL_CFLAGS += -DHTC_ACOUSTIC_AUDIO -DLEGACY_QCOM_VOICE

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_HCI := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/hp/tenderloin/bluetooth
BLUETOOTH_HCIATTACH_USING_PROPERTY = true

# Sierra support
BOARD_GPS_LIBRARIES := gps.$(TARGET_BOOTLOADER_BOARD_NAME)
USE_QEMU_GPS_HARDWARE := false
BOARD_USES_MBM_RIL := true
BOARD_USES_MBM_GPS := true
# RIL does not currently support CELL_INFO_LIST commands
RIL_NO_CELL_INFO_LIST := true

# Define egl.cfg location
BOARD_EGL_CFG := device/hp/tenderloin/configs/egl.cfg

# QCOM hardware
BOARD_USES_QCOM_HARDWARE := true
TARGET_USES_QCOM_BSP := true
TARGET_QCOM_MEDIA_VARIANT := caf
TARGET_QCOM_DISPLAY_VARIANT := caf

# QCOM HAL
USE_OPENGL_RENDERER := true
TARGET_USES_C2D_COMPOSITION := true
TARGET_USES_ION := true

# enable three buffers at all times
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3

# Use legacy MM heap behavior
TARGET_DISPLAY_INSECURE_MM_HEAP := true

# Use retire fence from MDP driver
TARGET_DISPLAY_USE_RETIRE_FENCE := true

# QCOM enhanced A/V
TARGET_ENABLE_QC_AV_ENHANCEMENTS := true

# camera
USE_CAMERA_STUB := false
TARGET_DISABLE_ARM_PIE := true
BOARD_CAMERA_USE_GETBUFFERINFO := true
BOARD_FIRST_CAMERA_FRONT_FACING := true
BOARD_CAMERA_USE_ENCODEDATA := true
BOARD_NEEDS_MEMORYHEAPPMEM := true

# kernel settings
BOARD_KERNEL_CMDLINE := console=ttyHSL0,115200,n8 androidboot.hardware=qcom
BOARD_KERNEL_BASE := 0x40200000
BOARD_PAGE_SIZE := 2048

# uboot
BOARD_KERNEL_IMAGE_NAME := uImage
BOARD_USES_UBOOT_MULTIIMAGE := true
BOARD_CUSTOM_BOOTIMG_MK := device/hp/tenderloin/releasetools/uboot-bootimg.mk
TARGET_PROVIDES_RELEASETOOLS := true
TARGET_RELEASETOOL_IMG_FROM_TARGET_SCRIPT := device/hp/tenderloin/releasetools/tenderloin_img_from_target_files
TARGET_RELEASETOOL_OTA_FROM_TARGET_SCRIPT := device/hp/tenderloin/releasetools/tenderloin_ota_from_target_files

# Define kernel config for inline building
TARGET_KERNEL_CONFIG := cyanogenmod_tenderloin_4g_defconfig
TARGET_KERNEL_SOURCE := kernel/hp/tenderloin
KERNEL_WIFI_MODULES:
	$(MAKE) -C external/backports-wireless defconfig-ath6kl
	export CROSS_COMPILE=$(ARM_EABI_TOOLCHAIN)/arm-eabi-; $(MAKE) -C external/backports-wireless KLIB=$(KERNEL_SRC) KLIB_BUILD=$(KERNEL_OUT) ARCH=$(TARGET_ARCH) $(ARM_CROSS_COMPILE)
	cp `find external/backports-wireless -name *.ko` $(KERNEL_MODULES_OUT)/
	arm-eabi-strip --strip-debug `find $(KERNEL_MODULES_OUT) -name *.ko`
	$(MAKE) -C external/backports-wireless clean

TARGET_KERNEL_MODULES := KERNEL_WIFI_MODULES

BOARD_CUSTOM_RECOVERY_KEYMAPPING := ../../device/hp/tenderloin/recovery/recovery_keys.c
ifeq ($(RECOVERY_VARIANT),)
BOARD_CUSTOM_GRAPHICS:= ../../../device/hp/tenderloin/recovery/graphics.c
endif
ifeq ($(RECOVERY_VARIANT),philz)
TARGET_RECOVERY_LCD_BACKLIGHT_PATH := "\"/sys/class/leds/lcd-backlight/brightness\""
endif
RECOVERY_FSTAB_VERSION=2
TARGET_RECOVERY_FSTAB = device/hp/tenderloin/recovery/recovery.fstab
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
BOARD_HAS_NO_MISC_PARTITION := true
BOARD_HAS_NO_SELECT_BUTTON := true

# recovery name
ifneq ($(RECOVERY_VARIANT),philz)
RECOVERY_NAME := CWM-based Recovery (jcsullins-datamedia-`date "+%Y%m%d"`)
endif

# partition sizes
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_BOOTIMAGE_PARTITION_SIZE := 16777216
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 16777216
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 838860800
BOARD_USERDATAIMAGE_PARTITION_SIZE := 20044333056
BOARD_FLASH_BLOCK_SIZE := 131072

# device specific settings menu
BOARD_HARDWARE_CLASS := device/hp/tenderloin/cmhw/

# Multiboot stuff
TARGET_RECOVERY_PRE_COMMAND := "/system/bin/rebootcmd"
TARGET_RECOVERY_NO_RAINBOWS := true
TARGET_RECOVERY_PRE_COMMAND_CLEAR_REASON := true

# use dosfsck from dosfstools
BOARD_USES_CUSTOM_FSCK_MSDOS := true

#
COMMON_GLOBAL_CFLAGS += -DQCOM_BSP_CAMERA_ABI_HACK=1

#### TWRP ####
# start old stuff
# TARGET_RECOVERY_INITRC := device/hp/tenderloin/recovery/init.twrp.rc
DEVICE_RESOLUTION := 1024x768
TW_CUSTOM_POWER_BUTTON := 107
TW_FLASH_FROM_STORAGE := true
# end of old stuff
# TARGET_RECOVERY_INITRC := device/hp/tenderloin/recovery/init.twrp.rc
RECOVERY_SDCARD_ON_DATA := true
# RECOVERY_GRAPHICS_USE_LINELENGTH := true
BOARD_HAS_NO_REAL_SDCARD := true
TW_INTERNAL_STORAGE_PATH := "/data/media"
TW_INTERNAL_STORAGE_MOUNT_POINT := "data"
TW_EXTERNAL_STORAGE_PATH := "/external_sd"
TW_EXTERNAL_STORAGE_MOUNT_POINT := "/external_sd"
TW_CUSTOM_POWER_BUTTON := 102
TW_NO_REBOOT_BOOTLOADER := true
TW_NO_REBOOT_RECOVERY := true
# TW_NO_USB_STORAGE := true
# RECOVERY_TOUCHSCREEN_SWAP_XY := true
# RECOVERY_TOUCHSCREEN_FLIP_X := true
# RECOVERY_TOUCHSCREEN_FLIP_Y := true
# TW_DEFAULT_EXTERNAL_STORAGE := true
# BOARD_HAS_FLIPPED_SCREEN := true
# TWRP_EVENT_LOGGING := true
BOARD_UMS_LUNFILE := /sys/devices/platform/msm_hsusb/gadget/lun%d/file

TW_NO_SCREEN_BLANK := true
TW_BRIGHTNESS_PATH  := /sys/class/leds/lcd-backlight/brightness
TW_MAX_BRIGHTNESS := 254

# TWRP crypto
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_JB_CRYPTO := true
TW_CRYPTO_FS_TYPE := ext4
TW_CRYPTO_REAL_BLKDEV := /dev/store/cm-data
TW_CRYPTO_MNT_POINT := /data
TW_CRYPTO_FS_OPTIONS := noatime,nosuid,nodev,barrier=0,noauto_da_alloc
TW_CRYPTO_FS_FLAGS := wait,check,encryptable=/dev/block/mmcblk0p10
TW_CRYPTO_KEY_LOC := /dev/block/mmcblk0p10

