.macro push(%r)
	subi $sp, $sp, 4
	sw %r, 0($sp)
.end_macro

.macro pop(%r)
	lw %r, 0($sp)
	addi $sp, $sp, 4
.end_macro

.macro save_regs()
	push($ra)
	push($s0)
	push($s1)
	push($s2)
.end_macro

.macro restore_regs()
	pop($s2)
	pop($s1)
	pop($s0)
	pop($ra)
.end_macro

.macro getindex(%ans, %i, %j)
	# %ans = (%i * 8 + %j) * 4
	sll %ans, %i, 3
	add %ans, %ans, %j
	sll %ans, %ans, 2
.end_macro

.data
visv: .space 32
e: .space 256
vise: .space 256
n: .word 0
m: .word 0
space: .asciiz " "

.text
main: 
li $v0, 5
syscall
sw $v0, n($0)

move $a0, $v0
li $v0, 1
syscall

li $v0, 5
syscall
sw $v0, m($0)

move $a0, $v0
li $v0, 1
syscall

# for (i = 0; i < m; i++)
move $s0, $0
i_loop_0: 
lw $t0, m($0)
slt $t0, $s0, $t0
beq $t0, $0, i_loop_0_out
nop
	
	# indices start with 1
	li $v0, 5
	syscall
	move $t1, $v0
	
	li $v0, 5
	syscall
	move $t2, $v0
	
	move $a0, $t1
	li $v0, 1
	syscall
	
	la $a0, space
	li $v0, 4
	syscall
	
	move $a0, $t2
	li $v0, 1
	syscall
	
	la $a0, space
	li $v0, 4
	syscall

addi $s0, $s0, 1
j i_loop_0
nop
i_loop_0_out: 

li $v0, 10
syscall
