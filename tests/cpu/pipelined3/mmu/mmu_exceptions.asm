.macro save_context()
sw $1, 4($k0)
sw $2, 8($k0)
sw $3, 12($k0)
sw $4, 16($k0)
sw $5, 20($k0)
sw $6, 24($k0)
sw $7, 28($k0)
sw $8, 32($k0)
sw $9, 36($k0)
sw $10, 40($k0)
sw $11, 44($k0)
sw $12, 48($k0)
sw $13, 52($k0)
sw $14, 56($k0)
sw $15, 60($k0)
sw $16, 64($k0)
sw $17, 68($k0)
sw $18, 72($k0)
sw $19, 76($k0)
sw $20, 80($k0)
sw $21, 84($k0)
sw $22, 88($k0)
sw $23, 92($k0)
sw $24, 96($k0)
sw $25, 100($k0)
sw $26, 104($k0)
sw $27, 108($k0)
sw $28, 112($k0)
sw $29, 116($k0)
sw $30, 120($k0)
sw $31, 124($k0)
.end_macro

.macro restore_context()
lw $1, 4($k0)
lw $2, 8($k0)
lw $3, 12($k0)
lw $4, 16($k0)
lw $5, 20($k0)
lw $6, 24($k0)
lw $7, 28($k0)
lw $8, 32($k0)
lw $9, 36($k0)
lw $10, 40($k0)
lw $11, 44($k0)
lw $12, 48($k0)
lw $13, 52($k0)
lw $14, 56($k0)
lw $15, 60($k0)
lw $16, 64($k0)
lw $17, 68($k0)
lw $18, 72($k0)
lw $19, 76($k0)
lw $20, 80($k0)
lw $21, 84($k0)
lw $22, 88($k0)
lw $23, 92($k0)
lw $24, 96($k0)
lw $25, 100($k0)
lw $26, 104($k0)
lw $27, 108($k0)
lw $28, 112($k0)
lw $29, 116($k0)
lw $30, 120($k0)
lw $31, 124($k0)
.end_macro

.text 0xbfc03000
# initialize $k0
lui $k0, 0xbfc0
ori $k0, 0x0100

# TLBS
sw $0, 0($0)

# TLBL
lw $0, 0($0)

# fill dm
# target tlb[0]
lui $t0, 0x0000
ori $t0, 0x0000 # p = 0, index = 0
mtc0 $t0, $0 # index

lui $t0, 0x0000
ori $t0, 0x0000 # vpn = 0x0, asid = 0
mtc0 $t0, $10 # entryhi

# 0x00000 -> 0x00000
lui $t0, 0x0000
ori $t0, 0x0007 # pfn = 0x00000, d = 1, v = 1, g = 1
mtc0 $t0, $2 # entrylo0

# 0x00001 -> 0x00001
lui $t0, 0x0000
ori $t0, 0x0043 # pfn = 0x00001, d = 0, v = 1, g = 1
mtc0 $t0, $3 # entrylo1

# commit
tlbwi

# MOD
sw $0, 0x1000($0)

loop:
beq $0, $0, loop
nop

.text 0xbfc04180
# NOTE: Branch instructions wouldn't trigger TLB exceptions. 
mfc0 $t0, $14
addiu $t0, $t0, 4
mtc0 $t0, $14
eret

