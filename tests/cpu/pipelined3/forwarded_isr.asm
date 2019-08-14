.text
lui $1, 0x8000
ori $1, 0x0000
lui $2, 0x8000
ori $2, 0x0000

add $3, $1, $2

loop:
beq $0, $0, loop
nop

.text 0x4180
mfc0 $4, $14
addiu $4, $4, 4
mtc0 $4, $14
eret
