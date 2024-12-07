#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 The TWRP Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

PRODUCT_COPY_FILES += \
	$(call find-copy-subdir-files,*,$(DEVICE_PATH)/recovery/root,recovery/root) \
	$(DEVICE_PATH)/prebuilt/dtb.img:dtb.img
# VNDK
PRODUCT_TARGET_VNDK_VERSION := current

# Virtual A/B support
PRODUCT_VIRTUAL_AB := true

PRODUCT_PACKAGES += \
   bootctrl.updateboot \
   update_engine_sideload \
   update_boot   \
   update_recovery_boot   \
   update_engine  \
   update_verifier

#PRODUCT_PACKAGES_DEBUG += \
#    bootctl \
#    update_engine_client \

#PRODUCT_HOST_PACKAGES += \
#    brillo_update_payload


# A/B support
AB_OTA_UPDATER := true

# A/B updater updatable partitions list. Keep in sync with the partition list
# with "_a" and "_b" variants in the device. Note that the vendor can add more
# more partitions to this list for the bootloader and radio.
AB_OTA_PARTITIONS += \
    product \
    system \
    vendor \
    boot \
    vendor_boot \
    dtbo \
    vbmeta \
    vbmeta_vendor \
    vbmeta_system \
    vendor_dlkm

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-service \
    android.hardware.boot@1.2-impl \
    android.hardware.boot@1.2-impl.recovery

# API
PRODUCT_SHIPPING_API_LEVEL := 31

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd
