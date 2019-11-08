PYTHON = python3

MILESTONE = p6
CODENAME = pipelined2

MIPS_AS = tools/mips-as.py
DEBUG_CONTROL = tools/debug-control.py
MARKDOWN_PDF = tools/markdown-pdf
PANDOC = pandoc

ASM_FILE = tests/cpu/single-cycle/test.asm
CODE_FILE = project/code.hex
DEBUG_H_FILE = src/include/debug/debug.h

DOC = doc

EXPORT = export
EXPORT_DOC = $(EXPORT)/doc

RELEASE_DIRNAME = release
RELEASE := `git log --pretty=format:%h -n 1`

VERILOG_FILES := $(shell find src -name '*.[vh]' | xargs)
VERILOG_FILES_FLATTENED := $(shell find src -name '*.[vh]' -exec 'basename' {} \; | xargs)

# Put the files in the order of content
_MD_FILES = header.md \
	datapath/npc.md \
	datapath/pc.md \
	datapath/im.md \
	datapath/rf.md \
	datapath/cmp.md \
	datapath/ext.md \
	datapath/alu.md \
	datapath/md.md \
	datapath/dm.md \
	datapath/pff.md \
	datapath/mux.md \
	datapath/$(CODENAME).md \
	control/instr-id.md \
	control/$(CODENAME).md \
	cpu/$(CODENAME).md \
	tips.md
MD_FILES = $(patsubst %, $(DOC)/%, $(_MD_FILES))

.PHONY: all doc code debug_on release

all: 
	@echo "TODO"

code:
	$(PYTHON) $(MIPS_AS) $(ASM_FILE) $(CODE_FILE)

doc:
	$(MARKDOWN_PDF) -o $(EXPORT_DOC)/$(CODENAME).pdf $(MD_FILES)

migrate-to-latex:
	$(PANDOC) --standalone -f gfm -t latex --standalone --top-level-division=section -o $(EXPORT_DOC)/$(CODENAME).tex $(MD_FILES)

debug-on:
	$(PYTHON) $(DEBUG_CONTROL) $(DEBUG_H_FILE) on

debug-off:
	$(PYTHON) $(DEBUG_CONTROL) $(DEBUG_H_FILE) off

release:
	# NOTE: hack
	mkdir $(RELEASE_DIRNAME)/tmp-release-zip
	cp $(VERILOG_FILES) $(RELEASE_DIRNAME)/tmp-release-zip
	cd $(RELEASE_DIRNAME)/tmp-release-zip; zip -r cpu-$(CODENAME)-$(RELEASE).zip *
	mv $(RELEASE_DIRNAME)/tmp-release-zip/cpu-$(CODENAME)-$(RELEASE).zip $(RELEASE_DIRNAME)	
	rm -rf $(RELEASE_DIRNAME)/tmp-release-zip

