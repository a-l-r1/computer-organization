`include "instr-id.h"
`include "pipelined.h"

`include "debug/debug.h"

`include "alu.h"
`include "ext.h"
`include "npc.h"

/* No more function definitions since ISE would crash seeing these functions
* in modules, and iSim would refuse to simulate seeing these functions are out
* of modules. Salute to ISE! */

/*
`ROBUST_FUNCTION [8:0] kind;
	input [31:0] instr;
	reg r;
	
	begin
		r = (`OP(instr) == 6'b000000);

		if (r && `FUNCT(instr) == 6'b100001 && `SHAMT(instr) == 5'b00000) kind = `ADDU;
		if (r && `FUNCT(instr) == 6'b100011 && `SHAMT(instr) == 5'b00000) kind = `SUBU;
		if (`OP(instr) == 6'b001111 && `RS(instr) == 5'b00000) kind = `LUI;
		if (`OP(instr) == 6'b001101) kind = `ORI;
		if (`OP(instr) == 6'b100011) kind = `LW;
		if (`OP(instr) == 6'b101011) kind = `SW;
		if (`OP(instr) == 6'b000100) kind = `BEQ;
		if (instr == 32'b0) kind = `NOP;

		kind = `UNKNOWN;
	end
endfunction

`ROBUST_FUNCTION [3:0] dptype;
	input [31:0] instr;
	reg [8:0] kind1;
	
	begin
		kind1 = kind(instr);

		dptype = kind1[8:5];
	end
endfunction
*/

module kind(
	input [31:0] instr, 
	output [8:0] result
);

assign r = (`OP(instr) == 6'b000000);

assign result = (r && `FUNCT(instr) == 6'b100001 && `SHAMT(instr) == 5'b00000) ? `ADDU : 
	(r && `FUNCT(instr) == 6'b100011 && `SHAMT(instr) == 5'b00000) ? `SUBU : 
	(`OP(instr) == 6'b001111 && `RS(instr) == 5'b00000) ? `LUI : 
	(`OP(instr) == 6'b001101) ? `ORI : 
	(`OP(instr) == 6'b100011) ? `LW : 
	(`OP(instr) == 6'b101011) ? `SW : 
	(`OP(instr) == 6'b000100) ? `BEQ : 
	(`OP(instr) == 6'b000010) ? `J : 
	(`OP(instr) == 6'b000011) ? `JAL : 
	(r && `FUNCT(instr) == 6'b001000 && `RT(instr) == 5'b00000 && `RD(instr) == 5'b00000 && `SHAMT(instr) == 5'b00000) ? `JR : 
	(r && `FUNCT(instr) == 6'b001010 && `SHAMT(instr) == 5'b00000) ? `MOVZ : 
	(instr == 32'b0) ? `NOP : 
	`UNKNOWN;

endmodule

module control(
	input clk, 
	input rst, 
	input [31:0] d_instr, 
	input [31:0] rf_read_result2, 
	output cw_f_pc_enable, 
	output cw_d_pff_enable, 
	output cw_e_pff_rst, 
	output [2:0] cw_f_npc_jump_mode, 
	output [2:0] cw_d_ext_mode, 
	output [4:0] cw_d_rf_read_addr1, 
	output [4:0] cw_d_rf_read_addr2, 
	output cw_e_m_alusrc, 
	output [4:0] cw_e_alu_op, 
	output cw_m_dm_write_enable, 
	output cw_w_rf_write_enable, 
	output [2:0] cw_w_m_regdata, 
	output [4:0] cw_w_rf_write_addr, 
	output [2:0] cw_fm_d1, 
	output [2:0] cw_fm_d2, 
	output [2:0] cw_fm_e1, 
	output [2:0] cw_fm_e2, 
	output [2:0] cw_fm_m
);

/* Macro definitions */

/* No, can't use `define dkind(x) (dkind_result == x). ISE would crash.
* Salute to ISE. */

`define is(x, y) ((x) == (y))

`define drs `RS(d_instr)
`define drt `RT(d_instr)
`define drd `RD(d_instr)

/* Wire and register declarations */

wire [31:0] d_instr;
wire [31:0] e_instr;
wire [31:0] m_instr;
wire [31:0] w_instr;

wire [8:0] dkind;
wire [8:0] ekind;
wire [8:0] mkind;
wire [8:0] wkind;

wire [3:0] ddptype;
wire [3:0] edptype;
wire [3:0] mdptype;
wire [3:0] wdptype;

wire [4:0] d_reg1;
wire [4:0] d_reg2;
wire [4:0] d_regw;

wire [4:0] e_reg1;
wire [4:0] e_reg2;
wire [4:0] e_regw;

wire [4:0] m_reg1;
wire [4:0] m_reg2;
wire [4:0] m_regw;

wire [4:0] w_reg1;
wire [4:0] w_reg2;
wire [4:0] w_regw;

wire stall;

/* Module references */

kind _dkind(
	.instr(d_instr), 
	.result(dkind)
);

kind _ekind(
	.instr(e_instr), 
	.result(ekind)
);

kind _mkind(
	.instr(m_instr), 
	.result(mkind)
);

kind _wkind(
	.instr(w_instr), 
	.result(wkind)
);

assign ddptype = dkind[8:5];
assign edptype = ekind[8:5];
assign mdptype = mkind[8:5];
assign wdptype = wkind[8:5];

/* Internal pipeline */

pff #(.BIT_WIDTH(32)) e_instr_(
	.clk(clk), 
	.enable(1'b1), 
	.rst(cw_e_pff_rst | rst), 
	.i(d_instr), 
	.o(e_instr)
);

pff #(.BIT_WIDTH(32)) m_instr_(
	.clk(clk), 
	.enable(1'b1), 
	.rst(rst), 
	.i(e_instr), 
	.o(m_instr)
);

pff #(.BIT_WIDTH(32)) w_instr_(
	.clk(clk), 
	.enable(1'b1), 
	.rst(rst), 
	.i(m_instr), 
	.o(w_instr)
);

pff #(.BIT_WIDTH(5)) e_reg1_(
	.clk(clk), 
	.enable(1'b1), 
	.rst(cw_e_pff_rst | rst), 
	.i(d_reg1), 
	.o(e_reg1)
);

pff #(.BIT_WIDTH(5)) m_reg1_(
	.clk(clk), 
	.enable(1'b1), 
	.rst(rst), 
	.i(e_reg1), 
	.o(m_reg1)
);

pff #(.BIT_WIDTH(5)) w_reg1_(
	.clk(clk), 
	.enable(1'b1), 
	.rst(rst), 
	.i(m_reg1), 
	.o(w_reg1)
);

pff #(.BIT_WIDTH(5)) e_reg2_(
	.clk(clk), 
	.enable(1'b1), 
	.rst(cw_e_pff_rst | rst), 
	.i(d_reg2), 
	.o(e_reg2)
);

pff #(.BIT_WIDTH(5)) m_reg2_(
	.clk(clk), 
	.enable(1'b1), 
	.rst(rst), 
	.i(e_reg2), 
	.o(m_reg2)
);

pff #(.BIT_WIDTH(5)) w_reg2_(
	.clk(clk), 
	.enable(1'b1), 
	.rst(rst), 
	.i(m_reg2), 
	.o(w_reg2)
);

pff #(.BIT_WIDTH(5)) e_regw_(
	.clk(clk), 
	.enable(1'b1), 
	.rst(cw_e_pff_rst | rst), 
	.i(d_regw), 
	.o(e_regw)
);

pff #(.BIT_WIDTH(5)) m_regw_(
	.clk(clk), 
	.enable(1'b1), 
	.rst(rst), 
	.i(e_regw), 
	.o(m_regw)
);

pff #(.BIT_WIDTH(5)) w_regw_(
	.clk(clk), 
	.enable(1'b1), 
	.rst(rst), 
	.i(m_regw), 
	.o(w_regw)
);

/* Register identification */

assign d_reg1 = 
	(ddptype == `CAL_R || ddptype == `CAL_I || ddptype == `LOAD || ddptype == `STORE || ddptype == `BRANCH || ddptype == `JUMP_R || ddptype == `CMOV) ? `drs : 
	(ddptype == `JUMP_I || ddptype == `NOP) ? `ZERO : 
	`ZERO;

assign d_reg2 = 
	(ddptype == `CAL_R || ddptype == `CAL_I || ddptype == `STORE || ddptype == `BRANCH || ddptype == `CMOV) ? `drt : 
	`ZERO;

assign d_regw = 
	(ddptype == `CAL_R) ? `drd : 
	(ddptype == `CAL_I || ddptype == `LOAD) ? `drt : 
	(ddptype == `JUMP_I) ? (
		(dkind == `JAL) ? `RA : 
		(dkind == `J) ? `ZERO : 
		`ZERO
	) : 
	(ddptype == `CMOV) ? (
		(dkind == `MOVZ && rf_read_result2 == 32'b0) ? `drd : 
		`ZERO
	) : 
	`ZERO;

/* Normal control signals */

/* npc.jump_mode is controlled by the instruction in level D */

assign cw_f_npc_jump_mode = 
	(ddptype == `BRANCH) ? (
		(dkind == `BEQ) ? `NPC_JUMP_WHEN_EQUAL : 
		`NPC_JUMP_DISABLED
	) : 
	(ddptype == `JUMP_I) ? `NPC_J : 
	(ddptype == `JUMP_R) ? `NPC_REG : 
	`NPC_JUMP_DISABLED;

assign cw_d_ext_mode = 
	(ddptype == `CAL_I) ? (
		(dkind == `LUI) ? `EXT_MODE_PAD : 
		(dkind == `ORI) ? `EXT_MODE_UNSIGNED : 
		`EXT_MODE_UNSIGNED
	) : 
	(ddptype == `LOAD || ddptype == `STORE) ? `EXT_MODE_SIGNED :
	`EXT_MODE_SIGNED;

assign cw_d_rf_read_addr1 = d_reg1;

assign cw_d_rf_read_addr2 = d_reg2;

assign cw_e_m_alusrc = 
	(edptype == `CAL_R || edptype == `CMOV || edptype == `BRANCH) ? 1'b0 : 
	(edptype == `CAL_I || edptype == `LOAD || edptype == `STORE) ? 1'b1 : 
	1'b0;

assign cw_e_alu_op = 
	(edptype == `CAL_R) ? (
		(ekind == `ADDU) ? `ALU_ADD : 
		(ekind == `SUBU) ? `ALU_SUB : 
		`ALU_OR
	) : 
	(edptype == `CAL_I) ? (
		(ekind == `LUI) ? `ALU_OR : 
		(ekind == `ORI) ? `ALU_OR : 
		`ALU_OR
	) : 
	(edptype == `CMOV) ? (
		(ekind == `MOVZ) ? `ALU_MOVZ : 
		`ALU_OR
	) : 
	(edptype == `LOAD || edptype == `STORE) ? `ALU_ADD : 
	`ALU_OR;

assign cw_m_dm_write_enable = 
	(mdptype == `STORE) ? 1'b1 : 
	1'b0;

assign cw_w_rf_write_enable = 
	(wdptype == `CAL_R || wdptype == `CAL_I || wdptype == `LOAD || wdptype == `JUMP_I || wdptype == `CMOV) ? 1'b1 : 
	1'b0;

/* See doc/datapath/pipelined.md */

assign cw_w_m_regdata = 
	(wdptype == `CAL_R || wdptype == `CAL_I || wdptype == `CMOV) ? 3'd1 : 
	(wdptype == `LOAD) ? 3'd2 : 
	(wdptype == `JUMP_I) ? 3'd3 : 
	3'd0;

assign cw_w_rf_write_addr = w_regw;

/* Forward control */

forward forward_(
	.dkind(dkind), 
	.ekind(ekind), 
	.mkind(mkind), 
	.wkind(wkind), 
	.d_reg1(d_reg1), 
	.d_reg2(d_reg2), 
	.d_regw(d_regw), 
	.e_reg1(e_reg1), 
	.e_reg2(e_reg2), 
	.e_regw(e_regw), 
	.m_reg1(m_reg1), 
	.m_reg2(m_reg2), 
	.m_regw(m_regw), 
	.w_reg1(w_reg1), 
	.w_reg2(w_reg2), 
	.w_regw(w_regw), 
	.cw_fm_d1(cw_fm_d1), 
	.cw_fm_e1(cw_fm_e1), 
	.cw_fm_d2(cw_fm_d2), 
	.cw_fm_e2(cw_fm_e2), 
	.cw_fm_m(cw_fm_m)
);

/* Stall control */

hazard hazard_(
	.dkind(dkind), 
	.ekind(ekind), 
	.mkind(mkind), 
	.wkind(wkind), 
	.d_reg1(d_reg1), 
	.d_reg2(d_reg2), 
	.d_regw(d_regw), 
	.e_reg1(e_reg1), 
	.e_reg2(e_reg2), 
	.e_regw(e_regw), 
	.m_reg1(m_reg1), 
	.m_reg2(m_reg2), 
	.m_regw(m_regw), 
	.w_reg1(w_reg1), 
	.w_reg2(w_reg2), 
	.w_regw(w_regw), 
	.stall(stall)
);

/* TODO: more thorough stall control? */

assign cw_f_pc_enable = ~stall;

assign cw_d_pff_enable = ~stall;

assign cw_e_pff_rst = stall;

endmodule

