#!/usr/bin/env python3
# Simple script for converting MIPS assembly files to machine code in hexadecimal format, using MARS headlessly on Linux. 
# TODO: Windows support. 
import os
import sys


def linux_main() -> int:
    mars_path = 'tools/mars.jar'
    java_path = '/usr/bin/java'

    if not sys.argv[1].endswith('.asm'):
        raise RuntimeError('argv 1 %s doesn\'t end with .asm' % sys.argv[1])

    try:
        # nc - Don't display copyright information
        # HexText - Dump hexadecimal text.
        os.execve(java_path, [java_path.split('/')[-1], '-jar', mars_path, 'nc', 'a', 'dump', '.text', 'HexText', sys.argv[2], sys.argv[1]], os.environ)
    except:
        raise

    return 0


def main() -> None:
    if sys.platform not in ['linux', 'win32']:
        raise RuntimeError('OS unsupported')

    if sys.platform == 'win32':
        raise RuntimeError('TODO: win32 not implemented')

    if len(sys.argv) != 3:
        print('usage: mips-as.py asmfile hexfile')
        sys.exit(1)

    if sys.platform == 'linux':
        sys.exit(linux_main())


if __name__ == '__main__':
    main()

