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

`define UNKNOWN 9'b0000_00000
`define UNK `UNKNOWN
`define ADDU 9'b0001_00000
`define SUBU 9'b0001_00001
`define ADD 9'b0001_00010
`define SUB 9'b0001_00011
`define SLL 9'b0001_00100
`define SRL 9'b0001_00101
`define SRA 9'b0001_00110
`define AND 9'b0001_00111
`define OR 9'b0001_01000
`define NOR 9'b0001_01001
`define XOR 9'b0001_01010
`define SLT 9'b0001_01011
`define SLTU 9'b0001_01100
`define SLLV 9'b0001_01101
`define SRLV 9'b0001_01110
`define SRAV 9'b0001_01111
`define LUI 9'b0010_00000
`define ORI 9'b0010_00001
`define ADDI 9'b0010_00010
`define ADDIU 9'b0010_00011
`define ANDI 9'b0010_00100
`define XORI 9'b0010_00101
`define SLTI 9'b0010_00110
`define SLTIU 9'b0010_00111
`define LW 9'b0011_00000
`define LH 9'b0011_00001
`define LHU 9'b0011_00010
`define LB 9'b0011_00011
`define LBU 9'b0011_00100
`define SW 9'b0100_00000
`define SH 9'b0100_00001
`define SB 9'b0100_00010
`define BEQ 9'b0101_00000
`define BNE 9'b0101_00001
`define BLEZ 9'b0101_00010
`define BGEZ 9'b0101_00011
`define BLTZ 9'b0101_00100
`define BGTZ 9'b0101_00101
`define J 9'b0110_00000
`define JAL 9'b0110_00001
`define JR 9'b0111_00000
`define JALR 9'b0111_00001
`define MOVZ 9'b1000_00000
`define MULT 9'b1001_00000
`define MULTU 9'b1001_00001
`define DIV 9'b1001_00010
`define DIVU 9'b1001_00011
`define MFHI 9'b1010_00000
`define MFLO 9'b1010_00001
`define MTHI 9'b1011_00000
`define MTLO 9'b1011_00001

`define UNKNOWN_TYPE 4'b0000
`define UNK_TYPE `UNKNOWN_TYPE
`define CAL_R 4'b0001
`define CAL_I 4'b0010
`define LOAD 4'b0011
`define STORE 4'b0100
`define BRANCH 4'b0101
`define JUMP_I 4'b0110
`define JUMP_R 4'b0111
`define CMOV 4'b1000
`define CAL_M 4'b1001
`define LOAD_M 4'b1010
`define STORE_M 4'b1011

`endif

