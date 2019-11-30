.text
lui $1, 0xcafe
ori $1, 0xbabe
lui $2, 0x00c0
ori $2, 0xffee

addu $3, $1, $2

mult $1, $2

# exception at level M
sw $0, 1($0)

# STORE_Ms at level D and E
mthi $1
mthi $2

# flush pipeline and wait for the mult to complete
nop
nop
nop
nop
nop
nop
nop

# exception at level M
sw $0, 1($0)

mthi $0

# flush pipeline
nop
nop
nop
nop
nop

lui $1, 0x8000

mult $1, $1

# exception at level M
add $1, $1, $1

loop:
beq $0, $0, loop
nop

.ktext 0x4180
mfc0 $4, $14
addiu $4, $4, 4
mtc0 $4, $14
eret

