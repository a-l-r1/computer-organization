.text
lui $t0, 0x0000
ori $t0, 0x7f38

lui $t1, 0x0000
ori $t1, 0x7017
sw $t1, 0($t0)

lui $t1, 0x0000
ori $t1, 0x1737
sw $t1, 4($t0)

lui $t1, 0x0000
ori $t1, 0x000a
sw $t1, 4($t0)

loop:
beq $0, $0, loop
nop

.text 0x4180
eret

