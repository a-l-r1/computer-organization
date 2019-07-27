PYTHON = python3
MIPS_AS = tools/mips-as.py
ASM_FILE = tests/cpu/single-cycle/test.asm
CODE_FILE = project/code.hex

.PHONY: all code

all: 
	@echo "TODO"

code:
	$(PYTHON) $(MIPS_AS) $(ASM_FILE) $(CODE_FILE)

