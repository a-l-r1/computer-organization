.text
lui $1, 0x4242
ori $1, 0x4242
lui $2, 0xbfc0
ori $2, 0x0000
sw $1, 0($2)
nop
nop

lw $2, 0($2)
add $3, $1, $2
nop
nop
nop

loop:
beq $0, $0, loop
nop

