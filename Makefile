export THEOS_DEVICE_IP = 172.20.10.6

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Window
Window_FILES = Tweak.xm ActivatorAction.m CDTContextHostProvider.mm UIView+draggable.m AFDApplicationWindow.m
Window_LIBRARIES = activator rocketbootstrap 
Window_PRIVATE_FRAMEWORKS = AppSupport

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
