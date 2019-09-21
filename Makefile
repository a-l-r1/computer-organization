PYTHON = python3

MIPS_AS = tools/mips-as.py
DEBUG_CONTROL = tools/debug-control.py
MARKDOWN_PDF = tools/markdown-pdf

ASM_FILE = tests/cpu/single-cycle/test.asm
CODE_FILE = project/code.hex
DEBUG_H_FILE = src/include/debug/debug.h

.PHONY: all code debug_on

all: 
	@echo "TODO"

code:
	$(PYTHON) $(MIPS_AS) $(ASM_FILE) $(CODE_FILE)

debug-on:
	$(PYTHON) $(DEBUG_CONTROL) $(DEBUG_H_FILE) on

debug-off:
	$(PYTHON) $(DEBUG_CONTROL) $(DEBUG_H_FILE) off

