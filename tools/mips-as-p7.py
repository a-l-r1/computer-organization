#!/usr/bin/env python3
# Simple script for converting MIPS assembly files to machine code in hexadecimal format, using MARS headlessly on Linux. 
# TODO: Windows support. 
import os
import sys


def linux_main() -> int:
    mars_path = 'tools/mars.jar'
    java_path = 'java'

    if not sys.argv[1].endswith('.asm'):
       raise RuntimeError('argv 1 %s doesn\'t end with .asm' % sys.argv[1])

    try:
        # If this statement is successfully executed, the return code will be one of MARS
        # nc - Don't display copyright information
        # HexText - Dump hexadecimal text.
        os.system(' '.join([java_path, 
            '-jar', mars_path, 
            'nc', 'db', 'mc', 'CompactDataAtZero', 'a', 'dump', '0x00003000-0x00004180', 'HexText', sys.argv[2], sys.argv[1]]))
        os.system(' '.join([java_path, 
            '-jar', mars_path, 
            'nc', 'db', 'mc', 'CompactDataAtZero', 'a', 'dump', '0x00004180-0x00005000', 'HexText', sys.argv[3], sys.argv[1]]))
    except:
        raise

    # os.execve won't return
    return 0


def main() -> None:
    if sys.platform not in ['linux', 'win32', 'cygwin']:
        raise RuntimeError('OS unsupported')

    if sys.platform == 'win32':
        raise RuntimeError('TODO: win32 not implemented')

    if len(sys.argv) != 4:
        print('usage: mips-as.py asmfile hexfile isr_hexfile')
        sys.exit(1)

    if sys.platform == 'linux':
        sys.exit(linux_main())

    # TODO: cygwin hack
    if sys.platform == 'cygwin':
        sys.exit(linux_main())


if __name__ == '__main__':
    main()

