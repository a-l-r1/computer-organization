`include "instr-id.h"

`define PART_NAME "instr-id"

`include "debug/debug.h"

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

		/* default */
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

module control(
	input clk, 
	input [31:0] d_instr, 
	input [31:0] rf_read_result1, 
	output cw_f_pc_enable, 
	output cw_d_pff_enable, 
	output [2:0] cw_f_npc_jump_mode, 
	output [2:0] cw_d_ext_mode, 
	output [4:0] cw_d_rf_read_addr1, 
	output [4:0] cw_d_rf_read_addr2, 
	output cw_e_m_alusrc, 
	output [4:0] cw_e_alu_op, 
	output cw_m_dm_write_enable, 
	output cw_w_rf_write_enable, 
	output cw_w_m_regdata, 
	output [4:0] cw_w_rf_write_addr, 
	output [2:0] cw_fm_d1, 
	output [2:0] cw_fm_d2, 
	output [2:0] cw_fm_e1, 
	output [2:0] cw_fm_e2, 
	output [2:0] cw_fm_m
);

/* Macro definitions */

`define dkind(x) (kind(d_instr) == x)
`define ekind(x) (kind(e_instr) == x)
`define mkind(x) (kind(m_instr) == x)
`define wkind(x) (kind(w_instr) == x)

`define ddptype(x) (dptype(d_instr) == x)
`define edptype(x) (dptype(e_instr) == x)
`define mdptype(x) (dptype(m_instr) == x)
`define wdptype(x) (dptype(w_instr) == x)

`define drs `RS(d_instr)
`define drt `RT(d_instr)
`define drd `RD(d_instr)

`define fwable(old, new) (((old) == (new)) && ((old) != 0))

`define orig 0
`define E2D_rf 1
`define E2D_npc 2
`define M2D_npc 3
`define M2D_alu 4
`define W2D_rf 5

`define M2E_npc 1
`define M2E_alu 2
`define W2E_rf 3

`define W2M_rf 1

`define inf 3'd7

/* Wire and register declarations */

reg [31:0] e_instr;
reg [31:0] m_instr;
reg [31:0] w_instr;

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

/* Internal pipeline */

always @(posedge clk) begin
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

	`debug_print(("instructions: D: 0x%08x, E: 0x%08x, M: 0x%08x, W: 0x%08x", d_instr, e_instr, m_instr, w_instr));
	`debug_print(("reg1: D: %0d, E: %0d, M: %0d, W: %0d", d_reg1, e_reg1, m_reg1, w_reg1));
	`debug_print(("reg2: D: %0d, E: %0d, M: %0d, W: %0d", d_reg2, e_reg2, m_reg2, w_reg2));
	`debug_print(("regw: D: %0d, E: %0d, M: %0d, W: %0d", d_regw, e_regw, m_regw, w_regw));
end

/* Normal control signals */

/* npc.jump_mode is controlled by the instruction in level E */

assign cw_f_npc_jump_mode = 
	(`edptype(`BRANCH)) ? (
		(`ekind(`BEQ)) ? `NPC_JUMP_WHEN_EQUAL : 
		`NPC_JUMP_DISABLED
	) : 
	(`edptype(`JUMP_I)) ? `NPC_J : 
	(`edptype(`JUMP_R)) ? `NPC_REG : 
	`NPC_JUMP_DISABLED;

assign cw_d_ext_mode = 
	(`ddptype(`CAL_I)) ? (
		(`dkind(`LUI)) ? `EXT_MODE_PAD : 
		(`dkind(`ORI)) ? `EXT_MODE_UNSIGNED : 
		`EXT_MODE_UNSIGNED
	) : 
	(`ddptype(`LOAD) || `ddptype(`STORE)) ? `EXT_MODE_SIGNED :
	`EXT_MODE_SIGNED;

assign cw_d_rf_read_addr1 = d_reg1;

assign cw_d_rf_read_addr2 = d_reg2;

assign cw_e_m_alusrc = 
	(`edptype(`CAL_R`) || `edptype(`CMOV) || `edptype(`BRANCH)) ? 1'b0 : 
	(`edptype(`LOAD) || `edptype(`STORE)) ? 1'b1 : 
	1'b0;

assign cw_e_alu_op = 
	(`edptype(`CAL_R)) ? (
		(`ekind(`ADDU)) ? `ALU_ADD : 
		(`ekind(`SUBU)) ? `ALU_SUB : 
		`ALU_OR
	) : 
	(`edptype(`CAL_I)) ? (
		(`ekind(`LUI)) ? `ALU_OR : 
		(`ekind(`ORI)) ? `ALU_OR : 
		`ALU_OR
	) : 
	(`edptype(`MOVZ)) ? (
		(`ekind(`MOVZ)) ? `ALU_CMOV : 
		`ALU_OR
	) : 
	(`edptype(`LOAD) || `edptype(`STORE)) ? `ALU_ADD : 
	`ALU_OR;

assign cw_m_dm_write_enable = 
	(`mdptype(`STORE)) ? 1'b1 : 
	1'b0;

assign cw_w_rf_write_enable = 
	(`wdptype(`CAL_R) || `wdptype(`CAL_I) || `wdptype(`LOAD) || `wdptype(`JUMP_I) || `wdptype(`CMOV)) ? 1'b1 : 
	1'b0;

/* See doc/datapath/pipelined.md */
assign cw_w_m_regdata = 
	(`wdptype(`CAL_R) || `wdptype(`CAL_I) || `wdptype(`CMOV)) ? 1 : 
	(`wdptype(`LOAD)) ? 2 : 
	(`wdptype(`JUMP_I)) ? 3 : 
	0;

assign cw_w_rf_write_addr = d_regw;

/* Register identification */

assign d_reg1 = 
	(`ddptype(`CAL_R) || `ddptype(`CAL_I) || `ddptype(`LOAD) || `ddptype(`STORE) || `ddptype(`BRANCH) || `ddptype(`JUMP_R) || `ddptype(`CMOV)) ? `drs : 
	(`ddptype(`JUMP_I) || `ddptype(`NOP)) : `ZERO : 
	`ZERO;

assign d_reg2 = 
	(`ddptype(`CAL_R) || `ddptype(`STORE) || `ddptype(`BRANCH) || `ddptype(`CMOV)) ? `drt : 
	`ZERO;

assign d_regw = 
	(`ddptype(`CAL_R)) ? `drd : 
	(`ddptype(`CAL_I) || `ddptype(`LOAD)) ? `drt : 
	(`ddptype(`JUMP_I)) ? (
		(`dkind(`JAL)) ? `RA : 
		(`dkine(`J)) ? `ZERO : 
		`ZERO
	) : 
	(`ddptype(`CMOV)) ? (
		(`dkind(`MOVZ) && rf_read_result2 == 32'b0) ? `drd : 
		`ZERO
	) : 
	`ZERO;

/* Forward control */

assign cw_fm_d1 = 
	(fwable(d_reg1, e_regw) && `edptype(`CMOV)) ? `E2D_rf : 
	(fwable(d_reg1, e_regw) && `edptype(`JUMP_I)) ? `E2D_npc : 
	(fwable(d_reg1, m_regw) && `mdptype(`JUMP_I)) ? `M2D_npc : 
	(fwable(d_reg1, m_regw) && (`mdptype(`CAL_R) || `mdptype(`CAL_I) || `mdptype(`CMOV)) ? `M2D_alu : 
	(fwable(d_reg1, w_regw)) ? `W2D_rf : 
	`orig;

assign cw_fm_e1 = 
	(fwable(e_reg1, m_regw) && `mdptype(`JUMP_I)) ? `M2E_npc : 
	(fwable(e_reg1, m_regw) && (`mdptype(`CAL_R) || `mdptype(`CAL_I) || `mdptype(`CMOV)) ? `M2E_alu : 
	(fwable(e_reg1, w_regw)) ? `W2E_rf : 
	`orig;

/* Edit cw_fm_[de]1 instead */

assign cw_fm_d2 = 
	(fwable(d_reg2, e_regw) && `edptype(`CMOV)) ? `E2D_rf : 
	(fwable(d_reg2, e_regw) && `edptype(`JUMP_I)) ? `E2D_npc : 
	(fwable(d_reg2, m_regw) && `mdptype(`JUMP_I)) ? `M2D_npc : 
	(fwable(d_reg2, m_regw) && (`mdptype(`CAL_R) || `mdptype(`CAL_I) || `mdptype(`CMOV)) ? `M2D_alu : 
	(fwable(d_reg2, w_regw)) ? `W2D_rf : 
	`orig;

assign cw_fm_e2 = 
	(fwable(e_reg2, m_regw) && `mdptype(`JUMP_I)) ? `M2E_npc : 
	(fwable(e_reg2, m_regw) && (`mdptype(`CAL_R) || `mdptype(`CAL_I) || `mdptype(`CMOV)) ? `M2E_alu : 
	(fwable(e_reg2, w_regw)) ? `W2E_rf : 
	`orig;

assign cw_fm_m = 
	(fwable(m_reg2, w_regw)) ? `W2M_rf : 
	`orig;

/* Stall control */

assign t_use_reg1 = 
	(`ddptype(`CAL_R) || `ddptype(`CAL_I) || `ddptype(`LOAD) || `ddptype(`STORE) || `ddptype(`BRANCH)) ? 3'd1 : 
	(`ddptype(`JUMP_R) || `ddptype(`CMOV)) ? 3'd0 : 
	`inf;

assign t_use_reg2 = 
	(`ddptype(`STORE)) ? 3'd2 : 
	(`ddptype(`CAL_R) || `ddptype(`CAL_I) || `ddptype(`BRANCH)) ? 3'd1 : 
	(`ddptype(`CMOV)) ? 3'd0 : 
	`inf;

assign t_new_e = 
	(`edptype(`LOAD) || `edptype(`STORE)) ? 3'd2 : 
	(`edptype(`CAL_R) || `edptype(`CAL_I)) ? 3'd1 : 
	3'd0;

assign t_new_m = 
	(`edptype(`LOAD) || `edptype(`STORE)) ? 3'd1 : 
	3'd0;

assign stall = 
	$unsigned(t_use_reg1) < $unsigned(t_new_e) || 
	$unsigned(t_use_reg1) < $unsigned(t_new_m) || 
	$unsigned(t_use_reg2) < $unsigned(t_new_e) || 
	$unsigned(t_use_reg2) < $unsigned(t_new_m);

/* TODO: more thorough stall control? */

assign cw_f_pc_enable = ~stall;

assign cw_d_pff_enable = ~stall;

endmodule

