ori $1, 0x2
ori $2, 0x2
addu $3, $1, $2

lui $4, 0xffff
ori $4, 0xffff
subu $5, $0, $4

sw $4, 4($0)
lw $6, 4($0)

beq $4, $5, bad
lui $7, 0xdead
lui $8, 0xbeef
bad:

beq $0, $0, front
back:
ori $9, 0xbabe

front:
beq $1, $1, back

sw $1, 4($0)