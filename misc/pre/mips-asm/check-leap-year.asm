li $v0, 5
syscall
move $s0, $v0 # $s0 = year
# if (((year % 4) == 0 && (year % 100 != 0)) || (year % 400 == 0))

div $s1, $s0, 4
mfhi $s1 # s1 = year % 4
seq $s2, $s1, $0 # s2 = (year % 4 == 0)

div $s1, $s0, 100
mfhi $s1 # s1 = year % 100
seq $s3, $s1, $0 # s3 = (year % 100 == 0)
xori $s3, $s3, 1 # s3 = (year % 100 != 0)

div $s1, $s0, 400
mfhi $s1 # s4 = year % 400
seq $s4, $s1, $0 # s4 = (year % 400 == 0)

and $s1, $s2, $s3 # $s1 = $s2 & $s3
or $s1, $s1, $s4 # $s1 = ($s2 & $s3) | $s4

move $a0, $s1
li $v0, 1
syscall

li $v0, 1
syscall

li $v0, 10
syscall
