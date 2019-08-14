.text
lui $1, 0x8000
ori $1, 0x0000
lui $2, 0x8000
ori $2, 0x0001

addu $3, $1, $2

# exception
add $4, $1, $2

loop:
beq $0, $0, loop
nop

.ktext 0x4180
addu $1, $0, $0
addu $2, $0, $0
eret
lui $5, 0xdead
ori $5, 0xbeef
