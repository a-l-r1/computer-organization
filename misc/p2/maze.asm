.data
maze: .space 256
vis: .space 256
count: .space 4

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

.macro array_get(%array, %i, %j, %r)
push($t0)

move $t0, %i
sll $t0, $t0, 3
addu $t0, $t0, %j
sll $t0, $t0, 2
lw %r, %array($t0)

pop($t0)
.end_macro

.macro array_set(%array, %i, %j, %r)
push($t0)

move $t0, %i
sll $t0, $t0, 3
addu $t0, $t0, %j
sll $t0, $t0, 2
sw %r, %array($t0)

pop($t0)
.end_macro

.macro add_count()
push($t0)

lw $t0, count($0)
addiu $t0, $t0, 1
sw $t0, count($0)

pop($t0)
.end_macro

.macro read_int(%r)
li $v0, 5
syscall
move %r, $v0
.end_macro

.text
# n: $s0
# m: $s1
# x0: $s2
# y0: $s3
# xf: $s4
# yf: $s5
# i: $s6
# j: $s7

read_int($s0)
read_int($s1)

for_i_0_begin:
li $s6, 0 # for (i = 0; i < n; i++)
for_i_0_loop:
sltu $t0, $s6, $s0
beqz $t0, for_i_0_end
nop

	for_j_0_begin:
	li $s7, 0 # for (j = 0; j < m; j++)
	for_j_0_loop:
	sltu $t0, $s7, $s1
	beqz $t0, for_j_0_end
	nop
	
		# maze[i][j] = __read_int()
		read_int($t1)
		array_set(maze, $s6, $s7, $t1)
	
	addiu $s7, $s7, 1
	b for_j_0_loop
	nop
	for_j_0_end:

addiu $s6, $s6, 1
b for_i_0_loop
nop
for_i_0_end:

read_int($s2)
subiu $s2, $s2, 1 # indices start with 1
read_int($s3)
subiu $s3, $s3, 1
read_int($s4)
subiu $s4, $s4, 1
read_int($s5)
subiu $s5, $s5, 1

move $a0, $s2 # search(x0, y0)
move $a1, $s3
jal search
nop

# __print_int(count)
li $v0, 1
lw $a0, count($0)
syscall

# __exit()
li $v0, 10
syscall

search:
# x: $a0
# y: $a1

save_context()

if_0_begin:
seq $t0, $a0, $s4 # if (x == xf && y == yf)
seq $t1, $a1, $s5
and $t0, $t0, $t1
beqz $t0, if_0_end
nop

	add_count() # count++
	b return
	nop

if_0_end:

# vis[x][y] = 1
li $t1, 1
array_set(vis, $a0, $a1, $t1)

if_1_begin:
sgtu $t1, $a0, $0 # if (x > 0 && maze[x - 1][y] == 0 && vis[x - 1][y] == 0)
beqz $t1, if_1_end # NOTE: underflow
nop
subiu $t1, $a0, 1
array_get(maze, $t1, $a1, $t1)
bnez $t1, if_1_end
nop
subiu $t1, $a0, 1
array_get(vis, $t1, $a1, $t1)
bnez $t1, if_1_end
nop

	push($a0)
	push($a1)
	
	subiu $a0, $a0, 1
	
	jal search # search(x - 1, y)
	nop
	
	pop($a1)
	pop($a0)

if_1_end:

if_2_begin:
subiu $t1, $s0, 1 # if (x < n - 1 && maze[x + 1][y] == 0 && vis[x + 1][y] == 0)
sltu $t1, $a0, $t1
beqz $t1, if_2_end
nop
addiu $t1, $a0, 1
array_get(maze, $t1, $a1, $t1)
bnez $t1, if_2_end
nop
addiu $t1, $a0, 1
array_get(vis, $t1, $a1, $t1)
bnez $t1, if_2_end
nop

	push($a0)
	push($a1)
	
	addiu $a0, $a0, 1
	
	jal search # search(x + 1, y)
	nop
	
	pop($a1)
	pop($a0)

if_2_end:

if_3_begin:
sgtu $t1, $a1, $0 # if (y > 0 && maze[x][y - 1] == 0 && vis[x][y - 1] == 0)
beqz $t1, if_3_end
nop
subiu $t1, $a1, 1
array_get(maze, $a0, $t1, $t1)
bnez $t1, if_3_end
nop
subiu $t1, $a1, 1
array_get(vis, $a0, $t1, $t1)
bnez $t1, if_3_end
nop

	push($a0)
	push($a1)
	
	subiu $a1, $a1, 1
	
	jal search # search(x, y - 1)
	nop
	
	pop($a1)
	pop($a0)

if_3_end:

if_4_begin:
subiu $t1, $s1, 1 # if (y < m - 1 && maze[x][y + 1] == 0 && vis[x][y + 1] == 0)
sltu $t1, $a1, $t1
beqz $t1, if_4_end
nop
addiu $t1, $a1, 1
array_get(maze, $a0, $t1, $t1)
bnez $t1, if_4_end
nop
addiu $t1, $a1, 1
array_get(vis, $a0, $t1, $t1)
bnez $t1, if_4_end
nop

	push($a0)
	push($a1)
	
	addiu $a1, $a1, 1
	
	jal search # search(x, y + 1)
	nop
	
	pop($a1)
	pop($a0)

if_4_end:

# vis[x][y] = 0
array_set(vis, $a0, $a1, $0)

return:
restore_context()
jr $ra
nop
