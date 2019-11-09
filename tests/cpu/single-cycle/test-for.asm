for_0_begin:
lui $t0, 0
ori $t0, 0xff0
lui $t1, 0
ori $t1, 0x1000
lui $t2, 0
ori $t2, 4
lui $t4, 0xffff
ori $t4, 0xffff
for_0_loop:
slt $t3, $t0, $t1
beq $t3, $0, for_0_end

	sw $t4, 0($t0)
	lw $t4, 0($t0)

addu $t0, $t0, $t2
beq $0, $0, for_0_loop
for_0_end:

