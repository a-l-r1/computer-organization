#!/bin/bash
echo "[*] generating coe file for $1"

tools/mips-as-p8-ng-mmu.sh $1

COE_FILENAME=$(basename $1 | sed 's/\.asm$/\.coe/g')
COE_PATH=project/coe/${COE_FILENAME}

tools/lib/gen-coe-p8-ng-mmu/gen-coe-p8-ng-mmu.py project/code.txt project/code_handler.txt project/code_prog0.txt project/code_prog1.txt ${COE_PATH}

echo "[+] generated coe file ${COE_PATH}"

