.text
nop
nop
nop
nop
nop

li $s0, 0x00007f00 # timer base
li $s1, 0x00007f2c # switches base
li $s2, 0x00007f38 # nixie base

li $t0, 0x00000401
mtc0 $t0, $12

reload:

# disable timer and wait for it to return idle
sw $0, 0($s0)
nop
nop
nop

# load switches
lw $s3, 4($s1)

# save 30M to preset
li $t0, 30000000
sw $t0, 4($s0)

# save to nixie
sw $s3, 0($s2)

# enable timer (mode == 2'b01)
li $t0, 0x0000000b
sw $t0, 0($s0)

loop:

	# check if switch value has changed
	lw $t0, 4($s1)
	bne $t0, $s3, reload
	nop

beq $0, $0, loop
nop

.text 0x4180
# NOTE: Don't clobber $t0.

# decrease timer if non-zero
lw $t1, 0($s2)
beq $t1, $0, decrease_end
nop
subiu $t1, $t1, 1
sw $t1, 0($s2)

decrease_end:

eret

