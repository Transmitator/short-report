SRC_DIR = src
OUT_DIR = build
$(shell mkdir $(OUT_DIR) 2>/dev/null)

MAINFILE = main

COMPILER = latexmk
COMPILER_FLAGS := -output-directory=$(OUT_DIR) -pdf
BIBTEX = bibtex

PLATFORM := $(shell uname -s)
ifeq ($(PLATFORM), Linux)
	OPEN = xdg-open
else
	OPEN = open
endif

.PHONY: all
all: $(MAINFILE).pdf ## Compile the LaTeX project. This will build a PDF document.

$(MAINFILE).pdf:
	$(COMPILER) $(COMPILER_FLAGS) $(SRC_DIR)/$(MAINFILE)

.PHONY: show
show: ## Open the resulting PDF
	$(OPEN) ./$(OUT_DIR)/$(MAINFILE).pdf

.PHONY: clean
clean: ## Remove LaTeX build files
	-rm -f $(addprefix $(OUT_DIR)/*., aux log toc bbl blg out fls fdb_latexmk ps dvi bcf xml)

.PHONY: cleanall
cleanall: ## Remove the entire output (build) directory
	-rm -rf $(OUT_DIR)

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
