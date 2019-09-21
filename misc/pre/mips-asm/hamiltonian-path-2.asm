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
	# %ans = (%i * 16 + %j) * 4
	sll %ans, %i, 4
	add %ans, %ans, %j
	sll %ans, %ans, 2
.end_macro

.data
visv: .space 64
e: .space 1024
vise: .space 1024
n: .word 0
m: .word 0
cr: .asciiz "\n"

.text
main: 
li $v0, 5
syscall
sw $v0, n($0)

li $v0, 5
syscall
sw $v0, m($0)

lw $t0, n($0)
beq $t0, 2, two_nodes
nop

# for (i = 0; i < m; i++)
move $s0, $0
i_loop_0: 
lw $t0, m($0)
bge $s0, $t0, i_loop_0_out
nop
	
	# indices start with 1
	li $v0, 5
	syscall
	subi $v0, $v0, 1
	move $t1, $v0
	
	li $v0, 5
	syscall
	subi $v0, $v0, 1
	move $t2, $v0
	
	# if ($t1 == $t2) continue;
	beq $t1, $t2, i_loop_0_continue
	nop
	
	# $t4 = 1
	li $t4, 1
	
	# e[$t1][$t2] = e[$t2][$t1] = $t4
	getindex($t3, $t1, $t2)
	sw $t4, e($t3)
	getindex($t3, $t2, $t1)
	sw $t4, e($t3)

i_loop_0_continue: 

addi $s0, $s0, 1
j i_loop_0
nop
i_loop_0_out: 

# for breakpoint
nop

# if (n == 0 || n == 1) goto success;
lw $t0, n($0)
beq $t0, 0, success
nop
beq $t0, 1, success
nop
# n == 2 considered

# visv[0] = 1
# hamiltonian(0)
li $t1, 1
sw $t1, visv($0)

li $a0, 0
jal hamiltonian
nop

fail: 
# printf("0\n"); exit(0)
li $a0, 0
li $v0, 1
syscall

la $a0, cr
li $v0, 4
syscall

li $v0, 10
syscall

success:
# printf("1"); exit(0)
li $a0, 1
li $v0, 1
syscall

la $a0, cr
li $v0, 4
syscall

li $v0, 10
syscall

two_nodes: 
# for (i = 0; i < m; i++)
move $s0, $0
i_loop_1: 
lw $t0, m($0)
bge $s0, $t0, i_loop_1_out
nop
	
	# indices start with 1
	li $v0, 5
	syscall
	subi $v0, $v0, 1
	move $t1, $v0
	
	li $v0, 5
	syscall
	subi $v0, $v0, 1
	move $t2, $v0
	
	# if ($t1 == $t2) continue;
	beq $t1, $t2, i_loop_1_continue
	nop
	
	# e[$t1][$t2]++, e[$t2][$t1]++
	getindex($t3, $t1, $t2)
	lw $t4, e($t3)
	addi $t4, $t4, 1
	sw $t4, e($t3)
	
	getindex($t3, $t2, $t1)
	lw $t4, e($t3)
	addi $t4, $t4, 1
	sw $t4, e($t3)

i_loop_1_continue: 

addi $s0, $s0, 1
j i_loop_1
nop
i_loop_1_out: 

# if e[0][1] > 0 goto success;
li $t0, 0
li $t1, 1
getindex($t2, $t0, $t1)
lw $t2, e($t2)

bgt $t2, $0, success
nop

# else goto fail;
j fail
nop

hamiltonian: 
save_regs()

# for (i = 0; i < n; i++)
li $s0, 0
i_loop_2: 
lw $t0, n($0)
bge $s0, $t0, i_loop_2_out
nop

	# if (visv[i] == 0) goto find;
	# NOTE: the addresses must be at word boundary
	move $t0, $s0
	sll $t0, $t0, 2
	lw $t0, visv($t0)
	beq $t0, $0, find
	nop

addi $s0, $s0, 1
j i_loop_2
nop
i_loop_2_out: 
# if (e[curr][0] == 1 && vise[curr][0] == 0)
getindex($t0, $a0, $0)
lw $t0, e($t0)
seq $t0, $t0, 1

getindex($t1, $a0, $0)
lw $t1, vise($t1)
seq $t1, $t1, 0

and $t0, $t0, $t1

# else goto find;
beq $t0, $0, find
nop

b success
nop

find: 
# make arguments permanent
move $s1, $a0

# for (i = 1; i < n; i++)
li $s0, 1
i_loop_3: 
lw $t0, n($0)
bge $s0, $t0, i_loop_3_out
nop

	# if (i == curr) continue;
	beq $s0, $s1, i_loop_3_continue
	nop

	# if (e[curr][i] == 1 && visv[i] == 0)
	getindex($t0, $s1, $s0)
	lw $t0, e($t0)
	seq $t0, $t0, 1

	sll $t1, $s0, 2
	lw $t1, visv($t1)
	seq $t1, $t1, 0

	and $t0, $t0, $t1

	# else { continue; }
	beq $t0, $0, i_loop_3_continue
	nop

	# vise[curr][i] = 1;
	# vise[i][curr] = 1;
	# visv[i] = 1;
	li $t1, 1

	getindex($t0, $s1, $s0)
	sw $t1, vise($t0)

	getindex($t0, $s0, $s1)
	sw $t1, vise($t0)
                                                                                                 
	sll $t0, $s0, 2
	sw $t1, visv($t0)
	
	# hamiltonian(i);
	move $a0, $s0
	jal hamiltonian
	nop
	
	# visv[i] = 0;
	# vise[i][curr] = 0;
	# vise[curr][i] = 0;
	li $t1, 0
	
	getindex($t0, $s1, $s0)
	sw $t1, vise($t0)
	
	getindex($t0, $s0, $s1)
	sw $t1, vise($t0)
	
	sll $t0, $s0, 2
	sw $t1, visv($t0)

i_loop_3_continue: 

addi $s0, $s0, 1
j i_loop_3
nop
i_loop_3_out:

restore_regs()
jr $ra
nop

# void hamiltonian(int curr)
# {
# 	int i;
# 	for (i = 0; i < n; i++)
# 	{
# 		if (visv[i] == 0)
# 		{
# 			goto find;
# 		}
# 	}
# 	if (e[curr][0] == 1 && vise[curr][0] == 0)
# 	{
# 		printf("1\n");
# 		exit(0);
# 	}
# 
# find: 
# 	for (i = 0; i < n; i++)
# 	{
# 		if (e[curr][i] == 1 && visv[i] == 0)
# 		{
# 			vise[curr][i] = 1;
# 			vise[i][curr] = 1;
# 			visv[i] = 1;
# 			hamiltonian(i);
# 			visv[i] = 0;
# 			vise[i][curr] = 0;
# 			vise[curr][i] = 0;
# 		}
# 	}
# }
# 
