.text
nop
nop
nop
nop
nop

lui $t0, 0x00c0
ori $t0, 0xffee

sb $t0, 0($0)
sb $t0, 1($0)
sb $t0, 2($0)
sb $t0, 3($0)

sh $t0, 0($0)
sh $t0, 2($0)

sw $t0, 0($0)

loop:
beq $0, $0, loop
nop

.text 0x4180
eret

