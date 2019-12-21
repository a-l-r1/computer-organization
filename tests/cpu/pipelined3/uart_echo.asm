.text
nop
nop
nop
nop
nop

li $s0, 0x00001000 # queue head
li $s1, 0x00001000 # queue tail
li $s2, 0x00000020 # transmission ready bitmask
li $s3, 0x00007f10 # uart base
li $s4, 0x00007f34 # led base
li $s5, 0x00007f38 # nixie base
li $s6, 0x00001ffc # bitmask for modular operations

# enable uart irqs
li $t0, 0x0000fc01
mtc0 $t0, $12

loop_begin:
	# turn off led
	li $t0, 0x0
	sw $t0, 0($s4)

	# no element in queue
	beq $s0, $s1, loop_begin
	nop

	# line not ready
	lw $t0, 16($s3)
	and $t0, $t0, $s2
	beq $t0, $0, loop_begin
	nop

	# dequeue
	lw $t0, 0($s1)
	addiu $s1, $s1, 4
	and $s1, $s1, $s6

	# send
	sw $t0, 0($s3)

	# display on nixie
	sw $t0, 0($s5)

beq $0, $0, loop_begin
nop
loop_end:

.text 0x4180
# NOTE: Don't clobber $t0. 

# turn on led
li $t0, 0xffffffff
sw $t0, 0($s4)

# turn off uart irq
sw $0, 8($s3)

# load data
lw $t1, 0($s3)

# enqueue
sw $t1, 0($s0)
addiu $s0, $s0, 4
and $s0, $s0, $s6

eret

