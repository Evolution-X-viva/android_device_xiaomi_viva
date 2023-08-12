#
# Copyright (C) 2022 ArrowOS
# Copyright (C) 2023 LineageOS
#
# SPDX-License-Identifier: Apache-2.0
#

PRODUCT_MAKEFILES := \
    $(LOCAL_DIR)/miku_viva.mk

COMMON_LUNCH_CHOICES := \
    $(foreach FLAVOR, user userdebug eng, miku_viva-$(FLAVOR))
