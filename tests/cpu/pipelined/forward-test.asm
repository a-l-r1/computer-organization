# fm_e: M2E_alu
lui $1, 0x002a
ori $1, 0x002a
nop
nop
nop

# fm_d: E2D_npc, fm_m: M2E_npc, fm_m: W2M_rf
jal good
addu $2, $31, $31
evil:
lui $2, 0xdead
lui $2, 0xbeef
good:
nop
nop
nop
nop

# fm_d: E2D_rf
movz $3, $1, $0
addu $0, $3, $3
nop
nop
nop

# fm_d: M2D_npc
jal good2
nop
good2:
addu $0, $31, $31
nop
nop
nop
nop

# fm_d: M2D_alu, fw_e: W2E_rf
lui $4, 0x4242
nop
ori $4, 0x4242
nop
nop

# fm_d: W2D_rf
lui $5, 0x4242
nop
nop
ori $5, 0x4242
nop
nop
nop
nop
