TOOL_NAME = AarKayRunner 
INSTALL_NAME = aarkay
SHORT_NAME = rk

PREFIX = /usr/local
INSTALL_PATH = $(PREFIX)/bin/$(INSTALL_NAME)
DEV_INSTALL_PATH = $(PREFIX)/bin/$(SHORT_NAME)d
BUILD_PATH = .build/debug/$(TOOL_NAME)

.PHONY: build dev install uninstall

install: build
	set -e
	mkdir -p $(PREFIX)/bin
	cp -f $(BUILD_PATH) $(INSTALL_PATH)
	ln -s $(INSTALL_PATH) $(PREFIX)/bin/$(SHORT_NAME)

dev: build
	set -e
	mkdir -p $(PREFIX)/bin
	rm -f $(DEV_INSTALL_PATH)
	cp -f $(BUILD_PATH) $(DEV_INSTALL_PATH)

build:
	set -e
	swift build --disable-sandbox -Xswiftc -static-stdlib -Xswiftc "-target" -Xswiftc "x86_64-apple-macosx10.12"

uninstall:
	set -e
	rm -f $(PREFIX)/bin/$(SHORT_NAME)
	rm -f $(INSTALL_PATH)
