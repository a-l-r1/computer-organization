lui $1, 0x4242
ori $1, 0x4242
sw $1, 0($0)
nop
nop

# T_use (reg2) < T_new (E) and T_use (reg2) < T_new (M)
lw $2, 0($0)
movz $3, $1, $0
nop
nop
nop

# T_use (reg1) < T_new (W) and T_use (reg1) < T_new (M)
lw $4, 0($0)
movz $5, $4, $0
nop
nop
nop
