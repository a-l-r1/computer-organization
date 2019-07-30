`ifndef INSTR_ID_H
`define INSTR_ID_H

`define REG_ZERO 5'd0
`define REG_NULL `REG_ZERO
`define REG_RA 5'd31

`define ROBUST_FUNCTION function automatic

`define UNKNOWN 9'b0000_00000
`define UNK `UNKNOWN
`define ADDU 9'b0001_00000
`define SUBU 9'b0001_00001
`define LUI 9'b0010_00000
`define ORI 9'b0010_00001
`define LW 9'b0011_00000
`define SW 9'b0100_00000
`define BEQ 9'b0101_00000
`define NOP 9'b1111_00000

`endif

