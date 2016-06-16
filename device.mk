#
# Copyright (C) 2014 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

LOCAL_PATH := device/samsung/ms013g
COMMON_PATH := device/samsung/msm8226-common

# call the proprietary setup
$(call inherit-product, vendor/samsung/ms013g/ms013g-vendor.mk)

# Charger
ADDITIONAL_DEFAULT_PROPERTIES += \
    ro.usb.id.charge=F006 \
    ro.usb.id.mtp=F003 \
    ro.usb.id.mtp_adb=9039 \
    ro.usb.id.ptp=904D \
    ro.usb.id.ptp_adb=904E \
    ro.usb.id.ums=F000 \
    ro.usb.id.ums_adb=9015 \
    ro.usb.vid=05c6

# Overlay
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay/frameworks/base/core/res/res/values/config.xml

# Radio
#PRODUCT_PACKAGES += \
#   libril_shim

# Ramdisk
PRODUCT_PACKAGES += \
    fstab.qcom \
    init.target.rc

# GPS
PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/gps/gps.conf:system/etc/gps.conf

# Default.prop overrides to get adb working at boot
ADDITIONAL_DEFAULT_PROPERTIES += \
    ro.secure=0 \
    ro.adb.secure=0
    
# Thermal
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/thermal-engine-8226.conf:system/etc/thermal-engine-8226.conf

# Wifi
PRODUCT_PACKAGES += \
    wpa_supplicant \
    hostapd_default.conf \
    p2p_supplicant_overlay.conf \
    wpa_supplicant.conf
    
# Boot animation
TARGET_SCREEN_HEIGHT := 1280
TARGET_SCREEN_WIDTH := 720

#adb at boot
ifneq ($(TARGET_BUILD_VARIANT),user)
ADDITIONAL_DEFAULT_PROPERTIES += \
    ro.secure=0 \
    ro.adb.secure=0
endif
    
# Doze
PRODUCT_PACKAGES += \
    SamsungDoze    

PRODUCT_PACKAGES += \
    p2p_supplicant_overlay.conf \
    wpa_supplicant_overlay.conf

PRODUCT_COPY_FILES += \
    kernel/samsung/ms013g/drivers/staging/prima/firmware_bin/WCNSS_cfg.dat:system/etc/firmware/wlan/prima/WCNSS_cfg.dat \
    $(LOCAL_PATH)/wifi/WCNSS_qcom_cfg.ini:system/etc/firmware/wlan/prima/WCNSS_qcom_cfg.ini \
    $(LOCAL_PATH)/wifi/WCNSS_qcom_wlan_nv.bin:system/etc/firmware/wlan/prima/WCNSS_qcom_wlan_nv.bin

# Inherit from msm8226-common
$(call inherit-product, device/samsung/msm8226-common/msm8226.mk)
