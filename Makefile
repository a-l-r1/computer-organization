PYTHON = python3

MILESTONE = p4
CODENAME = single-cycle

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
	datapath/ext.md \
	datapath/alu.md \
	datapath/dm.md \
	datapath/mux.md \
	datapath/$(CODENAME).md \
	control/$(CODENAME).md \
	cpu/$(CODENAME).md \
	tips.md
MD_FILES = $(patsubst %, $(DOC)/%, $(_MD_FILES))

.PHONY: all doc code debug_on release migrate-to-latex

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

release:
	mkdir $(RELEASE_DIRNAME)/tmp-release-zip
	cp $(VERILOG_FILES) $(RELEASE_DIRNAME)/tmp-release-zip
	zip -r $(RELEASE_DIRNAME)/cpu-$(CODENAME)-$(RELEASE).zip $(RELEASE_DIRNAME)/
	rm -rf $(RELEASE_DIRNAME)/tmp-release-zip

migrate-to-latex:
	$(PANDOC) -f gfm -t latex --top-level-division=section -o $(EXPORT_DOC)/$(CODENAME).tex $(MD_FILES)

	# processing hack by sed(1)
	# elevate section labels: subsection -> section, subsubsection -> subsection
	sed -i 's/\\subsection{/\\section{/g' $(EXPORT_DOC)/$(CODENAME).tex
	sed -i 's/\\subsubsection{/\\subsection{/g' $(EXPORT_DOC)/$(CODENAME).tex

	# add vertical lines to longtables
	sed -i 's/^\\begin{longtable}\[\]{@{}lll@{}}$$/\\begin{longtable}\[\]{@{}\|l\|l\|l\|@{}}/g' $(EXPORT_DOC)/$(CODENAME).tex
	sed -i 's/^\\begin{longtable}\[\]{@{}llll@{}}$$/\\begin{longtable}\[\]{@{}\|l\|l\|l\|l\|@{}}/g' $(EXPORT_DOC)/$(CODENAME).tex
	sed -i 's/^\\begin{longtable}\[\]{@{}lllll@{}}$$/\\begin{longtable}\[\]{@{}\|l\|l\|l\|l\|l\|@{}}/g' $(EXPORT_DOC)/$(CODENAME).tex
	sed -i 's/^\\begin{longtable}\[\]{@{}llllll@{}}$$/\\begin{longtable}\[\]{@{}\|l\|l\|l\|l\|l\|l\|@{}}/g' $(EXPORT_DOC)/$(CODENAME).tex

	# \toprule -> \hline: for complete borders
	sed -i 's/^\\toprule$$/\\hline/g' $(EXPORT_DOC)/$(CODENAME).tex

	# \midrule, \bottomrule -> nothing: remove extra borders
	sed -i 's/^\\midrule$$//g' $(EXPORT_DOC)/$(CODENAME).tex
	sed -i 's/^\\bottomrule$$//g' $(EXPORT_DOC)/$(CODENAME).tex

	# \tabularnewline -> \tabularnewline\hline: for complete borders
	sed -i 's/\\tabularnewline$$/\\tabularnewline\\hline/g' $(EXPORT_DOC)/$(CODENAME).tex

	# \endhead -> \endhead\hiderowcolors: for canonical table coloring scheme
	sed -i 's/^\\endhead$$/\\endhead\\hiderowcolors/g' $(EXPORT_DOC)/$(CODENAME).tex

	# replace common headers to the canonical style
	sed -i 's/^端口 \& 类型 \& 位宽 \& 功能\\tabularnewline\\hline$$/\\headingcellfirst{端口} \& \\headingcellmiddle{类型} \& \\headingcellmiddle{位宽} \& \\headingcelllast{功能}\\tabularnewline\\hline/g' $(EXPORT_DOC)/$(CODENAME).tex
	sed -i 's/^类别 \& 定义 \& 值 \& 意义\\tabularnewline\\hline$$/\\headingcellfirst{类别} \& \\headingcellmiddle{定义} \& \\headingcellmiddle{值} \& \\headingcelllast{意义}\\tabularnewline\\hline/g' $(EXPORT_DOC)/$(CODENAME).tex

	# ...and prompts that some headings have to be manually fixed
	@echo 'NOTE: some headings have to be manually fixed'

	cat doc/util/header.tex $(EXPORT_DOC)/$(CODENAME).tex doc/util/footer.tex > $(EXPORT_DOC)/$(CODENAME)-standalone.tex

