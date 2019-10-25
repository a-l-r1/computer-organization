.data
matrix: .space 1024
kernel: .space 1024
result: .space 1024

.macro push(%r)
subiu $sp, $sp, 4
sw %r, 0($sp)
.end_macro

.macro pop(%r)
lw %r, 0($sp)
sw $0, 0($sp)
addiu $sp, $sp, 4
.end_macro

.macro array_get(%array, %i, %j, %r)
push($t0)

move $t0, %i
sll $t0, $t0, 4
addu $t0, $t0, %j
sll $t0, $t0, 2
lw $t0, %array($t0)
move %r, $t0

pop($t0)
.end_macro

.macro array_set(%array, %i, %j, %r)
push($t0)

move $t0, %i
sll $t0, $t0, 4
addu $t0, $t0, %j
sll $t0, $t0, 2
sw %r, %array($t0)

pop($t0)
.end_macro

.macro single(%start_i, %start_j, %r)
# r: $s6
# start_i: $t6
# start_j: $t7
move $t6, %start_i
move $t7, %start_j

push($t0)
push($t1)
push($s4)
push($s5)
push($s6)

li $s6, 0

# for (i = 0; i < m2; i++)
for_i_0_begin:
li $s4, 0
for_i_0_loop:
sltu $t0, $s4, $s2
beqz $t0, for_i_0_end
nop

	# for (j = 0; j < n2; j++)
	for_j_0_begin:
	li $s5, 0
	for_j_0_loop:
	sltu $t0, $s5, $s3
	beqz $t0, for_j_0_end
	nop
	
		# s6 += matrix[start_i + i][start_j + j] * kernel[i][j]
		addu $t0, $t6, $s4
		addu $t1, $t7, $s5
		array_get(matrix, $t0, $t1, $t2)
		array_get(kernel, $s4, $s5, $t3)
		mulu $t0, $t2, $t3
		addu $s6, $s6, $t0
	
	addiu $s5, $s5, 1
	b for_j_0_loop
	nop
	for_j_0_end:

addiu $s4, $s4, 1
b for_i_0_loop
nop
for_i_0_end:

move %r, $s6

pop($s6)
pop($s5)
pop($s4)
pop($t1)
pop($t0)
.end_macro

.macro read_matrix(%matrix, %rows, %columns)
push($t0)
push($t1)
push($s4)
push($s5)

# for (i = 0; i < rows; i++)
for_i_1_begin:
li $s4, 0
for_i_1_loop:
sltu $t0, $s4, %rows
beqz $t0, for_i_1_end
nop

	# for (j = 0; j < rows; j++)
	for_j_1_begin:
	li $s5, 0
	for_j_1_loop:
	sltu $t0, $s5, %columns
	beqz $t0, for_j_1_end
	nop
	
		# matrix[i][j] = __read_int()
		li $v0, 5
		syscall
		array_set(%matrix, $s4, $s5, $v0)
	
	addiu $s5, $s5, 1
	b for_j_1_loop
	nop
	for_j_1_end:

addiu $s4, $s4, 1
b for_i_1_loop
nop
for_i_1_end:

pop($s4)
pop($s5)
pop($t1)
pop($t0)
.end_macro

.macro read_int(%r)
li $v0, 5
syscall
move %r, $v0
.end_macro

.text
# m1: $s0
# n1: $s1
# m2: $s2
# n2: $s3
# i: $s4
# j: $s5
# curr_result: $s7

read_int($s0)
read_int($s1)
read_int($s2)
read_int($s3)

read_matrix(matrix, $s0, $s1)
read_matrix(kernel, $s2, $s3)

# for (i = 0; i < m1 - m2 + 1; i++)
for_i_1_begin:
li $s4, 0
for_i_1_loop:
subu $t0, $s0, $s2
addiu $t0, $t0, 1
sltu $t0, $s4, $t0
beqz $t0, for_i_1_end
nop

	# for (j = 0; j < n1 - n2 + 1; j++)
	for_j_1_begin:
	li $s5, 0
	for_j_1_loop:
	subu $t0, $s1, $s3
	addiu $t0, $t0, 1
	sltu $t0, $s5, $t0
	beqz $t0, for_j_1_end
	nop
	
		# curr_result = single(i, j, $s7)
		single($s4, $s5, $s7)
		
		# printf("%d ", curr_result)
		li $v0, 1
		move $a0, $s7
		syscall
		li $v0, 11
		li $a0, 32
		syscall
	
	addiu $s5, $s5, 1
	b for_j_1_loop
	nop
	for_j_1_end:
	
	li $v0, 11
	li $a0, 10
	syscall

addiu $s4, $s4, 1
b for_i_1_loop
nop
for_i_1_end:
