.data
str: .space 32

.text
# n: $s0
# i: $s1
# j: $s2
# is_palindrome: $s3

# read n
li $v0, 5
syscall
move $s0, $v0

# for (i = 0; i < n; i++)
for_0_begin:
li $s1, 0
for_0_loop:
sltu $t0, $s1, $s0
beq $t0, 0, for_0_end
nop

	# str[i] = __read_char()
	li $v0, 12
	syscall
	sb $v0, str($s1)

addiu $s1, $s1, 1
b for_0_loop
nop
for_0_end:

# for (i = 0, j = n - 1; i < j && str[i] == str[j]; i++, j--)
for_1_begin:
li $s1, 0
subiu $s2, $s0, 1
for_1_loop:
sltu $t0, $s1, $s2
lbu $t1, str($s1)
lbu $t2, str($s2)
seq $t1, $t1, $t2
and $t0, $t0, $t1
beq $t0, 0, for_1_end
nop

addiu $s1, $s1, 1
subiu $s2, $s2, 1
b for_1_loop
nop
for_1_end:

# is_palindrome = (i >= j)
sgeu $s3, $s1, $s2

# __print_int($s3)
move $a0, $s3
li $v0, 1
syscall

# __exit()
li $v0, 10
syscall