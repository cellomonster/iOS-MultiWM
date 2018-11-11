export SDKVERSION = 8.1
export THEOS_DEVICE_IP = 192.168.0.11

include $(THEOS)/makefiles/common.mk

Window_FRAMEWORKS = UIKit CoreGraphics
Window_PRIVATE_FRAMEWORKS = AppSupport

TWEAK_NAME = Window
Window_FILES = Tweak.xm ActivatorAction.m CDTContextHostProvider.mm UIView+draggable.m AFDApplicationWindow.m
Window_LIBRARIES = activator rocketbootstrap

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
