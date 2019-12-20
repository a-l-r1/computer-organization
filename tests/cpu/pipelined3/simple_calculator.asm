.text
ori $s0, $0, 0x7f2c # switches base address
ori $s1, $0, 0x7f38 # nixie base address
ori $s2, $0, 0x7f40 # buttons base address

loop:

	lw $s3, 0($t0) # switch group 1
	lw $s4, 4($t0) # switch group 2
	lw $s5, 0($t2) # buttons

	srl $t0, $s5, 7 

beq $0, $0, loop
nop

.text 0x4180
eret

