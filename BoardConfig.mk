#
# Copyright (C) 2022 ArrowOS
# Copyright (C) 2023 LineageOS
#
# SPDX-License-Identifier: Apache-2.0
#

# Helpful vars
DEVICE_PATH := device/xiaomi/viva
KERNEL_PATH := device/xiaomi/viva-kernel
CONFIGS_PATH := $(DEVICE_PATH)/configs

# Broken build rules
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_ENFORCE_SYSPROP_OWNER := true
BUILD_BROKEN_VENDOR_PROPERTY_NAMESPACE := true

# Architecture flags
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a-dotprod
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := cortex-a76
TARGET_CPU_VARIANT_RUNTIME := cortex-a76

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-2a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a55
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a55

# OTA Asserts
TARGET_OTA_ASSERT_DEVICE := viva,vida

# Platform / Bootloader
TARGET_BOOTLOADER_BOARD_NAME := viva
TARGET_NO_BOOTLOADER := true
TARGET_BOARD_PLATFORM := mt6781
BOARD_VENDOR := xiaomi
BOARD_HAS_MTK_HARDWARE := true

# Prebuilts
BOARD_PREBUILT_DTBOIMAGE := $(KERNEL_PATH)/dtbo.img
TARGET_PREBUILT_KERNEL := $(KERNEL_PATH)/Image.gz
TARGET_PREBUILT_DTB := $(KERNEL_PATH)/dtb.img

# Kernel / Boot Image
BOARD_KERNEL_CMDLINE := \
    bootopt=64S3,32N2,64N2 \
    video=HDMI-A-1:1280x800@60

BOARD_BOOT_HEADER_VERSION := 2

BOARD_KERNEL_BASE := 0x40078000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_KERNEL_SECOND_OFFSET := 0xbff88000
BOARD_RAMDISK_OFFSET := 0x07c08000
BOARD_KERNEL_TAGS_OFFSET := 0x0bc08000
BOARD_DTB_OFFSET := 0x0bc08000

BOARD_MKBOOTIMG_ARGS := --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --kernel_offset $(BOARD_KERNEL_OFFSET)
BOARD_MKBOOTIMG_ARGS += --second_offset $(BOARD_KERNEL_SECOND_OFFSET)
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)
BOARD_MKBOOTIMG_ARGS += --base $(BOARD_KERNEL_BASE)
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_KERNEL_PAGESIZE)

# BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_KERNEL_SEPARATED_DTBO := true

TARGET_FORCE_PREBUILT_KERNEL := true
TARGET_KERNEL_CONFIG := nothing_important_here
TARGET_KERNEL_SOURCE := kernel/xiaomi/viva-headers

BOARD_VENDOR_KERNEL_MODULES := \
    $(foreach module,$(wildcard $(KERNEL_PATH)/modules/*.ko), \
        $(module))

TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_PRODUCT := product

# Partitions
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_BOOTIMAGE_PARTITION_SIZE := 134217728
BOARD_DTBOIMG_PARTITION_SIZE := 8388608

# Dynamic partitions
BOARD_SUPER_PARTITION_SIZE := 9126805504
BOARD_SUPER_PARTITION_GROUPS := mtk_dynamic_partitions
BOARD_MTK_DYNAMIC_PARTITIONS_PARTITION_LIST := system vendor product
BOARD_MTK_DYNAMIC_PARTITIONS_SIZE := 9122611200

# Partition types
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs

# Reserved sizes
BOARD_EXT4_SHARE_DUP_BLOCKS := false
BOARD_SYSTEMIMAGE_PARTITION_RESERVED_SIZE := 2147483648
BOARD_PRODUCTIMAGE_PARTITION_RESERVED_SIZE := 2147483648
BOARD_VENDORIMAGE_PARTITION_RESERVED_SIZE := 67108864

# Data
BOARD_USES_METADATA_PARTITION := true
TARGET_USERIMAGES_USE_F2FS := true

# Recovery
BOARD_USES_RECOVERY_AS_BOOT := true
TARGET_SCREEN_DENSITY := 440
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/fstab.mt6781

# APEX
OVERRIDE_TARGET_FLATTEN_APEX := true

# VINTF
DEVICE_MANIFEST_FILE := $(CONFIGS_PATH)/vintf/manifest.xml
PRODUCT_COMPATIBILITY_MATRIX_FILE := $(CONFIGS_PATH)/vintf/compatibility_matrix.xml
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE := $(CONFIGS_PATH)/vintf/framework_compatibility_matrix.xml

# Properties
TARGET_SYSTEM_PROP += $(CONFIGS_PATH)/props/system.prop
TARGET_SYSTEM_EXT_PROP += $(CONFIGS_PATH)/props/system_ext.prop
TARGET_VENDOR_PROP += $(CONFIGS_PATH)/props/vendor.prop

# Vendor Security Patch level
VENDOR_SECURITY_PATCH := 2022-02-05

# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_ALGORITHM := SHA256_RSA2048
BOARD_AVB_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem

# Enable chain partition for system.
BOARD_AVB_VBMETA_SYSTEM := system product
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := 0
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 2

# Enable chain partition for vendor.
BOARD_AVB_VBMETA_VENDOR := vendor
BOARD_AVB_VBMETA_VENDOR_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_VENDOR_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_VENDOR_ROLLBACK_INDEX := 0
BOARD_AVB_VBMETA_VENDOR_ROLLBACK_INDEX_LOCATION := 4

# Enable chained vbmeta for boot images
BOARD_AVB_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_BOOT_ALGORITHM := SHA256_RSA2048
BOARD_AVB_BOOT_ROLLBACK_INDEX := 0
BOARD_AVB_BOOT_ROLLBACK_INDEX_LOCATION := 3

# Vendor RIL
ENABLE_VENDOR_RIL_SERVICE := true

# Power HAL Ext
TARGET_POWERHAL_MODE_EXT := $(DEVICE_PATH)/power/power-ext.cpp

# SELinux
include device/mediatek/sepolicy_vndr/SEPolicy.mk
BOARD_VENDOR_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/vendor

# VNDK
BOARD_VNDK_VERSION := current

include vendor/xiaomi/viva/BoardConfigVendor.mk

# Wifi
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_HOSTAPD_DRIVER := NL80211
WIFI_HIDL_FEATURE_DUAL_INTERFACE := true

## Copy wpa_supplicant init rc from external/wpa_supplicant
WIFI_HIDL_UNIFIED_SUPPLICANT_SERVICE_RC_ENTRY := true
