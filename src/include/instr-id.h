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
`define LUI 9'b0010_00000
`define ORI 9'b0010_00001
`define LW 9'b0011_00000
`define SW 9'b0100_00000
`define BEQ 9'b0101_00000
`define J 9'b0110_00000
`define JAL 9'b0110_00001
`define JR 9'b0111_00000
`define MOVZ 9'b1000_00000
`define NOP 9'b1111_00000

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
`define NOP_TYPE 4'b1111

`endif

