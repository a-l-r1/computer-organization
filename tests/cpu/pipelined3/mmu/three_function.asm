# memory layout
# code     paddr                    vaddr
# init     0xbfc03000-0xbfc03ffc    0xbfc03000-0xbfc03ffc
# isr      0xbfc04180-0xbfc04ffc    0xbfc04180-0xbfc04ffc
# dm       0x00000000-0x00001ffc    0x00000000-0x00001ffc
# prog0    0x00005000-0x00005ffc    0x00003000-0x00003ffc
# prog1    0x00006000-0x00006ffc    0x00003000-0x00003ffc

# cp0 related registers
# id    name
# 0     index
# 2     entrylo0
# 3     entrylo1
# 10    entryhi

# init
.text 0xbfc03000
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
ori $t0, 0x0047 # pfn = 0x00001, d = 1, v = 1, g = 1
mtc0 $t0, $3 # entrylo1

# commit
tlbwi

# fill prog0 
# target tlb[1]
lui $t0, 0x0000
ori $t0, 0x0001 # p = 0, index = 1
mtc0 $t0, $0 # index

lui $t0, 0x0000
ori $t0, 0x0100 # vpn = 0x1, asid = 0
mtc0 $t0, $10 # entryhi

# 0x00002 -> (none)
lui $t0, 0x0000
ori $t0, 0x0001 # pfn = 0x00000, d = 0, v = 0, g = 1
mtc0 $t0, $2 # entrylo0

# 0x00003 -> 0x00002
lui $t0, 0x0000
ori $t0, 0x0083 # pfn = 0x00002, d = 0, v = 1, g = 1
mtc0 $t0, $3 # entrylo1

# commit
tlbwi

# enable interrupts on buttons and timers
lui $t0, 0x0000
ori $t0, 0x8401
mtc0 $t0, $12

# below: interactive_storage.asm
li $s0, 0xbfc07f40 # buttons base address
li $s1, 0xbfc07f2c # switches base address
li $s2, 0xbfc07f38 # nixie base address
li $s3, 0x0 # saved buttons value
li $s4, 0x0 # saved address
li $s5, 0x0 # saved value

loop_a:

	# load buttons
	# NOTE: Would get a interrupt and then return. 
	lw $s3, 0($s0)

	li $t0, 8
	beq $s3, $t0, write
	nop

	li $t0, 16
	beq $s3, $t0, read
	nop

beq $0, $0, loop_a
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
	beq $t0, $0, loop_a
	nop

	# check if word-aligned
	andi $t0, $s4, 0x3
	bne $t0, $0, loop_a
	nop

	# save
	sw $s5, 0($s4)

	# write to nixie
	sw $s5, 0($s2)

beq $0, $0, loop_a
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
	beq $t0, $0, loop_a
	nop

	# check if word-aligned
	andi $t0, $s4, 0x3
	bne $t0, $0, loop_a
	nop

	# load
	lw $t0, 0($s4)

	# write to nixie
	sw $t0, 0($s2)

beq $0, $0, loop_a
nop

# prog0
.text 0xbfc02000

# below: tunable_timer.asm
li $s0, 0xbfc07f00 # timer base address
li $s1, 0xbfc07f2c # switches base address
li $s2, 0xbfc07f38 # nixie base address
li $s3, 0x0 # saved switches value

loop_b:

	# load switches
	lw $t0, 0($s1)

	# if unchanged, just loop
	beq $s3, $t0, loop_b
	nop

	# else update saved switches
	addu $s3, $0, $t0

	beq $s3, $0, zero
	nop

	li $t0, 1
	beq $s3, $t0, one
	nop

	beq $0, $0, two
	nop

beq $0, $0, loop_b
nop

zero:
# disable timer
sw $0, 0($s0)

# wait for disabling
nop
nop
nop

# write to nixie
sw $0, 0($s2)

beq $0, $0, loop_b
nop

one:
# disable timer
sw $0, 0($s0)

# wait for disabling
nop
nop
nop

# enable timer
li $t0, 30000000
sw $t0, 4($s0)

li $t0, 0x000b # allow_irq = 1, mode = 2'b01, enable = 1
sw $t0, 0($s0)

beq $0, $0, loop_b
nop

two:
# disable timer
sw $0, 0($s0)

# wait for disabling
nop
nop
nop

# enable timer (2s per tick)
li $t0, 60000000
sw $t0, 4($s0)

li $t0, 0x000b # allow_irq = 1, mode = 2'b10, enable = 1
sw $t0, 0($s0)

beq $0, $0, loop_b
nop

# prog1
.text 0xbfc05000

# below: hex_dumper.asm
li $s0, 0xbfc07f40 # buttons base address
li $s1, 0xbfc07f2c # switches base address
li $s2, 0xbfc07f38 # nixie base address
li $s3, 0xbfc07f10 # uart base address
li $s4, 0x0 # i in for loops
li $s5, 0x0 # end flag
li $s6, 0x0 # temporary value

loop_c:

	# load buttons
	lw $t0, 0($s1)

	# if (__buttons == 0)
	if_0_begin:
	bne $t0, $0, if_0_else
	nop

		# end = 0
		li $s5, 0x0

		# goto loop_c
		beq $0, $0, loop_c
		nop

	beq $0, $0, if_0_end
	nop

	if_0_else:

		# if (end == 1) goto loop_c
		bne $s5, $0, loop_c
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

beq $0, $0, loop_c
nop

# isr
.text 0xbfc04180
# NOTE: Don't clobber $t0 and $t1. Use $t8 and $t9 instead. 

# disable the interrupt of buttons
lui $t8, 0xbfc0
ori $t8, 0x7f40 # buttons
sw $0, 0($t8)

# disable timer
lui $t8, 0xbfc0
ori $t8, 0x7f00 # timer
sw $0, 0($t8)

# wait for disabling
nop
nop
nop

# clear nixie
lui $t8, 0xbfc0
ori $t8, 0x7f38 # nixie
sw $0, 0($t8)

# get cause
mfc0 $t8, $13
srl $t8, $t8, 10
andi $t8, $t8, 0x1

# if not timer
beq $t8, $0, handle_buttons
nop

	# handling timer
	handle_timer:

	# load nixie
	lui $t8, 0xbfc0
	ori $t8, 0x7f38 # nixie
	lw $t9, 0($t8)

	addiu $t9, $t9, 1

	li $t8, 10
	bne $t9, $t8, handle_timer_end
	nop

		li $t9, 0 

	handle_timer_end:

	# save to nixie
	lui $t8, 0xbfc0
	ori $t8, 0x7f38 # nixie
	sw $t9, 0($t8)
	eret

handle_buttons:

# read buttons
lui $t8, 0xbfc0
ori $t8, 0x7f40 # buttons
lw $t9, 0($t8)

li $t8, 1
beq $t9, $t8, to_init
nop

li $t8, 2
beq $t9, $t8, to_prog0
nop

li $t8, 4
beq $t9, $t8, to_prog1
nop

eret
nop

to_init:

# fill init
# target tlb[1]
lui $t8, 0x0000
ori $t8, 0x0001 # p = 0, index = 1
mtc0 $t8, $0 # index

lui $t8, 0x0000
ori $t8, 0x0100 # vpn = 0x1, asid = 0
mtc0 $t8, $10 # entryhi

# 0x00002 -> (none)
lui $t8, 0x0000
ori $t8, 0x0001 # pfn = 0x00000, d = 0, v = 0, g = 1
mtc0 $t8, $2 # entrylo0

# 0x00003 -> 0x00003
lui $t8, 0x0000
ori $t8, 0x00c3 # pfn = 0x00003, d = 0, v = 1, g = 1
mtc0 $t8, $3 # entrylo1

# commit
tlbwi

li $t8, 0x00003000
mtc0 $t8, $14
eret
nop

to_prog0:

# fill prog0 
# target tlb[1]
lui $t8, 0x0000
ori $t8, 0x0001 # p = 0, index = 1
mtc0 $t8, $0 # index

lui $t8, 0x0000
ori $t8, 0x0100 # vpn = 0x1, asid = 0
mtc0 $t8, $10 # entryhi

# 0x00002 -> (none)
lui $t8, 0x0000
ori $t8, 0x0001 # pfn = 0x00000, d = 0, v = 0, g = 1
mtc0 $t8, $2 # entrylo0

# 0x00003 -> 0x00002
lui $t8, 0x0000
ori $t8, 0x0083 # pfn = 0x00002, d = 0, v = 1, g = 1
mtc0 $t8, $3 # entrylo1

# commit
tlbwi

li $t8, 0x00003000
mtc0 $t8, $14
eret
nop

to_prog1:

# fill prog1 
# target tlb[1]
lui $t8, 0x0000
ori $t8, 0x0001 # p = 0, index = 1
mtc0 $t8, $0 # index

lui $t8, 0x0000
ori $t8, 0x0100 # vpn = 0x1, asid = 0
mtc0 $t8, $10 # entryhi

# 0x00002 -> (none)
lui $t8, 0x0000
ori $t8, 0x0001 # pfn = 0x00000, d = 0, v = 0, g = 1
mtc0 $t8, $2 # entrylo0

# 0x00003 -> 0x00005
lui $t8, 0x0000
ori $t8, 0x0143 # pfn = 0x00005, d = 0, v = 1, g = 1
mtc0 $t8, $3 # entrylo1

# commit
tlbwi

li $t8, 0x00003000
mtc0 $t8, $14
eret
nop

