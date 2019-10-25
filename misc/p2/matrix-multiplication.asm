.data
m1: .space 256
m2: .space 256
result: .space 256

.macro get_addr(%base, %i, %j, %r)
# index = base + ((i * 8) + j) * 4
move $t0, %i
sll $t0, $t0, 3
addu $t0, $t0, %j
sll $t0, $t0, 2
la $t1, %base
addu $t0, $t0, $t1
move %r, $t0
.end_macro

.macro read_matrix(%matrix)
# for (i = 0; i < n; i++)
for_i_0_begin:
li $s1, 0
for_i_0_loop:
sltu $t0, $s1, $s0
beq $t0, 0, for_i_0_end
nop

	# for (j = 0; j < n; j++)
	for_j_0_begin:
	li $s2, 0
	for_j_0_loop:
	sltu $t0, $s2, $s0
	beq $t0, 0, for_j_0_end
	nop
	
		# m1[i][j] = __read_int()
		li $v0, 5
		syscall
		get_addr(%matrix, $s1, $s2, $t0)
		sw $v0, 0($t0)
	
	addiu $s2, $s2, 1
	b for_j_0_loop
	nop
	for_j_0_end:

addiu $s1, $s1, 1
b for_i_0_loop
nop
for_i_0_end:
.end_macro

.text
# n: $s0
# i: $s1
# j: $s2
# k: $s3
# curr_value: $s4

# n = __read_int()
li $v0, 5
syscall
move $s0, $v0

li $s1, 0
li $s2, 0
read_matrix(m1)

li $s1, 0
li $s2, 0
read_matrix(m2)

# for (i = 0; i < n; i++)
for_i_1_begin:
li $s1, 0
for_i_1_loop:
sltu $t0, $s1, $s0
beq $t0, 0, for_i_1_end
nop

	# for (j = 0; j < n; j++)
	for_j_1_begin:
	li $s2, 0
	for_j_1_loop:
	sltu $t0, $s2, $s0
	beq $t0, 0, for_j_1_end
	nop
	
		# curr_value = 0
		li $s4, 0
		
		# for (k = 0; k < n; k++)
		for_k_0_begin:
		li $s3, 0
		for_k_0_loop:
		sltu $t0, $s3, $s0
		beq $t0, 0, for_k_0_end
		nop
		
			# curr_value += m1[i][k] * m2[k][j]
			get_addr(m1, $s1, $s3, $t2)
			get_addr(m2, $s3, $s2, $t3)
			lw $t2, 0($t2)
			lw $t3, 0($t3)
			mulu $t2, $t2, $t3
			addu $s4, $s4, $t2
		
		addiu $s3, $s3, 1
		b for_k_0_loop
		nop
		for_k_0_end:
		
		# result[i][j] = curr_value
		get_addr(result, $s1, $s2, $t0)
		sw $s4, 0($t0)
	
	addiu $s2, $s2, 1
	b for_j_1_loop
	nop
	for_j_1_end:

addiu $s1, $s1, 1
b for_i_1_loop
nop
for_i_1_end:

# output routine
# for (i = 0; i < n; i++)
for_i_2_begin:
li $s1, 0
for_i_2_loop:
sltu $t0, $s1, $s0
beq $t0, 0, for_i_2_end
nop

	# for (j = 0; j < n; j++)
	for_j_2_begin:
	li $s2, 0
	for_j_2_loop:
	sltu $t0, $s2, $s0
	beq $t0, 0, for_j_2_end
	nop
	
		# printf("%d ", result[i][j])
		get_addr(result, $s1, $s2, $t2)
		lw $t2, 0($t2)
		move $a0, $t2
		li $v0, 1
		syscall
		li $v0, 11
		li $a0, 32 # space
		syscall
	
	addiu $s2, $s2, 1
	b for_j_2_loop
	nop
	for_j_2_end:
	
	# printf("\n")
	li $v0, 11
	li $a0, 10
	syscall

addiu $s1, $s1, 1
b for_i_2_loop
nop
for_i_2_end:

# __exit()
li $v0, 10
syscall
