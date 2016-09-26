THEOS_DEVICE_IP = 192.168.1.3
ARCHS = armv7 arm64

DEBUG=0
FINALPACKAGE=1

GO_EASY_ON_ME=1
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = CancelQueue
CancelQueue_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 Cydia"
