`ifndef SINGLE_CYCLE_H
`define SINGLE_CYCLE_H

`define R_TYPE 2'b00
`define I_TYPE 2'b01
`define J_TYPE 2'b10
`define C_TYPE 2'b11

`define INSTR_UNKNOWN 8'd0
`define INSTR_ADDU 8'd1
`define INSTR_SUBU 8'd2
`define INSTR_LUI 8'd3
`define INSTR_ORI 8'd4
`define INSTR_LW 8'd5
`define INSTR_SW 8'd6
`define INSTR_BEQ 8'd7
`define INSTR_NOP 8'd8

`define CM_RF_WRITE_ADDR_IM_DATA_20_16 1'b0
`define CM_RF_WRITE_ADDR_IM_DATA_15_11 1'b1

`define CM_RF_WRITE_DATA_ALU_RESULT 1'b0
`define CM_RF_WRITE_DATA_DM_READ_RESULT 1'b1

`define CM_ALU_NUM2_RF_READ_RESULT2 1'b0
`define CM_ALU_NUM2_EXT_RESULT 1'b1

`endif

