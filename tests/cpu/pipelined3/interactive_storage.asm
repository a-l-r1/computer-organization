.text 0x3000
li $s0, 0x00007f40 # buttons base address
li $s1, 0x00007f2c # switches base address
li $s2, 0x00007f38 # nixie base address
li $s3, 0x0 # saved buttons value
li $s4, 0x0 # saved address
li $s5, 0x0 # saved value

loop:

	# load buttons
	lw $s3, 0($s0)

	li $t0, 1
	beq $s3, $t0, write
	nop

	li $t0, 2
	beq $s3, $t0, read
	nop

beq $0, $0, loop
nop

write:

	# read switches
	lw $s4, 0($s1) # address
	lw $s5, 4($s1) # value

	# check address
	# $t0: valid flag

	# check if out of range
	# NOTE: sltiu: sign extend imm, unsigned comparison
	sltiu $t0, $s4, 0x2ffd
	beq $t0, $0, loop
	nop

	# check if word-aligned
	andi $t0, $s4, 0x3
	bne $t0, $0, loop
	nop

	# save
	sw $s5, 0($s4)

	# write to nixie
	sw $s5, 0($s2)

beq $0, $0, loop
nop

read:

	# read switches
	lw $s4, 0($s1) # address
	lw $s5, 4($s1) # value

	# check address
	# $t0: valid flag

	# check if out of range
	# NOTE: sltiu: sign extend imm, unsigned comparison
	sltiu $t0, $s4, 0x2ffd
	beq $t0, $0, loop
	nop

	# check if word-aligned
	andi $t0, $s4, 0x3
	bne $t0, $0, loop
	nop

	# load
	lw $t0, 0($s4)

	# write to nixie
	sw $t0, 0($s2)

beq $0, $0, loop
nop

.text 0x4180
# NOTE: Don't clobber $t0. 

# just skip
mfc0 $t9, $14
addiu $t9, $t9, 4
mtc0 $t9, $14
eret

