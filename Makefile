TOOL_NAME = AarKayRunner 
INSTALL_NAME = aarkay
SHORT_NAME = rk
version = "0.0.13"

PREFIX = /usr/local
INSTALL_PATH = $(PREFIX)/bin/$(INSTALL_NAME)
PROD_INSTALL_PATH = $(PREFIX)/bin/$(SHORT_NAME)
DEV_INSTALL_PATH = $(PREFIX)/bin/$(SHORT_NAME)d
BUILD_PATH = .build/release/$(TOOL_NAME)

.PHONY: build dev install release uninstall

install: build
	set -e
	mkdir -p $(PREFIX)/bin
	cp -f $(BUILD_PATH) $(PROD_INSTALL_PATH)

dev: build
	set -e
	mkdir -p $(PREFIX)/bin
	rm -f $(DEV_INSTALL_PATH)
	cp -f $(BUILD_PATH) $(DEV_INSTALL_PATH)

release: build 
	set -e
	rm -f AarKay-v${version}.zip
	rm -rf bin && mkdir -p bin
	cp -f -f $(BUILD_PATH) bin/$(INSTALL_NAME)
	zip -r AarKay-v${version}.zip bin/$(INSTALL_NAME)
	shasum -a 256 -b AarKay-v${version}.zip | awk '{print $$1}'
	rm -rf bin 

build:
	set -e
	swift build --disable-sandbox -Xswiftc -static-stdlib -Xswiftc "-target" -Xswiftc "x86_64-apple-macosx10.12" -c release

uninstall:
	set -e
	rm -f $(PROD_INSTALL_PATH)
