ELM_OUTPUT = elm.js
STATIC =
BROWSER_TARGET = example.html

SOURCE_DIR = src
BUILD_DIR = build

###

ELM_SOURCE = $(SOURCE_DIR)/$(ELM_MAIN).elm
ELM_BUILD = $(BUILD_DIR)/$(ELM_OUTPUT)
STATIC_SOURCES = $(STATIC:%=$(SOURCE_DIR)/%)

###

.PHONY: all open clean clean-build clean-all static elm new

new: clean-build all

$(ELM_BUILD): elm

simple:
	elm make --yes --output $(ELM_BUILD) $(SOURCE_DIR)/SimpleExample.elm

mouseOver:
	elm make --yes --output $(ELM_BUILD) $(SOURCE_DIR)/MouseOverExample.elm

$(BUILD_DIR):
	mkdir $(BUILD_DIR)

clean:
	rm -rf elm-stuff

clean-build:
	rm -rf $(BUILD_DIR)
	rm -rf elm-stuff/build-artifacts

clean-all: clean-build clean
