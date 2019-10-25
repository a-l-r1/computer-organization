.data
symbol: .space 32
array: .space 32

.macro array_get(%base, %i, %r)
move $t0, %i
sll $t0, $t0, 2
lw %r, %base($t0)
.end_macro

.macro array_set(%base, %i, %r)
move $t0, %i
sll $t0, $t0, 2
sw %r, %base($t0)
.end_macro

.macro push(%r)
subiu $sp, $sp, 4
sw %r, 0($sp)
.end_macro

.macro pop(%r)
lw %r, 0($sp)
sw $0, 0($sp)
addiu $sp, $sp, 4
.end_macro

.macro save_context()
push($ra)
push($a0)
push($a1)
push($a2)
push($a3)
push($s0)
push($s1)
push($s2)
push($s3)
push($s4)
push($s5)
push($s6)
push($s7)
.end_macro

.macro restore_context()
pop($s7)
pop($s6)
pop($s5)
pop($s4)
pop($s3)
pop($s2)
pop($s1)
pop($s0)
pop($a3)
pop($a2)
pop($a1)
pop($a0)
pop($ra)
.end_macro

.text
# n: $s0
# i: $s1

# n = __read_int()
li $v0, 5
syscall
move $s0, $v0

li $a0, 0
jal fullarrangement
nop

li $v0, 10
syscall

fullarrangement:
save_context()
# if (index >= n)
if_0_begin:
sgeu $t1, $a0, $s0
beqz $t1, if_0_end
nop

	# for (i = 0; i < n; i++)
	for_0_begin:
	li $s1, 0
	for_0_loop:
	sltu $t0, $s1, $s0
	beqz $t0, for_0_end
	nop
	
		push($a0)
		
		# printf("%d ", array[i])
		array_get(array, $s1, $t1)
		li $v0, 1
		move $a0, $t1
		syscall
		li $v0, 11
		li $a0, 32 # space
		syscall
		
		pop($a0)
	
	addiu $s1, $s1, 1
	b for_0_loop
	nop
	for_0_end:
	
	push($a0)
	
	# printf("\n")
	li $v0, 11
	li $a0, 10
	syscall
	
	pop($a0)
	
	# return
	b return
	nop
if_0_end:

# for (i = 0; i < n; i++)
for_1_begin:
li $s1, 0
for_1_loop:
sltu $t0, $s1, $s0
beqz $t0, for_1_end

	# if (symbol[i] == 0)
	if_1_begin:
	array_get(symbol, $s1, $t1)
	bnez $t1, if_1_end
	nop
	
		# array[index] = i + 1
		addiu $t1, $s1, 1
		array_set(array, $a0, $t1)
		
		# symbol[i] = 1
		li $t1, 1
		array_set(symbol, $s1, $t1)
		
		# fullarrangement(index + 1)
		addiu $a0, $a0, 1
		jal fullarrangement
		nop
		subiu $a0, $a0, 1
		
		# symbol[i] = 0
		array_set(symbol, $s1, $0)
	if_1_end:

addiu $s1, $s1, 1
b for_1_loop
nop
for_1_end:

return:
restore_context()
jr $ra
nop
