# Copyright 2020 The Android Open Source Project

LOCAL_PATH := $(call my-dir)

### pixel_charger_res_images ###
ifneq ($(strip $(LOCAL_CHARGER_NO_UI)),true)
define _add-vendor-charger-image
include $$(CLEAR_VARS)
LOCAL_MODULE := pixel_charger_res_images_charger_$(notdir $(1))
LOCAL_MODULE_STEM := $(notdir $(1))
_img_modules += $$(LOCAL_MODULE)
LOCAL_SRC_FILES := $1
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $$(TARGET_OUT_VENDOR)/etc/res/images/charger
LOCAL_VENDOR_MODULE := true
include $$(BUILD_PREBUILT)
endef

_img_modules :=
_images :=
$(foreach _img, $(call find-subdir-subdir-files, "images/charger", "*.png"), \
  $(eval $(call _add-vendor-charger-image,$(_img))))

### pixel_charger_animation_file ###
define _add-vendor-charger-animation-file
include $$(CLEAR_VARS)
LOCAL_MODULE := pixel_charger_res_values_charger_$(notdir $(1))
LOCAL_MODULE_STEM := $(notdir $(1))
_anim_modules += $$(LOCAL_MODULE)
LOCAL_SRC_FILES := $1
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $$(TARGET_OUT_VENDOR)/etc/res/values/charger
LOCAL_VENDOR_MODULE := true
include $$(BUILD_PREBUILT)
endef

_anim_modules :=
$(foreach _txt, $(call find-subdir-subdir-files, "values/charger", "*.txt"), \
  $(eval $(call _add-vendor-charger-animation-file,$(_txt))))

include $(CLEAR_VARS)
LOCAL_MODULE := vendor_charger_res_images
LOCAL_MODULE_TAGS := optional
LOCAL_REQUIRED_MODULES := $(_img_modules) $(_anim_modules)
include $(BUILD_PHONY_PACKAGE)

_add-vendor-charger-image :=
_add-vendor-charger-animation-file :=
_img_modules :=
_anim_modules :=
endif # LOCAL_CHARGER_NO_UI
