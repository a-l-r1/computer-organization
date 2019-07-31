`ifndef INSTR_ID_H
`define INSTR_ID_H

`define REG_ZERO 5'd0
`define REG_NULL `REG_ZERO
`define REG_RA 5'd31

`define ROBUST_FUNCTION function automatic

`define GET_OP(x) (x[31:26])
`define GET_RS(x) (x[25:21])
`define GET_RT(x) (x[20:16])
`define GET_RD(x) (x[15:11])
`define GET_SHAMT(x) (x[10:6])
`define GET_FUNCT(x) (x[5:0])
`define GET_IMM(x) (x[15:0])
`define GET_IMM_J(x) (x[25:0])

`define IF_OR_UNKNOWN(cond, result) do begin \ 
	if (cond) begin \ 
		get_kind = result; \ 
	end else begin \ 
		get_kind = `UNKNOWN; \ 
	end \ 
	end while(0)

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

