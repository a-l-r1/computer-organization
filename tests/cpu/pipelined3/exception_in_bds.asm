.text
lui $1, 0x8000
ori $1, 0x0000

loop:
beq $0, $0, loop
add $2, $1, $1

.text 0x4180
mfc0 $3, $12
mfc0 $4, $13
mfc0 $5, $14
addu $1, $0, $0
eret

