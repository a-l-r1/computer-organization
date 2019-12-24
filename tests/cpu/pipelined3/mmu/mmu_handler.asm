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

.macro panic()
loop_panic:
beq $0, $0, loop_panic
nop
.end_macro

.text 0xbfc03000
# initialize $k0
lui $k0, 0xbfc0
ori $k0, 0x0100

lui $t0, 0xcafe
ori $t0, 0xbabe
sw $t0, 0x1000($0)

# expected: got 0xcafebabe
lw $t0, 0x3000($0)

# fill dm
# target tlb[0]
lui $t0, 0x0000
ori $t0, 0x0000 # p = 0, index = 0
mtc0 $t0, $0 # index

lui $t0, 0x0000
ori $t0, 0x0200 # vpn = 0x2, asid = 0
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

sw $t0, 0x5000($0)

loop:
beq $0, $0, loop
nop

.text 0xbfc04180
# NOTE: Assume only MMU exceptions are handled here. 
save_context()

# get exc_i
mfc0 $s0, $13
srl $s0, $s0, 2
andi $s0, $s0, 0x1f

# get badvaddr
mfc0 $s1, $8

# check if NULL
lui $t0, 0xffff
ori $t0, 0xf000
and $s1, $s1, $t0

# panic if NULL 
beq $s1, $0, panic
nop

# TLBS
ori $t0, $0, 0x2
beq $s0, $t0, tlbs
nop

# TLBL
ori $t0, $0, 0x3
beq $s0, $t0, tlbl
nop

# Mod
ori $t0, $0, 0x1
beq $s0, $t0, mod
nop

tlbs:
tlbl:
	# NOTE: AdEL would be triggered after ISR if fetching instructions. 

	# simply map to dm globally

	# read TLB entry with matching vpn and asid if any
	tlbp
	
	mfc0 $t0, $0 # index
	srl $t0, $t0, 31 # p
	
	bne $t0, $0, no_replace
	nop

		mfc0 $t0, $1
		mtc0 $t0, $0 # random -> index
	
	no_replace:

	# entryhi is automatically initialized

	lui $t0, 0x0000
	ori $t0, 0x0007 # pfn = 0, d = 1, v = 1, g = 1
	mtc0 $t0, $2 # entrylo0

	lui $t0, 0x0000
	ori $t0, 0x0087
	mtc0 $t0, $3 # entrylo1

	mfc0 $t0, $8 # badvaddr
	srl $t0, $t0, 13 # get vpn
	bne $t0, $0, not_null_twin
	nop
	
		# NOTE: Have to pay attention to accessing the second page 
		# in the address space. Make sure that the first page in 
		# the address space is still unmapped. 
		lui $t0, 0x0000
		ori $t0, 0x0001 # d = 0, v = 0, g = 1
		mtc0 $t0, $2 # entrylo0
	
	not_null_twin:

	tlbwi

beq $0, $0, handler_end
nop

mod:

	# simply enable d bit

	# search the whole TLB
	tlbp

	mfc0 $t0, $0 # index
	
	srl $t0, $t0, 31 # p
	bne $t0, $0, panic # invalid state; p should be 0
	nop

	# index is initialized

	# NOTE: g bit mismatch not considered. 

	# fetch corresponding entryhi and entrylo[01]
	tlbr

	lui $t1, 0x0000
	ori $t1, 0x0004 # bitmask

	mfc0 $t0, $2 # entrylo0
	or $t0, $t0, $t1 # enable d bit
	mtc0 $t0, $2

	mfc0 $t0, $3 # entrylo0
	or $t0, $t0, $t1 # enable d bit
	mtc0 $t0, $3
	
	# commit
	tlbwi

beq $0, $0, handler_end
nop

handler_end:
restore_context()
eret

panic:
beq $0, $0, panic
nop

