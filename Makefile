PYTHON = python3

MILESTONE = p7
CODENAME = pipelined3

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
_MD_FILES = datapath/npc.md \
	datapath/pc.md \
	datapath/im.md \
	datapath/rf.md \
	datapath/cmp.md \
	datapath/ext.md \
	datapath/alu.md \
	datapath/md.md \
	datapath/dm.md \
	bridge/bridge.md \
	datapath/ac.md \
	datapath/cp0.md \
	datapath/pff.md \
	datapath/mux.md \
	datapath/$(CODENAME).md \
	control/instr-id.md \
	control/$(CODENAME).md \
	cpu/$(CODENAME).md \
	devices/timer.md \
	mips/$(CODENAME).md \
	tips.md
MD_FILES = $(patsubst %, $(DOC)/%, $(_MD_FILES))

.PHONY: all doc code debug_on

DOC = doc

EXPORT = export
EXPORT_DOC = $(EXPORT)/doc

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
	bridge/bridge.md \
	datapath/ac.md \
	datapath/cp0.md \
	datapath/pff.md \
	datapath/mux.md \
	datapath/$(CODENAME).md \
	control/instr-id.md \
	control/$(CODENAME).md \
	cpu/$(CODENAME).md \
	devices/timer.md \
	mips/$(CODENAME).md
MD_FILES = $(patsubst %, $(DOC)/%, $(_MD_FILES))

.PHONY: all doc code debug_on release

all: 
	@echo "TODO"

$(EXPORT_DOC):
	mkdir -p $<

doc: $(MD_FILES)
	$(MARKDOWN_PDF) -o $(EXPORT_DOC)/$(CODENAME).pdf $(MD_FILES)

code:
	$(PYTHON) $(MIPS_AS) $(ASM_FILE) $(CODE_FILE)

migrate-to-latex:
	$(PANDOC) --standalone -f gfm -t latex --standalone --top-level-division=section -o $(EXPORT_DOC)/$(CODENAME).tex $(MD_FILES)

debug-on:
	$(PYTHON) $(DEBUG_CONTROL) $(DEBUG_H_FILE) on

debug_off:
	$(PYTHON) $(DEBUG_CONTROL) $(DEBUG_H_FILE) off

release:
	mkdir $(RELEASE_DIRNAME)/tmp-release-zip
	cp $(VERILOG_FILES) $(RELEASE_DIRNAME)/tmp-release-zip
	zip -r $(RELEASE_DIRNAME)/cpu-$(CODENAME)-$(RELEASE).zip $(RELEASE_DIRNAME)/
	rm -rf $(RELEASE_DIRNAME)/tmp-release-zip

