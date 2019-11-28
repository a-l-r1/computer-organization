`ifndef INSTR_ID_H
`define INSTR_ID_H

`define ZERO 5'd0
`define NULL `ZERO
`define RA 5'd31

`define ROBUST_FUNCTION function automatic

`define OP(x) (x[31:26])
`define RS(x) (x[25:21])
`define RT(x) (x[20:16])
`define RD(x) (x[15:11])
`define SHAMT(x) (x[10:6])
`define FUNCT(x) (x[5:0])
`define IMM(x) (x[15:0])
`define IMM_J(x) (x[25:0])

`define UNKNOWN 10'b00000_00000
`define UNK `UNKNOWN
`define ADDU 10'b00001_00000
`define SUBU 10'b00001_00001
`define ADD 10'b00001_00010
`define SUB 10'b00001_00011
`define SLL 10'b00001_00100
`define SRL 10'b00001_00101
`define SRA 10'b00001_00110
`define AND 10'b00001_00111
`define OR 10'b00001_01000
`define NOR 10'b00001_01001
`define XOR 10'b00001_01010
`define SLT 10'b00001_01011
`define SLTU 10'b00001_01100
`define SLLV 10'b00001_01101
`define SRLV 10'b00001_01110
`define SRAV 10'b00001_01111
`define LUI 10'b00010_00000
`define ORI 10'b00010_00001
`define ADDI 10'b00010_00010
`define ADDIU 10'b00010_00011
`define ANDI 10'b00010_00100
`define XORI 10'b00010_00101
`define SLTI 10'b00010_00110
`define SLTIU 10'b00010_00111
`define LW 10'b00011_00000
`define LH 10'b00011_00001
`define LHU 10'b00011_00010
`define LB 10'b00011_00011
`define LBU 10'b00011_00100
`define SW 10'b00100_00000
`define SH 10'b00100_00001
`define SB 10'b00100_00010
`define BEQ 10'b00101_00000
`define BNE 10'b00101_00001
`define BLEZ 10'b00101_00010
`define BGEZ 10'b00101_00011
`define BLTZ 10'b00101_00100
`define BGTZ 10'b00101_00101
`define J 10'b00110_00000
`define JAL 10'b00110_00001
`define JR 10'b00111_00000
`define JALR 10'b00111_00001
`define MOVZ 10'b01000_00000
`define MULT 10'b01001_00000
`define MULTU 10'b01001_00001
`define DIV 10'b01001_00010
`define DIVU 10'b01001_00011
`define MFHI 10'b01010_00000
`define MFLO 10'b01010_00001
`define MTHI 10'b01011_00000
`define MTLO 10'b01011_00001
`define MFC0 10'b01100_00000
`define MTC0 10'b01101_00000
`define ERET 10'b01110_00000

`define UNKNOWN_TYPE 5'b00000
`define UNK_TYPE `UNKNOWN_TYPE
`define CAL_R 5'b00001
`define CAL_I 5'b00010
`define LOAD 5'b00011
`define STORE 5'b00100
`define BRANCH 5'b00101
`define JUMP_I 5'b00110
`define JUMP_R 5'b00111
`define CMOV 5'b01000
`define CAL_M 5'b01001
`define LOAD_M 5'b01010
`define STORE_M 5'b01011
`define LOAD_C0 5'b01100
`define STORE_C0 5'b01101
`define JUMP_C0 5'b01110

`endif

