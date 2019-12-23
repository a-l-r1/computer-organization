#!/bin/bash
java -jar tools/mars-p8-ng-mmu.jar nc db mc P8 a dump 0xbfc03000-0xbfc04180 HexText project/code.txt $1
# workaround for p6 test cases
> project/code_handler.txt
java -jar tools/mars-p8-ng-mmu.jar nc db mc P8 a dump 0xbfc04180-0xbfc05000 HexText project/code_handler.txt $1
> project/code_prog0.txt
java -jar tools/mars-p8-ng-mmu.jar nc db mc P8 a dump 0xbfc02000-0xbfc03000 HexText project/code_prog0.txt $1
> project/code_prog1.txt
java -jar tools/mars-p8-ng-mmu.jar nc db mc P8 a dump 0xbfc05000-0xbfc05ffc HexText project/code_prog1.txt $1

