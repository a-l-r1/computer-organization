# NOTE: This file is not supposed to be run by MARS. 

.text
lui $1, 0x8000
ori $1, 0x0000
lui $2, 0x8000
ori $2, 0x0000
ori $3, 0x7f00
ori $4, 0x7f10
ori $5, 0x0005

# enable all hardware interrupts
ori $8, 0xfc01
mtc0 $8, $12

# allow_irq = 1, mode = 1, enable = 0
ori $6, 0x000a
sw $6, 0($3)

#save the preset of timer0 and load it
sw $5, 4($3)
lw $7, 4($3)

#enable interrupts
ori $6, 0x000b
sw $6, 0($3)

#nop sled
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop

#allow_irq = 1, mode = 0, enable = 1
lui $6, 0x0000
ori $6, 0x0009
sw $6, 0($3)

#nop sled
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop

#allow_irq = 1, mode = 0, enable = 1
#try to make two simers interrupt simutaneously
sw $5, 4($3)
addiu $5, $5, -1
sw $5, 4($4)

lui $6, 0x0000
ori $6, 0x0009
sw $6, 0($3)
sw $6, 0($4)

#nop sled
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop

#stop interrupts in the middle
lui $6, 0x0000
ori $6, 0x0009
sw $6, 0($3)

#allow_irq = 0
lui $6, 0x0000
ori $6, 0x0001
sw $6, 0($3)

#nop sled
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop

#tail loop
loop:
beq $0, $0, loop
nop

.text 0x4180
#disable counter
lui $6, 0x0000
ori $6, 0x0000
sw $6, 0($3)
sw $6, 0($4)

mfc0 $14, $14
addiu $14, $14, 4
mtc0 $14, $14
lui $26, 0xfeed
ori $26, 0xbeef
eret
