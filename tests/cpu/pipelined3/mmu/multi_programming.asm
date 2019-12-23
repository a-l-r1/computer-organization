# memory layout
# code     paddr                    vaddr
# init     0xbfc03000-0xbfc03ffc    0xbfc03000-0xbfc03ffc
# isr      0xbfc04180-0xbfc04ffc    0xbfc04180-0xbfc04ffc
# dm       0x00000000-0x00001ffc    0x00000000-0x00001ffc
# prog0    0x00005000-0x00005ffc    0x00003000-0x00003ffc
# prog1    0x00006000-0x00006ffc    0x00003000-0x00003ffc

# cp0 related registers
# id    name
# 0     index
# 2     entrylo0
# 3     entrylo1
# 10    entryhi

# init
.text 0xbfc03000
# fill dm
# target tlb[0]
lui $t0, 0x0000
ori $t0, 0x0000 # p = 0, index = 0
mtc0 $t0, $0 # index

lui $t0, 0x0000
ori $t0, 0x0000 # vpn = 0x0, asid = 0
mtc0 $t0, $10 # entryhi

# 0x00000 -> 0x00000
lui $t0, 0x0000
ori $t0, 0x0007 # pfn = 0x00000, d = 1, v = 1, g = 1
mtc0 $t0, $2 # entrylo0

# 0x00001 -> 0x00001
lui $t0, 0x0000
ori $t0, 0x0047 # pfn = 0x00001, d = 1, v = 1, g = 1
mtc0 $t0, $3 # entrylo1

# commit
tlbwi

# fill prog0 
# target tlb[1]
lui $t0, 0x0000
ori $t0, 0x0001 # p = 0, index = 1
mtc0 $t0, $0 # index

lui $t0, 0x0000
ori $t0, 0x0100 # vpn = 0x1, asid = 0
mtc0 $t0, $10 # entryhi

# 0x00002 -> (none)
lui $t0, 0x0000
ori $t0, 0x0001 # pfn = 0x00000, d = 0, v = 0, g = 1
mtc0 $t0, $2 # entrylo0

# 0x00003 -> 0x00002
lui $t0, 0x0000
ori $t0, 0x0083 # pfn = 0x00002, d = 0, v = 1, g = 1
mtc0 $t0, $3 # entrylo1

# commit
tlbwi

# enable interrupts on buttons
lui $t0, 0x0000
ori $t0, 0x8001
mtc0 $t0, $12

# jump into prog0
lui $t0, 0x0000
ori $t0, 0x3000
jr $t0
nop

# prog0
.text 0xbfc02000

lui $t0, 0x0000
ori $t0, 0x00ff
lui $t1, 0xbfc0 # led
ori $t1, 0x7f34

sw $t0, 0($t1)

loop_0:
beq $0, $0, loop_0
nop

# prog1
.text 0xbfc05000

lui $t0, 0x0000
ori $t0, 0xff00
lui $t1, 0xbfc0 # led
ori $t1, 0x7f34

sw $t0, 0($t1)

loop_1:
beq $0, $0, loop_1
nop

# isr
.text 0xbfc04180
# NOTE: Don't clobber $t0 and $t1. Use $t8 and $t9 instead. 

# disable the interrupt of buttons
lui $t8, 0xbfc0
ori $t8, 0x7f40 # buttons
sw $0, 0($t8)

# get current prog
# target tlb[1]
lui $t8, 0x0000
ori $t8, 0x0001 # p = 0, index = 1
mtc0 $t8, $0 # index

# fetch
tlbr

# modify entrylo1
mfc0 $t8, $3
# 0x00000083 -> 0x00000143 -> 0x00000083 -> ...
# pfn = 0x00002 -> 0x00005 -> 0x00002 -> ..., d = 0, v = 1, g = 0
xori $t8, $t8, 0x01c0
mtc0 $t8, $3

# change current prog
# commit
tlbwi

# jump to the other prog
lui $t8, 0x0000
ori $t8, 0x3000
mtc0 $t8, $14

eret

