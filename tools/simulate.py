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
        'single-cycle': [*_include_options, *_datapath_srcs, *_debug_srcs, 'src/control/single-cycle.v', 'src/cpu/single-cycle.v', 'tests/cpu/single-cycle/single-cycle_tb.v'], 
        'pipelined': [*_include_options, *_datapath_srcs, *_debug_srcs, 'src/control/pipelined.v', 'src/cpu/pipelined.v', 'tests/cpu/pipelined/pipelined_tb.v'], 
        'pipelined2': [*_include_options, *_datapath_srcs, *_debug_srcs, 'src/control/pipelined2.v', 'src/cpu/pipelined2.v', 'tests/cpu/pipelined2/pipelined2_tb.v']
        }
_target_aliases = {
        'p4': 'single-cycle', 
        'single_cycle': 'single-cycle', 
        'p5': 'pipelined', 
        'pipeline': 'pipelined', 
        'p6': 'pipelined2', 
        'pipelined-ng': 'pipelined2'
        }


def main() -> None:
    if sys.platform not in ['linux', 'win32', 'cygwin']:
        raise RuntimeError('OS unsupported')

    if sys.platform == 'win32':
        raise RuntimeError('not implemented')

    if len(sys.argv) not in [3, 4] or (len(sys.argv) == 4 and sys.argv[3] != 'nodebug'):
        print('usage: %s <target> <path/to/asm-file.asm> [nodebug]' % sys.argv[0])
        print('available targets: %s' % ', '.join([*_targets.keys(), *_target_aliases.keys()]))
        sys.exit(1)

    if sys.argv[1] not in [*_targets.keys(), *_target_aliases.keys()]:
        raise RuntimeError('invalid target %s' % sys.argv[1])

    target = sys.argv[1]

    if target in _target_aliases.keys():
        target = _target_aliases[target]

    # Use an iterable to take advantage of the * operator
    # Remember short circuit evaluation
    nodebug_options = ['-D', 'NODEBUG='] if len(sys.argv) == 4 and sys.argv[3] == 'nodebug' else []
    
    try:
        # tempfile.mkdtemp will actually create the directory by the most secure method possible
        temp_path = tempfile.mkdtemp(prefix='simulate-', dir='tmp/')

        if sys.platform == 'linux':
            # It seems that iSim uses IEEE1364-2001 standard, so we have to downgrade to an older version of Verilog. 
            os.system(' '.join(
                    ['iverilog', 
                        '-g2001', 
                        *nodebug_options, 
                        *_targets[target], 
                        '-o', temp_path + '/' + target
                        ]))

        if sys.platform == 'linux' or sys.platform == 'cygwin':
            # modify $PATH for automatic mips-as inclusion
            # TODO: shell script-like hack
            os.environ['PATH'] = \
                    os.path.dirname(os.path.realpath(__file__)) + \
                    ':' + \
                    os.environ['PATH']

        if sys.platform == 'cygwin':
            # TODO: environment hack
            os.environ['Path'] = r'C:\Xilinx\14.7\ISE_DS\ISE\bin\nt64;C:\Xilinx\14.7\ISE_DS\ISE\lib\nt64;C:\Xilinx\14.7\ISE_DS\ISE\..\..\..\DocNav;C:\Xilinx\14.7\ISE_DS\PlanAhead\bin;C:\Xilinx\14.7\ISE_DS\EDK\bin\nt64;C:\Xilinx\14.7\ISE_DS\EDK\lib\nt64;C:\Xilinx\14.7\ISE_DS\EDK\gnu\microblaze\nt\bin;C:\Xilinx\14.7\ISE_DS\EDK\gnu\powerpc-eabi\nt\bin;C:\Xilinx\14.7\ISE_DS\EDK\gnuwin\bin;C:\Xilinx\14.7\ISE_DS\EDK\gnu\arm\nt\bin;C:\Xilinx\14.7\ISE_DS\EDK\gnu\microblaze\linux_toolchain\nt64_be\bin;C:\Xilinx\14.7\ISE_DS\EDK\gnu\microblaze\linux_toolchain\nt64_le\bin;C:\Xilinx\14.7\ISE_DS\common\bin\nt64;C:\Xilinx\14.7\ISE_DS\common\lib\nt64;C:\Program Files\Alacritty\;C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Windows\System32\OpenSSH\;C:\Program Files\Java\jdk-12.0.2\bin;C:\Users\A-l-r\AppData\Local\Microsoft\WindowsApps'
            os.environ['XILINX'] = r'C:\Xilinx\14.7\ISE_DS\ISE'
            os.environ['XILINX_DSP'] = r'C:\Xilinx\14.7\ISE_DS\ISE'
            os.environ['XILINX_EDK'] = r'C:\Xilinx\14.7\ISE_DS\EDK'
            os.environ['XILINX_PLANAHEAD'] = r'C:\Xilinx\14.7\ISE_DS\PlanAhead'
        # TODO: duplicate code
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
        if sys.platform == 'linux':
            os.chdir(temp_path)
        else:
            os.chdir('project')

        if sys.platform == 'linux':
            os.system('./' + target)
        elif sys.platform == 'cygwin':
            # TODO: location hack
            os.system(' '.join([
                'cp', '../' + temp_path + '/code.hex', '.'
            ]))

            # TODO: path hack
            os.system(' '.join([
                './' + target + '_tb_isim_beh.exe', 
                '-intstyle', 'ise', 
                '-tclbatch', '../tools/share/isim.cmd', 
                '-wdb', target + '_tb_isim_beh.wdb'
                ]))


        # change it back for future operations
        os.chdir(old_cwd)

        shutil.rmtree(temp_path)
    except:
        raise


if __name__ == '__main__':
    main()

