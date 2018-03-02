TOOL_NAME = AarKayRunner 
INSTALL_NAME = aarkay
SHORT_NAME = rk

PREFIX = /usr/local
INSTALL_PATH = $(PREFIX)/bin/$(INSTALL_NAME)
BUILD_PATH = .build/release/$(TOOL_NAME)

.PHONY: install build uninstall

install: build
	set -e
	mkdir -p $(PREFIX)/bin
	cp -f $(BUILD_PATH) $(INSTALL_PATH)
	ln -s $(INSTALL_PATH) $(PREFIX)/bin/$(SHORT_NAME)

build:
	set -e
	swift build --disable-sandbox -c release -Xswiftc -static-stdlib -Xswiftc "-target" -Xswiftc "x86_64-apple-macosx10.12"

uninstall:
	set -e
	rm -f $(PREFIX)/bin/$(SHORT_NAME)
	rm -f $(INSTALL_PATH)
