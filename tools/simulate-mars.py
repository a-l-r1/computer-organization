#!/usr/bin/env python3
# Simulate the CPU in MARS, the reference MIPS simulator. 
import os
import sys


def main() -> None:
    _mars_path = os.path.dirname(os.path.realpath(__file__)) + '/' + 'mars.jar'
    if sys.platform not in ['linux', 'win32', 'cygwin']:
        raise RuntimeError('OS unsupported')

    if len(sys.argv) != 2:
        print('usage: %s <path/to/asm-file.asm>' % sys.argv[0])
        sys.exit(1)

    if not sys.argv[1].endswith('.asm'):
        raise RuntimeError('argv[1] doesn\'t end with .asm')

    # TODO: hack
    if sys.platform == 'cygwin':
        _mars_path = 'tools/mars.jar'

    # TODO: no more hardcoded mars path
    os.system(' '.join(
        ['java', '-jar', _mars_path, 
            'mc', 'CompactDataAtZero', 
            'nc', 
            'db', 
            sys.argv[1]
            ]))


if __name__ == '__main__':
    main()

