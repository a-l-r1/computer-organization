`include "instr-id.h"

`define PART_NAME "instr-id"

`include "debug/debug.h"

`ROBOST_FUNCTION [8:0] kind begin
	input [31:0] instr;
	reg r;

	r = (`OP(instr) == 6'b000000);
	
	if (r && `FUNCT(instr) == 6'b100001 && `SHAMT(instr) == 5'b00000) kind = `ADDU;
	if (r && `FUNCT(instr) == 6'b100011 && `SHAMT(instr) == 5'b00000) kind = `SUBU;
	if (`OP(instr) == 6'b001111 && `RS(instr) == 5'b00000) kind = `LUI;
	if (`OP(instr) == 6'b001101) kind = `ORI;
	if (`OP(instr) == 6'b100011) kind = `LW;
	if (`OP(instr) == 6'b101011) kind = `SW;
	if (`OP(instr) == 6'b000100) kind = `BEQ;
	if (instr == 32'b0) kind = `NOP;

	/* default */
	kind = `UNKNOWN;
endfunction

`ROBOST_FUNCTION [3:0] dptype begin
	input [31:0] instr;

	reg [8:0] kind1;
	kind1 = kind(instr);

	get_datapath_type = kind1[8:5];
endfunction

module control(
	input clk, 
	input [31:0] curr_instr, 
	output cw_pc_enable, 
	output cw_d_pff_enable, 
	output [2:0] cw_d_ext_mode, 
	output [4:0] cw_d_rf_read_addr1, 
	output [4:0] cw_d_rf_read_addr2, 
	output cw_e_m_alu_num2, 
	output [4:0] cw_e_alu_op, 
	output cw_m_dm_write_enable, 
	output cw_w_rf_write_enable, 
	output cw_w_m_rf_write_data, 
	output [4:0] cw_w_rf_write_addr, 
	output [1:0] cw_fm_d1, 
	output [1:0] cw_fm_d2, 
	output [1:0] cw_fm_e1, 
	output [1:0] cw_fm_e2
)

reg [31:0] d_instr;
reg [31:0] e_instr;
reg [31:0] m_instr;
reg [31:0] w_instr;

wire stall;

initial begin
	d_instr = 32'b0;
	e_instr = 32'b0;
	m_instr = 32'b0;
	w_instr = 32'b0;
end

always @(posedge clk) begin
	if (stall == 1'b1) begin
		`debug_print(("stall detected"));
		d_instr <= 32'b0;
		e_instr <= d_instr;
		m_instr <= e_instr;
		w_instr <= m_instr;
	end else begin
		d_instr <= curr_instr;
		e_instr <= d_instr;
		m_instr <= e_instr;
		w_instr <= m_instr;
	end

	`debug_print(("instructions: D: 0x%08x, E: 0x%08x, M: 0x%08x, W: 0x%08x", d_instr, e_instr, m_instr, w_instr))
end

endmodule

