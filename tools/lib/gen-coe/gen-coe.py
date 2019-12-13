#!/usr/bin/env python3
import sys


def _check_format(s: str) -> None:
    if s == '':
        return

    if len(s) != 8:
        raise ValueError(f'line \'{s}\' does not contain 8 characters')

    for c in s:
        if c.lower() not in {'0', '1', '2', '3', '4', '5', '6', '7', '8', 
                '9', 'a', 'b', 'c', 'd', 'e', 'f'}:
            raise ValueError(f'line \'{s}\' has illegal character \'{c}\'')


COE_HEADER = "memory_initialization_radix=16;\n" + \
    "memory_initialization_vector=\n"
IM_START_ADDRESS = 0x00003000
IM_ISR_ADDRESS = 0x00004180
IM_ADDRESS_UB = 0x00004ffc

code_filename = sys.argv[1]
isr_filename = sys.argv[2]
result_filename = sys.argv[3]

with open(result_filename, 'w+') as f:
    # write header
    f.write(COE_HEADER)

    curr_address = IM_START_ADDRESS

    # write code.txt
    with open(code_filename, 'r') as f1:
        for line in f1:
            if line[-1] == '\n':
                line = line[:-1]

            _check_format(line)
            f.write(line + ',\n')

            curr_address += 4
            if curr_address >= IM_ISR_ADDRESS:
                raise ValueError('code too large to fit')
    
    while curr_address < IM_ISR_ADDRESS:
        f.write('00000000,\n')
        curr_address += 4

    # write code_handler.txt
    with open(isr_filename, 'r') as f2:
        for line in f2:
            if line[-1] == '\n':
                line = line[:-1]

            _check_format(line)
            f.write(line + ',\n')

            curr_address += 4
            if curr_address > IM_ADDRESS_UB:
                raise ValueError('isr too large to fit')

    # rewrite last line
    # NOTE: No need to truncate since file size unchanged. 
    f.seek(f.tell() - 2)
    f.write(';')

