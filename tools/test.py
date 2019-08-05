#!/usr/bin/env python3
# Main testing script by comparing the (processed) simulated result with the result of the implementation
# NOTE: requires Python 3.5
# TODO: Windows support
import os
import shutil
import subprocess
import sys
import tempfile

from typing import List, Tuple


def _get_command_result(args: List[str]) -> str:
    # TODO: deal with stderr

    # os.system emulation
    result = subprocess.run(args, stdout=subprocess.PIPE)
    if result.returncode != 0:
        raise RuntimeError('subprocess %s got return code %d' % ' '.join(args))

    return result.stdout.decode('utf-8')


def _process_outputs(ref_result: str, result: str) -> Tuple[str, str]:
    # Manual dos2unix
    result = result.replace('\r\n', '\n')
    ref_result = ref_result.replace('\r\n', '\n')

    # Remove extra trailing '\n' in ref_result
    if ref_result[-2] == '\n':
        ref_result = ref_result[:-1]

    # TODO: cannot check timing info in result
    # Split result in lines and remove timing
    lines = result.split('\n')

    for i in range(len(lines)):
        # TODO: what if iverilog messages contain @'s?
        at_index = lines[i].find('@')

        if at_index != -1:
            lines[i] = lines[i][at_index:]

    result = '\n'.join(lines)

    # TODO: Actually fix memory-related warnings.
    # Ignore memory-related warnings.

    lines = result.split('\n')
    # TODO: Use actual regexps. 
    # Try to be portable and don't depend on line numbers. 
    result = '\n'.join(filter(
        lambda x: not(x.startswith('WARNING: src/datapath/im.v:') and x.find(': $readmemh') != -1), 
        lines))

    # NOTE: In (cyg)win iSim messages end with '\r'
    isim_messages = [
            'ISim P.20131013 (signature 0x7708f090)', 
            'This is a Full version of ISim.', 
            'Time resolution is 1 ps', 
            'Simulator is doing circuit initialization process.', 
            'Finished circuit initialization process.'
    ]

    lines = result.split('\n')
    # TODO: use actual regexps
    result = '\n'.join(filter(
        lambda x: x not in isim_messages, 
        lines))

    return ref_result, result


def main() -> None:
    if sys.platform not in ['linux', 'cygwin']:
        raise RuntimeError('OS unsupported')

    # modify $PATH for automatic mips-as inclusion
    # TODO: shell script-like hack
    os.environ['PATH'] = \
            os.path.dirname(os.path.realpath(__file__)) + \
            ':' + \
            os.environ['PATH']

    if len(sys.argv) != 3:
        print('usage: %s <target> <path/to/asm-file.asm>' % sys.argv[0])
        print('available targets: see tools/simulate.py')
        sys.exit(1)

    try:
        ref_output = _get_command_result(['simulate-mars.py', sys.argv[2]])
        output = _get_command_result(['simulate.py', sys.argv[1], sys.argv[2], 'nodebug'])
    except:
        raise

    ref_output, output = _process_outputs(ref_output, output)

    temp_path = tempfile.mkdtemp(prefix='test-', dir='tmp/')

    with open(temp_path + '/' + 'ref_output_processed', 'w') as ref_output_file, \
            open(temp_path + '/' + 'output_processed', 'w') as output_file:
        ref_output_file.write(ref_output)
        output_file.write(output)

    # TODO: colordiff on Windows?
    diff_result = subprocess.run(['colordiff', '-u', ref_output_file.name, output_file.name])
    if diff_result.returncode == 0:
        print('%s: test passed: target %s, asmfile %s' % (sys.argv[0], sys.argv[1], sys.argv[2]))

    shutil.rmtree(temp_path)


if __name__ == '__main__':
    main()

