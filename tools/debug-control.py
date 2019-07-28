#!/usr/bin/env python3
# Debug controller script.
# TODO: implement Windows support
import os
import sys

_debug_on = '`define DEBUG'
_debug_off = '`undef DEBUG'


def _file_replace(path: str, from_: str, to: str) -> None:
    try:
        with open(path, 'r') as f:
            contents = f.read()
            new_contents = contents.replace(from_, to)

        with open(path, 'w') as f:
            f.write(new_contents)
    except:
        raise


def do_on(path: str) -> int:
    _file_replace(path, _debug_off, _debug_on)
    return 0


def do_off(path: str) -> int:
    _file_replace(path, _debug_on, _debug_off)
    return 0


def main() -> None:
    if sys.platform not in ['linux', 'win32']:
        raise RuntimeError('OS unsupported')

    if len(sys.argv) != 3:
        print('usage: %s <path/to/debug.h> [on|off|1|0]' % sys.argv[0])
        sys.exit(1)

    if sys.argv[2] not in ['on', 'off', '1', '0']:
        raise RuntimeError('invalid argv[2]')

    if not os.path.exists(sys.argv[1]):
        raise RuntimeError('debug header file %s not found' % sys.argv[1])

    if not sys.argv[1].endswith('.h'):
        raise RuntimeError('argv[1] not ends in .h')

    if sys.argv[2] in ['on', '1']:
        sys.exit(do_on(sys.argv[1]))

    if sys.argv[2] in ['off', '0']:
        sys.exit(do_off(sys.argv[1]))

if __name__ == '__main__':
    main()

