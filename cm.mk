# Release name
PRODUCT_RELEASE_NAME := TouchPad

# Inherit some common CyanogenMod stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Inherit GSM common stuff
$(call inherit-product, vendor/cm/config/gsm.mk)

# Inherit device configuration
$(call inherit-product, device/hp/tenderloin/full_tenderloin.mk)

#
# Setup device specific product configuration.
#
PRODUCT_NAME := cm_tenderloin
PRODUCT_BRAND := HP
PRODUCT_DEVICE := tenderloin
PRODUCT_MODEL := TouchPad
PRODUCT_MANUFACTURER := HP

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=touchpad \
    BUILD_FINGERPRINT="hp/hp_tenderloin/tenderloin:4.4.4/KTU84P/1227136:user/release-keys" \
    PRIVATE_BUILD_DESC="tenderloin-user 4.4.4 KTU84P 1227136 release-keys" \
    BUILD_NUMBER=228551

# Boot animation
TARGET_SCREEN_HEIGHT := 768
TARGET_SCREEN_WIDTH := 1024

TARGET_UNOFFICIAL_BUILD_ID := 3.0_kernel
