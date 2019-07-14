#!/usr/bin/env python3
# Simple script to convert markdown to python, using pandoc on Linux.
import sys
import os


def main() -> None:
    if sys.platform != 'linux':
        raise RuntimeError('this script doesn\'t support anything other than Linux, not even Darwin')

    if len(sys.argv) < 3:
        raise RuntimeError('this script needs at least 3 arguments, the last as output filename and the others as input filenames')

    try:
        # TODO: more granularity and no more command concatenating and no hardcoded pandoc paths
        os.execve('/usr/bin/pandoc', ['pandoc', *sys.argv[1:-1], '--variable', 'mainfont=Noto Sans CJK SC', '--variable', 'sansfont=Noto Sans CJK SC', '--variable', 'monofont=Noto Sans Mono CJK SC', '--pdf-engine=xelatex', '-o', sys.argv[-1]], os.environ)
    except:
        raise


if __name__ == '__main__':
    main()

