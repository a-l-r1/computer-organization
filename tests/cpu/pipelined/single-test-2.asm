luI $9, 0x002a
nop
nop
nop
nop
ori $9, 0x002a
nop
nop
nop
nop

# Test 9: movz
movz $10, $9, $0
nop
nop
nop
nop
movz $11, $9, $9
nop
nop
nop
nop

# Test 10: j
j good1
nop
nop
nop
nop
evil1:
lui $12, 0xdead
nop
nop
nop
nop
ori $12, 0xbeef
nop
nop
nop
nop
good1:
lui $12, 0x0123
nop
nop
nop
nop
ori $12, 0x4567
nop
nop
nop
nop

# Test 11: jal
jal good2
nop
nop
nop
nop
evil2:
lui $13, 0xdead
nop
nop
nop
nop
ori $13, 0xbeef
nop
nop
nop
nop
good2:
lui $13, 0x0123
nop
nop
nop
nop
ori $13, 0x4567
nop
nop
nop
nop

# Test 12: jr
lui $14, 0x0000
nop
nop
nop
nop
ori $14, 0x3168
nop
nop
nop
nop
jr $14
nop
nop
nop
nop
lui $15, 0xdeed
nop
nop
nop
nop
lui $15, 0x002a
nop
nop
nop
nop
