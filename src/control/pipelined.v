`include "instr-id.h"
`include "pipelined.h"

`define PART_NAME "instr-id"

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

`define fwable(old, new) (((old) == (new)) && ((old) != 0))

`define inf 3'd7

/* Wire and register declarations */

reg [31:0] e_instr;
reg [31:0] m_instr;
reg [31:0] w_instr;

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

reg [4:0] e_reg1;
reg [4:0] e_reg2;
reg [4:0] e_regw;

reg [4:0] m_reg1;
reg [4:0] m_reg2;
reg [4:0] m_regw;

reg [4:0] w_reg1;
reg [4:0] w_reg2;
reg [4:0] w_regw;

wire stall;

wire [3:0] t_use_reg1;
wire [3:0] t_use_reg2;
wire [3:0] t_new_e;
wire [3:0] t_new_m;

/* Initial block */

initial begin
	e_instr = 32'b0;
	m_instr = 32'b0;
	w_instr = 32'b0;

	e_reg1 = 5'b0;
	e_reg2 = 5'b0;
	e_regw = 5'b0;

	m_reg1 = 5'b0;
	m_reg2 = 5'b0;
	m_regw = 5'b0;

	w_reg1 = 5'b0;
	w_reg2 = 5'b0;
	w_regw = 5'b0;
end

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

always @(posedge clk) begin
	if (stall == 1'b1) begin
		e_instr <= 32'b0;
		m_instr <= e_instr;
		w_instr <= m_instr;

		e_reg1 <= 5'b0;
		m_reg1 <= e_reg1;
		w_reg1 <= m_reg1;

		e_reg2 <= 5'b0;
		m_reg2 <= e_reg2;
		w_reg2 <= m_reg2;

		e_regw <= 5'b0;
		m_regw <= e_regw;
		w_regw <= m_regw;
	end else begin
		e_instr <= d_instr;
		m_instr <= e_instr;
		w_instr <= m_instr;

		e_reg1 <= d_reg1;
		m_reg1 <= e_reg1;
		w_reg1 <= m_reg1;

		e_reg2 <= d_reg2;
		m_reg2 <= e_reg2;
		w_reg2 <= m_reg2;

		e_regw <= d_regw;
		m_regw <= e_regw;
		w_regw <= m_regw;
	end

	`debug_write(("instructions: D: 0x%08x, E: 0x%08x, M: 0x%08x, W: 0x%08x\n", d_instr, e_instr, m_instr, w_instr));
	`debug_write(("kind: D: 0b%09b, E: 0b%09b, M: 0b%09b, W: 0b%09b\n", dkind, ekind, mkind, wkind));
	`debug_write(("reg1: D: %0d, E: %0d, M: %0d, W: %0d\n", d_reg1, e_reg1, m_reg1, w_reg1));
	`debug_write(("reg2: D: %0d, E: %0d, M: %0d, W: %0d\n", d_reg2, e_reg2, m_reg2, w_reg2));
	`debug_write(("regw: D: %0d, E: %0d, M: %0d, W: %0d\n", d_regw, e_regw, m_regw, w_regw));
end

/* Normal control signals */

/* npc.jump_mode is controlled by the instruction in level E */

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

/* Forward control */

assign cw_fm_d1 = 
	(`fwable(d_reg1, e_regw) && edptype == `CMOV) ? `E2D_rf : 
	(`fwable(d_reg1, e_regw) && edptype == `JUMP_I) ? `E2D_npc : 
	(`fwable(d_reg1, m_regw) && mdptype == `JUMP_I) ? `M2D_npc : 
	(`fwable(d_reg1, m_regw) && (mdptype == `CAL_R || mdptype == `CAL_I || mdptype == `CMOV)) ? `M2D_alu : 
	(`fwable(d_reg1, w_regw)) ? `W2D_rf : 
	`orig;

assign cw_fm_e1 = 
	(`fwable(e_reg1, m_regw) && mdptype == `JUMP_I) ? `M2E_npc : 
	(`fwable(e_reg1, m_regw) && (mdptype == `CAL_R || mdptype == `CAL_I || mdptype == `CMOV)) ? `M2E_alu : 
	(`fwable(e_reg1, w_regw)) ? `W2E_rf : 
	`orig;

/* Edit cw_fm_[de]1 instead */

assign cw_fm_d2 = 
	(`fwable(d_reg2, e_regw) && edptype == `CMOV) ? `E2D_rf : 
	(`fwable(d_reg2, e_regw) && edptype == `JUMP_I) ? `E2D_npc : 
	(`fwable(d_reg2, m_regw) && mdptype == `JUMP_I) ? `M2D_npc : 
	(`fwable(d_reg2, m_regw) && (mdptype == `CAL_R || mdptype == `CAL_I || mdptype == `CMOV)) ? `M2D_alu : 
	(`fwable(d_reg2, w_regw)) ? `W2D_rf : 
	`orig;

assign cw_fm_e2 = 
	(`fwable(e_reg2, m_regw) && mdptype == `JUMP_I) ? `M2E_npc : 
	(`fwable(e_reg2, m_regw) && (mdptype == `CAL_R || mdptype == `CAL_I || mdptype == `CMOV)) ? `M2E_alu : 
	(`fwable(e_reg2, w_regw)) ? `W2E_rf : 
	`orig;

assign cw_fm_m = 
	(`fwable(m_reg2, w_regw)) ? `W2M_rf : 
	`orig;

/* Stall control */

assign t_use_reg1 = 
	(ddptype == `CAL_R || ddptype == `CAL_I || ddptype == `LOAD || ddptype == `STORE) ? 3'd1 : 
	(ddptype == `BRANCH || ddptype == `JUMP_R || ddptype == `CMOV) ? 3'd0 : 
	`inf;

assign t_use_reg2 = 
	(ddptype == `STORE) ? 3'd2 : 
	(ddptype == `CAL_R || ddptype == `CAL_I) ? 3'd1 : 
	(ddptype == `BRANCH || ddptype == `CMOV) ? 3'd0 : 
	`inf;

assign t_new_e = 
	(edptype == `LOAD) ? 3'd2 : 
	(edptype == `CAL_R || edptype == `CAL_I) ? 3'd1 : 
	3'd0;

assign t_new_m = 
	(mdptype == `LOAD || mdptype == `STORE) ? 3'd1 : 
	3'd0;

assign stall_e2d_reg1 = `fwable(d_reg1, e_regw) && $unsigned(t_use_reg1) < $unsigned(t_new_e);
assign stall_m2d_reg1 = `fwable(d_reg1, m_regw) && $unsigned(t_use_reg1) < $unsigned(t_new_m);
assign stall_e2d_reg2 = `fwable(d_reg2, e_regw) && $unsigned(t_use_reg2) < $unsigned(t_new_e);
assign stall_m2d_reg2 = `fwable(d_reg2, m_regw) && $unsigned(t_use_reg2) < $unsigned(t_new_m);

assign stall = stall_e2d_reg1 | stall_m2d_reg1 | stall_e2d_reg2 | stall_m2d_reg2;

/* TODO: more thorough stall control? */

assign cw_f_pc_enable = ~stall;

assign cw_d_pff_enable = ~stall;

assign cw_e_pff_rst = ~stall;

endmodule

