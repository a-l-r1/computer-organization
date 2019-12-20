.text
lui $s0, 0x0000 # uart base
ori $s0, 0x7f10

loop:

	# bitmask
	lui $t0, 0x0000
	ori $t0, 0x0020

	# bogos
	lui $t1, 0x00ff
	ori $t1, 0xffff
	loop1:
	subiu $t1, $t1, 1
	bne $t1, $0, loop1
	nop

	# line not ready
	lw $t0, 16($s0)
	and $t0, $t0, $s2
	beq $t0, $0, loop
	nop

	# send
	lui $t0, 0x0000
	ori $t0, 0x0031
	sw $t0, 0($s0)
	

beq $0, $0, loop
nop

.text 0x4180
eret

