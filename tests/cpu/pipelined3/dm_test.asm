.text
li $t0, 0x17377017
sw $t0, 0($0)
lw $t1, 0($0)

li $t2, 0x00007f38
sw $t1, 0($t2)

loop:
beq $0, $0, loop
nop

.text 0x4180
eret

