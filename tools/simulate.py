#!/usr/bin/env python3
# Simulate the CPU in Icarus Verilog. 
# NOTE: Icarus Verilog may differ with iSim functionally. When in doubt, iSim is the reference. 
# NOTE: Windows unsupported. 
import os
import pathlib
import sys
import shutil
import tempfile

from pathlib import Path


_tmp_dir = 'tmp/'

_datapath_dir = 'src/datapath'
_datapath_srcs = list(filter(lambda x: x.endswith('.v'), map(str, Path(_datapath_dir).iterdir())))
_debug_dir = 'src/debug'
_debug_srcs = list(filter(lambda x: x.endswith('.v'), map(str, Path(_debug_dir).iterdir())))

_include_dir = 'src/include'
_include_options = ['-I' + _include_dir]

_targets = {
        'single-cycle': [*_include_options, *_datapath_srcs, *_debug_srcs, 'src/control/single-cycle.v', 'src/cpu/single-cycle.v', 'tests/cpu/single-cycle/single-cycle_tb.v']
        }
_target_aliases = {
        'p4': 'single-cycle', 
        'single_cycle': 'single-cycle'
        }


def main() -> None:
    if sys.platform not in ['linux']:
        raise RuntimeError('OS unsupported')

    if len(sys.argv) != 3:
        print('usage: %s <target> <path/to/asm-file.asm>' % sys.argv[0])
        print('available targets: %s' % ', '.join([*_targets.keys(), *_target_aliases.keys()]))
        sys.exit(1)

    if sys.argv[1] not in [*_targets.keys(), *_target_aliases.keys()]:
        raise RuntimeError('invalid target %s' % sys.argv[1])

    target = sys.argv[1]

    if target in _target_aliases.keys():
        target = _target_aliases[target]
    
    try:
        # tempfile.mkdtemp will actually create the directory by the most secure method possible
        temp_path = tempfile.mkdtemp(prefix='simulate-', dir='tmp/')

        os.system(' '.join(
                ['iverilog', 
                    *_targets[target], 
                    '-o', temp_path + '/' + target
                    ]))
        
        # modify $PATH for automatic mips-as inclusion
        # TODO: shell script-like hack
        os.environ['PATH'] = \
                os.path.dirname(os.path.realpath(__file__)) + \
                ':' + \
                os.environ['PATH']

        # mips-as will do the necessary checks
        ret = os.system(' '.join(
                ['mips-as.py', 
                    sys.argv[2], 
                    temp_path + '/' + 'code.hex'
                    ]))
        # mips-as encountered an error
        if ret != 0:
            sys.exit(ret)

        # TODO: use context managers for safer operations
        # change cwd, so the simulation program is able to find code.hex
        old_cwd = os.getcwd()
        os.chdir(temp_path)

        os.system('./' + target)

        # change it back for future operations
        os.chdir(old_cwd)

        try:
            shutil.rmtree(temp_path)
        except:
            raise

    except:
        raise


if __name__ == '__main__':
    main()
