PYTHON = python3

MILESTONE = p4
CODENAME = single-cycle

MIPS_AS = tools/mips-as.py
DEBUG_CONTROL = tools/debug-control.py
MARKDOWN_PDF = tools/markdown-pdf

ASM_FILE = tests/cpu/single-cycle/test.asm
CODE_FILE = project/code.hex
DEBUG_H_FILE = src/include/debug/debug.h

DOC = doc

EXPORT = export
EXPORT_DOC = $(EXPORT)/doc

# Put the files in the order of content
_MD_FILES = header.md \
	datapath/npc.md \
	datapath/pc.md \
	datapath/im.md \
	datapath/rf.md \
	datapath/ext.md \
	datapath/alu.md \
	datapath/dm.md \
	datapath/mux.md \
	datapath/$(CODENAME).md \
	control/$(CODENAME).md \
	cpu/$(CODENAME).md
MD_FILES = $(patsubst %, $(DOC)/%, $(_MD_FILES))

.PHONY: all doc code debug_on

all: 
	@echo "TODO"

code:
	$(PYTHON) $(MIPS_AS) $(ASM_FILE) $(CODE_FILE)

doc:
	$(MARKDOWN_PDF) -o $(EXPORT_DOC)/$(CODENAME).pdf $(MD_FILES)

debug-on:
	$(PYTHON) $(DEBUG_CONTROL) $(DEBUG_H_FILE) on

debug-off:
	$(PYTHON) $(DEBUG_CONTROL) $(DEBUG_H_FILE) off

