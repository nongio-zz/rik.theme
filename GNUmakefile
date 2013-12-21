include $(GNUSTEP_MAKEFILES)/common.make

PACKAGE_NAME = Rick
BUNDLE_NAME = Rik
BUNDLE_EXTENSION = .theme
VERSION = 1

Rik_INSTALL_DIR=$(GNUSTEP_LIBRARY)/Themes
Rik_PRINCIPAL_CLASS = Rik

Rik_OBJC_FILES = \
		Rik.m\
		Rik+Drawings.m\
		Rik+Button.m\
		Rik+WindowDecoration.m\
		Rik+Menu.m\
		Rik+Slider.m\
		Rik+ProgressIndicator.m\
		Rik+Scroller.m\
		GSStandardDecorationView+Rik.m\
		NSSlider+Rik.m\
		NSWindow+Rik.m\
		RikWindowButton.m\
		RikWindowButtonCell.m\
		RikScrollerKnobSlotCell.m

ADDITIONAL_TOOL_LIBS = -lopal
$(BUNDLE_NAME)_RESOURCE_FILES = \
	./Resources/ThemeImages\
	./Resources/*.clr
include $(GNUSTEP_MAKEFILES)/bundle.make

-include GNUmakefile.postamble

