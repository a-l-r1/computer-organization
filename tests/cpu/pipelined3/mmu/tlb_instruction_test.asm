.text
lui $s0, 0xbfc0
ori $s0, 0x0000

lui $t0, 0xffff
ori $t0, 0xffff
lui $t1, 0xffff # NOTE: g bit is 0
ori $t1, 0xfffe

mtc0 $t0, $0 # index
mtc0 $t0, $10 # entryhi
mtc0 $t0, $2 # entrylo0
mtc0 $t1, $3 # entrylo1

tlbwi

# NOTE: check stalling
sll $0, $0, 0xd

tlbr

tlbp

loop:
beq $0, $0, loop
nop

