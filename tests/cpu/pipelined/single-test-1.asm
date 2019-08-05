# Test 1: lui
# 42
lui $1, 0x002a
nop
nop
nop
nop
lui $2, 0xffff
nop
nop
nop
nop

# Test 2: ori
ori $1, 0x002a
nop
nop
nop
nop
ori $2, 0xffff
nop
nop
nop
nop

# Test 3: addu
addu $3, $1, $2
nop
nop
nop
nop
addu $0, $1, $2
nop
nop
nop
nop

# Test 4: subu
subu $4, $1, $2
nop
nop
nop
nop
subu $5, $0, $0
nop
nop
nop
nop

# Test 5: sw
sw $3, 0($0)
nop
nop
nop
nop
sw $3, 8($0)
nop
nop
nop
nop

# Test 6: lw
lw $6, 0($0)
nop
nop
nop
nop
lw $7, 0($0)
nop
nop
nop
nop
lw $8, 0($0)
nop
nop
nop
nop

# Test 7: beq
beq $0, $0, good
nop
nop
nop
nop
evil:
lui $9, 0xdead
nop
nop
nop
nop
ori $9, 0xbeef
nop
nop
nop
nop
good:
lui $9, 0x0123
nop
nop
nop
nop
ori $9, 0x4567
nop
nop
nop
nop

# Test 8: nop
nop

