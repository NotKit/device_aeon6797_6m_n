# Use the non-open-source part, if present
-include vendor/eastaeon/aeon6797_6m_n/BoardConfigVendor.mk

# Use the 6797 common part
include device/mediatek/mt6797/BoardConfig.mk

#Config partition size
-include $(MTK_PTGEN_OUT)/partition_size.mk
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 4096

include device/eastaeon/$(MTK_TARGET_PROJECT)/ProjectConfig.mk

MTK_INTERNAL_CDEFS := $(foreach t,$(AUTO_ADD_GLOBAL_DEFINE_BY_NAME),$(if $(filter-out no NO none NONE false FALSE,$($(t))),-D$(t)))
MTK_INTERNAL_CDEFS += $(foreach t,$(AUTO_ADD_GLOBAL_DEFINE_BY_VALUE),$(if $(filter-out no NO none NONE false FALSE,$($(t))),$(foreach v,$(shell echo $($(t)) | tr '[a-z]' '[A-Z]'),-D$(v))))
MTK_INTERNAL_CDEFS += $(foreach t,$(AUTO_ADD_GLOBAL_DEFINE_BY_NAME_VALUE),$(if $(filter-out no NO none NONE false FALSE,$($(t))),-D$(t)=\"$(strip $($(t)))\"))

MTK_GLOBAL_CFLAGS += $(MTK_INTERNAL_CDEFS)

ifneq ($(MTK_K64_SUPPORT), yes)
BOARD_KERNEL_CMDLINE = bootopt=64S3,32S1,32S1
else
BOARD_KERNEL_CMDLINE = bootopt=64S3,32N2,64N2
endif

MTK_RECOVERY_MEDIUM_RES := yes

BOARD_QTI_CAMERA_32BIT_ONLY := true
