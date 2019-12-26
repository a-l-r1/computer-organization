.text 0x3000
# init cp0
li $t0, 0x00000401
mtc0 $t0, $12

li $s0, 0x00007f00 # timer base address
li $s1, 0x00007f2c # switches base address
li $s2, 0x00007f38 # nixie base address
li $s3, 0x0 # saved switches value

loop:

	# load switches
	lw $t0, 0($s1)

	# if unchanged, just loop
	beq $s3, $t0, loop
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

beq $0, $0, loop
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

beq $0, $0, loop
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

beq $0, $0, loop
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

beq $0, $0, loop
nop

.text 0x4180
# NOTE: Don't clobber $t0. 

# load nixie
lw $t9, 0($s2)

addiu $t9, $t9, 1

li $t8, 10
bne $t9, $t8, handler_end
nop

	li $t9, 0 

handler_end:

# save to nixie
sw $t9, 0($s2)
eret

