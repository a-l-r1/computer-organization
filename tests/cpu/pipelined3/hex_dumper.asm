.text 0x00003000
li $s0, 0x00007f40 # buttons base address
li $s1, 0x00007f2c # switches base address
li $s2, 0x00007f38 # nixie base address
li $s3, 0x00007f10 # uart base address
li $s4, 0x0 # i in for loops
li $s5, 0x0 # end flag
li $s6, 0x0 # temporary value

loop:

	lw $t0, 0($s0)
	
	# if (__buttons == 0)
	if_0_begin:
	bne $t0, $0, if_0_else
	nop

		# end = 0
		li $s5, 0x0

		# goto loop
		beq $0, $0, loop
		nop

	beq $0, $0, if_0_end
	nop

	if_0_else:

		# if (end == 1) goto loop
		bne $s5, $0, loop
		nop

	if_0_end:

	do_hex_dump:
	
	# get the lower switch pack
	lw $s6, 4($s1)

	# send to nixie
	sw $s6, 0($s2)

	# save bytes to memory (from the least significant byte upwards)
	andi $t0, $s6, 0xf
	sw $t0, 0($0)
	srl $s6, $s6, 4

	andi $t0, $s6, 0xf
	sw $t0, 4($0)
	srl $s6, $s6, 4

	andi $t0, $s6, 0xf
	sw $t0, 8($0)
	srl $s6, $s6, 4

	andi $t0, $s6, 0xf
	sw $t0, 12($0)
	srl $s6, $s6, 4

	andi $t0, $s6, 0xf
	sw $t0, 16($0)
	srl $s6, $s6, 4

	andi $t0, $s6, 0xf
	sw $t0, 20($0)
	srl $s6, $s6, 4

	andi $t0, $s6, 0xf
	sw $t0, 24($0)
	srl $s6, $s6, 4

	andi $t0, $s6, 0xf
	sw $t0, 28($0)
	srl $s6, $s6, 4

	# for (i = 28; i >= 0; i -= 4)
	for_0_begin:
	li $s4, 28	
	for_0_loop:
	# NOTE: signed
	slt $t0, $s4, $0
	bne $t0, $0, for_0_end
	nop

		wait_for_uart:

		# lsr
		lw $t0, 16($s3)

		# ts bit
		srl $t0, $t0, 5
		andi $t0, $t0, 0x1

		# if (ts == 0) goto wait_for_uart
		beq $t0, $0, wait_for_uart
		nop

		# load byte
		lw $t0, 0($s4)

		# if (byte < 10) byte += 48; else byte += 55;
		# NOTE: unsigned
		if_1_begin:
		sltiu $t1, $t0, 10
		beq $t1, $0, if_1_else
		nop

			addiu $t0, $t0, 48

		beq $0, $0, if_1_end
		nop
		if_1_else:

			addiu $t0, $t0, 55

		if_1_end:

		# send byte
		sw $t0, 0($s3)

	subiu $s4, $s4, 4
	beq $0, $0, for_0_loop
	nop
	for_0_end:

	# end = 1
	li $s5, 0x1

beq $0, $0, loop
nop

.text 0x00004180
eret

