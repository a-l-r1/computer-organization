#!/bin/bash
echo "[*] generating coe file for $1"

# mips-as-p7.py
java -jar tools/mars.jar nc db mc CompactDataAtZero a dump 0x00003000-0x00004180 HexText project/code.txt $1
# workaround for p6 test cases
> project/code_handler.txt
java -jar tools/mars.jar nc db mc CompactDataAtZero a dump 0x00004180-0x00005000 HexText project/code_handler.txt $1

COE_FILENAME=$(basename $1 | sed 's/\.asm$/\.coe/g')
COE_PATH=project/coe/${COE_FILENAME}

tools/lib/gen-coe/gen-coe.py project/code.txt project/code_handler.txt ${COE_PATH}

echo "[+] generated coe file ${COE_PATH}"

