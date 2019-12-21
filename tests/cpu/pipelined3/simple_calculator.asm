.text
nop
nop
nop
nop
nop

ori $s0, $0, 0x7f2c # switches base address
ori $s1, $0, 0x7f38 # nixie base address
ori $s2, $0, 0x7f40 # buttons base address

loop:

	lw $s3, 0($s0) # switch group 1
	lw $s4, 4($s0) # switch group 2
	lw $s5, 0($s2) # buttons

	ori $t0, $0, 0x0001
	beq $s5, $t0, case_0
	nop

	ori $t0, $0, 0x0002
	beq $s5, $t0, case_1
	nop

	ori $t0, $0, 0x0004
	beq $s5, $t0, case_2
	nop

	ori $t0, $0, 0x0008
	beq $s5, $t0, case_3
	nop

	ori $t0, $0, 0x0010
	beq $s5, $t0, case_4
	nop

	ori $t0, $0, 0x0020
	beq $s5, $t0, case_5
	nop

	ori $t0, $0, 0x0040
	beq $s5, $t0, case_6
	nop

	ori $t0, $0, 0x0080
	beq $s5, $t0, case_7
	nop

beq $0, $0, loop
nop

case_0:

	addu $t0, $s3, $s4
	sw $t0, 0($s1)

beq $0, $0, loop
nop

case_1:

	subu $t0, $s3, $s4
	sw $t0, 0($s1)

beq $0, $0, loop
nop

case_2:

	and $t0, $s3, $s4
	sw $t0, 0($s1)

beq $0, $0, loop
nop

case_3:

	or $t0, $s3, $s4
	sw $t0, 0($s1)

beq $0, $0, loop
nop

case_4:

	xor $t0, $s3, $s4
	sw $t0, 0($s1)

beq $0, $0, loop
nop

case_5:

	nor $t0, $s3, $s4
	sw $t0, 0($s1)

beq $0, $0, loop
nop

case_6:

	slt $t0, $s3, $s4
	sw $t0, 0($s1)

beq $0, $0, loop
nop

case_7:

	sltu $t0, $s3, $s4
	sw $t0, 0($s1)

beq $0, $0, loop
nop

.text 0x4180
eret

