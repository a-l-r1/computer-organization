# Test 1: lui
# 42
lui $1, 0x002a
lui $2, 0xffff

# Test 2: ori
ori $1, 0x002a
ori $2, 0xffff

# Test 3: addu
addu $3, $1, $2
addu $0, $1, $2

# Test 4: subu
subu $4, $1, $2
subu $5, $0, $0

# Test 5: sw
sw $3, 0($0)
sw $3, 8($0)

# Test 6: lw
lw $6, 0($0)
lw $7, 0($0)
lw $8, 0($0)

# Test 7: beq
beq $0, $0, good
evil:
lui $9, 0xdead
ori $9, 0xbeef
good:
lui $9, 0x0123
ori $9, 0x4567

# Test 8: nop
nop

# Test 9: slt
lui $10, 0xffff
slt $10, $10, $0

