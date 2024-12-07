#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 The TWRP Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_VARIANT := generic
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := exdroid
TARGET_NO_BOOTLOADER := true

# Platform
TARGET_BOARD_PLATFORM := $(PRODUCT_PLATFORM)

# Kernel
TARGET_KERNEL_ARCH := $(TARGET_ARCH)
BOARD_KERNEL_IMAGE_NAME := bImage
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/$(BOARD_KERNEL_IMAGE_NAME)
BOARD_INCLUDE_DTB_IN_BOOTIMG := true

BOARD_KERNEL_CMDLINE := \
    firmware_class.path=/vendor/etc/firmware \
    selinux=1 \
    androidboot.dtbo_idx=0,1,2 \
    androidboot.selinux=permissive \
    androidboot.init_fatal_reboot_target=recovery

BOARD_KERNEL_PAGESIZE := 4096
BOARD_MKBOOTIMG_ARGS := \
    --board arm64 \
    --dtb $(DEVICE_PATH)/prebuilt/dtb.img \
    --dtb_offset 0x03300000 \
    --kernel_offset 0x80000 \
    --ramdisk_offset 0x03400000 \
    --header_version 3

BOARD_ROOT_EXTRA_FOLDERS := Reserved0

# Android Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_BOOT_ALGORITHM := SHA256_RSA4096
BOARD_AVB_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_BOOT_ROLLBACK_INDEX := 1
BOARD_AVB_BOOT_ROLLBACK_INDEX_LOCATION := 1

# Partitions
BOARD_FLASH_BLOCK_SIZE := 4096
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864

TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

BOARD_RAMDISK_USE_LZ4 := true

# Dynamic partitions
BOARD_SUPER_PARTITION_SIZE := 3221225472
BOARD_SUPER_PARTITION_GROUPS := aw_dynamic_partitions
BOARD_AW_DYNAMIC_PARTITIONS_SIZE := 3212836864
BOARD_AW_DYNAMIC_PARTITIONS_PARTITION_LIST := system vendor product vendor_dlkm

BOARD_PARTITION_LIST := $(call to-upper, $(BOARD_GROUP_BASIC_PARTITION_LIST))
$(foreach p, $(BOARD_PARTITION_LIST), $(eval BOARD_$(p)IMAGE_FILE_SYSTEM_TYPE := ext4))
$(foreach p, $(BOARD_PARTITION_LIST), $(eval TARGET_COPY_OUT_$(p) := $(call to-lower, $(p))))

# Workaround for error copying vendor files to recovery ramdisk
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor

# Encryption
PLATFORM_VERSION := 99.87.36
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)
PLATFORM_SECURITY_PATCH := 2099-12-31
BOOT_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)
VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)

# Recovery
BOARD_USES_RECOVERY_AS_BOOT := true
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery.fstab
RECOVERY_SDCARD_ON_DATA := true

# TWRP specific build flags
TW_THEME := portrait_hdpi
TW_BACKUP_EXCLUSIONS := /data/fonts/files
TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true
