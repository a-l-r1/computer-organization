.macro push(%r)
addiu $sp, $sp, -4
sw %r, 0($sp)
.end_macro

.macro pop(%r)
lw %r, 0($sp)
addiu $sp, $sp, 4
.end_macro

.macro save_context()

.end_macro

.macro init_sp()
# initialize $sp
lui $sp, 0x0000
ori $sp, 0x2ffc
.end_macro

.macro init_k0_k1()
# initialize $k0 and $k1
lui $k0, 0x0000
ori $k0, 0x2000
lui $k1, 0x0000
ori $k1, 0x2000
.end_macro

.macro init_cp0()
# cp0 setup
# disable all interrupts
mtc0 $0, $8
mtc0 $0, $12
mtc0 $0, $13
mtc0 $0, $14
.end_macro

.macro save_context()
# auto-generated code saving registers $0-$25 and $28-$31
sw $0, 0($k0)
sw $1, 4($k0)
sw $2, 8($k0)
sw $3, 12($k0)
sw $4, 16($k0)
sw $5, 20($k0)
sw $6, 24($k0)
sw $7, 28($k0)
sw $8, 32($k0)
sw $9, 36($k0)
sw $10, 40($k0)
sw $11, 44($k0)
sw $12, 48($k0)
sw $13, 52($k0)
sw $14, 56($k0)
sw $15, 60($k0)
sw $16, 64($k0)
sw $17, 68($k0)
sw $18, 72($k0)
sw $19, 76($k0)
sw $20, 80($k0)
sw $21, 84($k0)
sw $22, 88($k0)
sw $23, 92($k0)
sw $24, 96($k0)
sw $25, 100($k0)

sw $28, 112($k0)
sw $29, 116($k0)
sw $30, 120($k0)
sw $31, 124($k0)

mfhi $t0
sw $t0, 128($k0)
mflo $t0
sw $t0, 132($k0)
.end_macro

.macro restore_context()
lw $t0, 128($k0)
mthi $t0
lw $t0, 132($k0)
mtlo $t0

# auto-generated code restoring registers $0-$25 and $28-$31
lw $0, 0($k0)
lw $1, 4($k0)
lw $2, 8($k0)
lw $3, 12($k0)
lw $4, 16($k0)
lw $5, 20($k0)
lw $6, 24($k0)
lw $7, 28($k0)
lw $8, 32($k0)
lw $9, 36($k0)
lw $10, 40($k0)
lw $11, 44($k0)
lw $12, 48($k0)
lw $13, 52($k0)
lw $14, 56($k0)
lw $15, 60($k0)
lw $16, 64($k0)
lw $17, 68($k0)
lw $18, 72($k0)
lw $19, 76($k0)
lw $20, 80($k0)
lw $21, 84($k0)
lw $22, 88($k0)
lw $23, 92($k0)
lw $24, 96($k0)
lw $25, 100($k0)

lw $28, 112($k0)
lw $29, 116($k0)
lw $30, 120($k0)
lw $31, 124($k0)
.end_macro

.macro init_s0_s1()
# $s0: MMIO base address of timer0 (0x00007f00)
# $s1: MMIO base address of timer1 (0x00007f10)
lui $s0, 0x0000
ori $s0, 0x7f00
lui $s1, 0x0000
ori $s1, 0x7f10
.end_macro

.macro add_epc_4()
# add epc by 4
mfc0 $t0, $14
addiu $t0, $t0, 4
mtc0 $t0, $14
.end_macro

.text
# initialization
init_cp0()
init_sp()
init_k0_k1()
init_s0_s1()

# set preset
lui $t0, 0
ori $t0, 10
sw $t0, 4($s0)
sw $t0, 4($s1)

# enable all interrupts
lui $t0, 0x0000
ori $t0, 0xfc01
mtc0 $t0, $12

# enable timer0
lui $t0, 0x0000
ori $t0, 0x0009
sw $t0, 0($s0)

# instruction slope
# NOTE: rt -> curr_instr[21:16] and therefore can be more easily displayed in
# hex; sll -> (curr_instr[5:0] == 0b000000) which means less visual clutter
sll $0, $1, 0
sll $0, $2, 0
sll $0, $3, 0
sll $0, $4, 0
sll $0, $5, 0
sll $0, $6, 0
sll $0, $7, 0
sll $0, $8, 0
sll $0, $9, 0
sll $0, $10, 0
sll $0, $11, 0
sll $0, $12, 0 # at level W when interrupt is hit
sll $0, $13, 0 # at level M when interrupt is hit
sll $0, $14, 0 # at level E when interrupt is hit
sll $0, $15, 0 # at level D when interrupt is hit
sll $0, $16, 0 # at level F when interrupt is hit
sll $0, $17, 0
sll $0, $18, 0
sll $0, $19, 0
sll $0, $20, 0
sll $0, $21, 0
sll $0, $22, 0
sll $0, $23, 0
sll $0, $24, 0
sll $0, $25, 0
sll $0, $26, 0
sll $0, $27, 0
sll $0, $28, 0
sll $0, $29, 0
sll $0, $30, 0
sll $0, $31, 0

loop:
beq $0, $0, loop

.text 0x4180
save_context()

init_s0_s1()

# check cause
# $s2: saved cause register
mfc0 $s2, $13
addu $t0, $s2, $0
srl $t0, $t0, 2
andi $t0, $t0, 0x1f

bne $t0, $0, handle_exception
nop
handle_interrupt:
# disable interrupts
# hwint[4] > hwint[3] > hwint[2]

addu $t0, $s2, $0
srl $t0, $t0, 10
andi $t0, $t0, 0x2f # 0b111111

andi $t1, $t0, 0x04 # 0b000100
bne $t1, $0, handle_test_interrupt
nop

andi $t1, $t0, 0x02 # 0b000010
bne $t1, $0, handle_timer1
nop

andi $t1, $t0, 0x01 # 0b000001
bne $t1, $0, handle_timer0
nop

# no interrupts detected
beq $0, $0, handle_interrupt_end
nop

handle_test_interrupt:

beq $0, $0, handle_interrupt_end
nop

handle_timer1:
	# NOTE: sync with handle_timer0, but carefully
	
	# set timer1 allow_irq = 0 and enable = 0
	lw $t0, 0($s1)
	lui $t1, 0xffff
	# bitmask == 0b0110
	ori $t1, 0xfff6
	and $t0, $t0, $t1
	sw $t0, 0($s1)

beq $0, $0, handle_interrupt_end
nop

handle_timer0:	
	# set timer0 allow_irq = 0 and enable = 0
	lw $t0, 0($s0)
	lui $t1, 0xffff
	# bitmask == 0b0110
	ori $t1, 0xfff6
	and $t0, $t0, $t1
	sw $t0, 0($s0)

beq $0, $0, handle_interrupt_end
nop

handle_interrupt_end:
beq $0, $0, handler_end
nop

handle_exception:
addu $t0, $s0, 0
srl $t0, $t0, 31
beq $t0, $0, handle_non_bds
nop

handle_in_bds:
# epc += 8
# effectively ignore execution of branch instructions when in bds
add_epc_4()
add_epc_4()
beq $0, $0, handle_exception_end
nop

handle_non_bds:
# exception occurred when handling interrupts must not be in branch delay slots, 
# except when the branch instruction is at the upper boundary of im
add_epc_4()
beq $0, $0, handle_exception_end
nop

handle_exception_end:
beq $0, $0, handler_end
nop

handler_end:
restore_context()
eret
# for testing
lui $1, 0xdead
