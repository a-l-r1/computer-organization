.macro getindex(%ans, %i, %j)
	# %ans = (%i * m + %j) * 4
	mult %i, $s1
	mflo %ans
	add %ans, %ans, %j
	sll %ans, %ans, 2
.end_macro

.data
matrix: .space 10000
space: .asciiz " "
cr: .asciiz "\n"

.text
# $s0: row count of matrix (n)
# $s1: column count of matrix (m)
li $v0, 5
syscall
move $s0, $v0

li $v0, 5
syscall
move $s1, $v0

# $t0: register for conditional testing
# $t1: i
# $t2: j
# $t3: index
# for (i = 0; i < n; i++)
move $t1, $0
i_for_0: 
# $t0 = (i < n)
slt $t0, $t1, $s0
beq $t0, $0, i_for_0_out
nop

	# for (j = 0; j < m; j++)
	move $t2, $0
	j_for_0: 
	# $t0 = (j < m)
	slt $t0, $t2, $s1
	beq $t0, $0, j_for_0_out
	nop
	
		getindex($t3, $t1, $t2)
		li $v0, 5
		syscall
		sw $v0, matrix($t3)
	
	addi $t2, $t2, 1
	j j_for_0
	nop
	j_for_0_out: 

addi $t1, $t1, 1
j i_for_0
nop
i_for_0_out:

# t4: current integer
# for (i = n - 1; i >= 0; i--)
sub $t1, $s0, 1
i_for_1: 
sge $t0, $t1, $0
beq $t0, $0, i_for_1_out
nop

	# for (j = m - 1: j >= 0; j--)
	sub $t2, $s1, 1
	j_for_1: 
	sge $t0, $t2, $0
	beq $t0, $0, j_for_1_out
	nop
	
		getindex($t3, $t1, $t2)
		lw $t4, matrix($t3)
		
		# if ((unsigned int)curr_int > 0)
		sgtu $t0, $t4, $0
		beq $t0, $0, curr_else
		nop
		
		addi $a0, $t1, 1
		li $v0, 1
		syscall
		
		la $a0, space
		li $v0, 4
		syscall
		
		addi $a0, $t2, 1
		li $v0, 1
		syscall
		
		la $a0, space
		li $v0, 4
		syscall
		
		move $a0, $t4
		li $v0, 1
		syscall
		
		la $a0, cr
		li $v0, 4
		syscall
		
		curr_else:
	
	subiu $t2, $t2, 1
	j j_for_1
	nop
	j_for_1_out: 

subiu $t1, $t1, 1
j i_for_1
nop
i_for_1_out:

li $v0, 10
syscall
