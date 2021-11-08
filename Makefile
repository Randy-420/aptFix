include $(THEOS)/makefiles/common.mk

TOOL_NAME = aptFix
aptFix_FILES = $(wildcard *.m)
aptFix_FRAMEWORKS = UIKit
aptFix_CODESIGN_FLAGS = -Sent.plist
aptFix_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tool.mk
