`include "instr-id.h"
`include "pipelined2.h"

`define PART_NAME "instr-id"

`include "debug/debug.h"

`include "alu.h"
`include "ext.h"
`include "npc.h"
`include "md.h"
`include "dm.h"

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

wire r, regimm;
wire rs_zero, rt_zero, rd_zero, shamt_zero;

assign r = (`OP(instr) == 6'b000000);
assign regimm = (`OP(instr) == 6'b000001);

assign rs_zero = (`RS(instr) == 5'b00000);
assign rt_zero = (`RT(instr) == 5'b00000);
assign rd_zero = (`RD(instr) == 5'b00000);
assign shamt_zero = (`SHAMT(instr) == 5'b00000);

assign result = 
	(r && `FUNCT(instr) == 6'b100001 && shamt_zero) ? `ADDU : 
	(r && `FUNCT(instr) == 6'b100011 && shamt_zero) ? `SUBU : 
	(r && `FUNCT(instr) == 6'b100000 && shamt_zero) ? `ADD : 
	(r && `FUNCT(instr) == 6'b100010 && shamt_zero) ? `SUB : 
	(r && `FUNCT(instr) == 6'b000000 && rs_zero) ? `SLL : 
	(r && `FUNCT(instr) == 6'b000010 && rs_zero) ? `SRL : 
	(r && `FUNCT(instr) == 6'b000011 && rs_zero) ? `SRA : 
	(r && `FUNCT(instr) == 6'b100100 && shamt_zero) ? `AND : 
	(r && `FUNCT(instr) == 6'b100101 && shamt_zero) ? `OR : 
	(r && `FUNCT(instr) == 6'b100111 && shamt_zero) ? `NOR : 
	(r && `FUNCT(instr) == 6'b100110 && shamt_zero) ? `XOR : 
	(r && `FUNCT(instr) == 6'b101010 && shamt_zero) ? `SLT : 
	(r && `FUNCT(instr) == 6'b101011 && shamt_zero) ? `SLTU : 
	(r && `FUNCT(instr) == 6'b000100 && shamt_zero) ? `SLLV : 
	(r && `FUNCT(instr) == 6'b000110 && shamt_zero) ? `SRLV : 
	(r && `FUNCT(instr) == 6'b000111 && shamt_zero) ? `SRAV : 

	(`OP(instr) == 6'b001111 && rs_zero) ? `LUI : 
	(`OP(instr) == 6'b001101) ? `ORI : 
	(`OP(instr) == 6'b001000) ? `ADDI : 
	(`OP(instr) == 6'b001001) ? `ADDIU : 
	(`OP(instr) == 6'b001100) ? `ANDI : 
	(`OP(instr) == 6'b001110) ? `XORI : 
	(`OP(instr) == 6'b001010) ? `SLTI : 
	(`OP(instr) == 6'b001011) ? `SLTIU : 

	(`OP(instr) == 6'b100011) ? `LW : 
	(`OP(instr) == 6'b100001) ? `LH : 
	(`OP(instr) == 6'b100101) ? `LHU : 
	(`OP(instr) == 6'b100000) ? `LB : 
	(`OP(instr) == 6'b100100) ? `LBU : 

	(`OP(instr) == 6'b101011) ? `SW : 
	(`OP(instr) == 6'b101001) ? `SH : 
	(`OP(instr) == 6'b101000) ? `SB : 

	(`OP(instr) == 6'b000100) ? `BEQ : 
	(`OP(instr) == 6'b000101) ? `BNE : 
	(`OP(instr) == 6'b000110) ? `BLEZ : 
	(regimm && `RT(instr) == 5'b00001) ? `BGEZ : 
	(regimm && `RT(instr) == 6'b00000) ? `BLTZ : 
	(`OP(instr) == 6'b000111 && rt_zero) ? `BGTZ : 

	(`OP(instr) == 6'b000010) ? `J : 
	(`OP(instr) == 6'b000011) ? `JAL : 

	(r && `FUNCT(instr) == 6'b001000 && rt_zero && rd_zero) ? `JR : 
	(r && `FUNCT(instr) == 6'b001001 && rt_zero) ? `JALR : 

	(r && `FUNCT(instr) == 6'b001010 && `SHAMT(instr) == 5'b00000) ? `MOVZ : 

	(r && `FUNCT(instr) == 6'b011000 && rd_zero && shamt_zero) ? `MULT : 
	(r && `FUNCT(instr) == 6'b011001 && rd_zero && shamt_zero) ? `MULTU : 
	(r && `FUNCT(instr) == 6'b011010 && rd_zero && shamt_zero) ? `DIV : 
	(r && `FUNCT(instr) == 6'b011011 && rd_zero && shamt_zero) ? `DIVU : 

	(r && `FUNCT(instr) == 6'b010000 && rs_zero && rt_zero && shamt_zero) ? `MFHI : 
	(r && `FUNCT(instr) == 6'b010010 && rs_zero && rt_zero && shamt_zero) ? `MFLO : 

	(r && `FUNCT(instr) == 6'b010001 && rt_zero && rd_zero && shamt_zero) ? `MTHI : 
	(r && `FUNCT(instr) == 6'b010011 && rt_zero && rd_zero && shamt_zero) ? `MTLO : 

	`UNKNOWN;

endmodule

module control(
	input clk, 
	input [31:0] d_instr, 
	input [31:0] rf_read_result2, 
	input e_md_busy, 
	output cw_f_pc_enable, 
	output cw_d_pff_enable, 
	output cw_e_pff_rst, 
	output [3:0] cw_f_npc_jump_mode, 
	output [2:0] cw_d_ext_mode, 
	output [4:0] cw_d_rf_read_addr1, 
	output [4:0] cw_d_rf_read_addr2, 
	output cw_e_m_alusrc, 
	output [4:0] cw_e_alu_op, 
	output [3:0] cw_e_md_op, 
	output cw_m_hilo, 
	output cw_m_dm_write_enable, 
	output [2:0] cw_m_dm_mode, 
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
		(dkind == `BEQ) ? `NPC_EQUAL : 
		(dkind == `BNE) ? `NPC_NOT_EQUAL : 
		(dkind == `BLEZ) ? `NPC_SIG_SMALLER_OR_EQUAL : 
		(dkind == `BGEZ) ? `NPC_SIG_LARGER_OR_EQUAL : 
		(dkind == `BLTZ) ? `NPC_SIG_SMALLER : 
		(dkind == `BGTZ) ? `NPC_SIG_LARGER : 
		`NPC_JUMP_DISABLED
	) : 
	(ddptype == `JUMP_I) ? `NPC_J : 
	(ddptype == `JUMP_R) ? `NPC_REG : 
	`NPC_JUMP_DISABLED;

assign cw_d_ext_mode = 
	(ddptype == `CAL_I) ? (
		(dkind == `LUI) ? `EXT_MODE_PAD : 
		(dkind == `ORI) ? `EXT_MODE_UNSIGNED : 
		(dkind == `ADDI) ? `EXT_SIGNED : 
		(dkind == `ADDIU) ? `EXT_SIGNED : 
		(dkind == `ANDI) ? `EXT_UNSIGNED : 
		(dkind == `XORI) ? `EXT_UNSIGNED : 
		(dkind == `SLTI) ? `EXT_SIGNED : 
		(dkind == `SLTIU) ? `EXT_SIGNED : 
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
		(ekind == `ADD) ? `ALU_ADD : 
		(ekind == `SUB) ? `ALU_SUB : 
		(ekind == `AND) ? `ALU_AND : 
		(ekind == `OR) ? `ALU_OR : 
		(ekind == `NOR) ? `ALU_NOR : 
		(ekind == `XOR) ? `ALU_XOR : 
		(ekind == `SLT) ? `ALU_SLT : 
		(ekind == `SLTU) ? `ALU_SLTU : 
		(ekind == `SLL) ? `ALU_SLL : 
		(ekind == `SRL) ? `ALU_SRL : 
		(ekind == `SRA) ? `ALU_SRA : 
		(ekind == `SLLV) ? `ALU_SLLV : 
		(ekind == `SRLV) ? `ALU_SRLV : 
		(ekind == `SRAV) ? `ALU_SRAV : 
		`ALU_OR
	) : 

	(edptype == `CAL_I) ? (
		(ekind == `LUI) ? `ALU_OR : 
		(ekind == `ORI) ? `ALU_OR : 
		(ekind == `ADDI) ? `ALU_ADD : 
		(ekind == `ADDIU) ? `ALU_ADD : 
		(ekind == `ANDI) ? `ALU_AND : 
		(ekind == `XORI) ? `ALU_XOR : 
		(ekind == `SLTI) ? `ALU_SLT : 
		(ekind == `SLTIU) ? `ALU_SLTU : 
		`ALU_OR
	) : 

	(edptype == `CMOV) ? (
		(ekind == `MOVZ) ? `ALU_MOVZ : 
		`ALU_OR
	) : 
	(edptype == `LOAD || edptype == `STORE) ? `ALU_ADD : 
	`ALU_OR;

assign cw_e_md_op = 
	(edptype == `CAL_M) ? (
		(ekind == `MULT) ? `MD_MULT : 
		(ekind == `MULTU) ? `MD_MULTU : 
		(ekind == `DIV) ? `MD_DIV : 
		(ekind == `DIVU) ? `MD_DIVU :
		`MD_NONE
	) : 
	(edptype == `LOAD_M) ? (
		(ekind == `MFHI) ? `MD_MFHI : 
		(ekind == `MFLO) ? `MD_MFLO : 
		`MD_NONE
	) : 
	(edptype == `STORE_M) ? (
		(ekind == `MTHI) ? `MD_MTHI : 
		(ekind == `MTLO) ? `MD_MTLO : 
		`MD_NONE
	) : 
	`MD_NONE;

assign cw_m_hilo = 
	(edptype == `LOAD_M) ? (
		(ekind == `MFHI) ? 1'b0 : 
		(ekind == `MFLO) ? 1'b1 : 
		1'b0
	) : 
	1'b0;

assign cw_m_dm_write_enable = 
	(mdptype == `STORE) ? 1'b1 : 
	1'b0;

assign cw_m_dm_mode = 
	(mdptype == `LOAD) ? (
		(mkind == `LW) ? `DM_W : 
		(mkind == `LH) ? `DM_H : 
		(mkind == `LHU) ? `DM_HU : 
		(mkind == `LB) ? `DM_B : 
		(mkind == `LBU) ? `DM_BU : 
		`DM_NONE
	) : 
	(mdptype == `STORE) ? (
		(mkind == `SW) ? `DM_W : 
		(mkind == `SH) ? `DM_H : 
		(mkind == `SB) ? `DM_B : 
		`DM_NONE
	) : 
	`DM_NONE;

assign cw_w_rf_write_enable = 
	(wdptype == `CAL_R || wdptype == `CAL_I || wdptype == `LOAD || wdptype == `JUMP_I || wdptype == `JUMP_R || wdptype == `CMOV || wdptype == `LOAD_M) ? 1'b1 : 
	1'b0;

/* See doc/datapath/pipelined.md */

assign cw_w_m_regdata = 
	(wdptype == `CAL_R || wdptype == `CAL_I || wdptype == `CMOV) ? 3'd1 : 
	(wdptype == `LOAD) ? 3'd2 : 
	(wdptype == `JUMP_I || wdptype == `JUMP_R) ? 3'd3 : 
	(wdptype == `LOAD_M) ? 3'd4 : 
	3'd0;

assign cw_w_rf_write_addr = w_regw;

/* Register identification */

assign d_reg1 = 
	(ddptype == `CAL_R || ddptype == `CAL_I || ddptype == `LOAD || ddptype == `STORE || ddptype == `BRANCH || ddptype == `JUMP_R || ddptype == `CMOV || ddptype == `CAL_M || ddptype == `STORE_M) ? `drs : 
	`ZERO;

assign d_reg2 = 
	(ddptype == `CAL_R || ddptype == `CAL_I || ddptype == `STORE || ddptype == `CMOV || ddptype == `CAL_M) ? `drt : 
	(ddptype == `BRANCH) ? (
		(dkind == `BEQ) ? `drt : 
		(dkind == `BNE) ? `drt : 
		(dkind == `BLEZ) ? `ZERO : 
		(dkind == `BGEZ) ? `ZERO : 
		(dkind == `BLTZ) ? `ZERO : 
		(dkind == `BGTZ) ? `ZERO : 
		`ZERO
	) : 
	`ZERO;

assign d_regw = 
	(ddptype == `CAL_R || ddptype == `LOAD_M) ? `drd : 
	(ddptype == `CAL_I || ddptype == `LOAD) ? `drt : 
	(ddptype == `JUMP_I) ? (
		(dkind == `JAL) ? `RA : 
		(dkind == `J) ? `ZERO : 
		`ZERO
	) : 
	(ddptype == `JUMP_R) ? (
		(dkind == `JR) ? `ZERO : 
		(dkind == `JALR) ? `drd : 
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
	(`fwable(d_reg1, e_regw) && (edptype == `JUMP_I || edptype == `JUMP_R)) ? `E2D_npc : 
	(`fwable(d_reg1, e_regw) && edptype == `LOAD_M) ? `E2D_md : 
	(`fwable(d_reg1, m_regw) && (mdptype == `JUMP_I || mdptype == `JUMP_R)) ? `M2D_npc : 
	(`fwable(d_reg1, m_regw) && (mdptype == `CAL_R || mdptype == `CAL_I || mdptype == `CMOV)) ? `M2D_alu : 
	(`fwable(d_reg1, m_regw) && mdptype == `LOAD_M) ? `M2D_md : 
	(`fwable(d_reg1, w_regw)) ? `W2D_rf : 
	`orig;

assign cw_fm_e1 = 
	(`fwable(e_reg1, m_regw) && (mdptype == `JUMP_I || mdptype == `JUMP_R)) ? `M2E_npc : 
	(`fwable(e_reg1, m_regw) && (mdptype == `CAL_R || mdptype == `CAL_I || mdptype == `CMOV)) ? `M2E_alu : 
	(`fwable(e_reg1, m_regw) && mdptype == `LOAD_M) ? `M2E_md : 
	(`fwable(e_reg1, w_regw)) ? `W2E_rf : 
	`orig;

/* Edit cw_fm_[de]1 instead */

assign cw_fm_d2 = 
	(`fwable(d_reg2, e_regw) && edptype == `CMOV) ? `E2D_rf : 
	(`fwable(d_reg2, e_regw) && (edptype == `JUMP_I || edptype == `JUMP_R)) ? `E2D_npc : 
	(`fwable(d_reg2, e_regw) && edptype == `LOAD_M) ? `E2D_md : 
	(`fwable(d_reg2, m_regw) && (mdptype == `JUMP_I || mdptype == `JUMP_R)) ? `M2D_npc : 
	(`fwable(d_reg2, m_regw) && (mdptype == `CAL_R || mdptype == `CAL_I || mdptype == `CMOV)) ? `M2D_alu : 
	(`fwable(d_reg2, m_regw) && mdptype == `LOAD_M) ? `M2D_md : 
	(`fwable(d_reg2, w_regw)) ? `W2D_rf : 
	`orig;

assign cw_fm_e2 = 
	(`fwable(e_reg2, m_regw) && (mdptype == `JUMP_I || mdptype == `JUMP_R)) ? `M2E_npc : 
	(`fwable(e_reg2, m_regw) && (mdptype == `CAL_R || mdptype == `CAL_I || mdptype == `CMOV)) ? `M2E_alu : 
	(`fwable(e_reg2, m_regw) && mdptype == `LOAD_M) ? `M2E_md : 
	(`fwable(e_reg2, w_regw)) ? `W2E_rf : 
	`orig;

assign cw_fm_m = 
	(`fwable(m_reg2, w_regw)) ? `W2M_rf : 
	`orig;

/* Stall control */

assign t_use_reg1 = 
	(ddptype == `CAL_R || ddptype == `CAL_I || ddptype == `LOAD || ddptype == `STORE || ddptype == `CAL_M || ddptype == `STORE_M) ? 3'd1 : 
	(ddptype == `BRANCH || ddptype == `JUMP_R || ddptype == `CMOV) ? 3'd0 : 
	`inf;

assign t_use_reg2 = 
	(ddptype == `STORE) ? 3'd2 : 
	(ddptype == `CAL_R || ddptype == `CAL_I || ddptype == `CAL_M || ddptype == `STORE_M) ? 3'd1 : 
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

assign stall_md_busy = 
	e_md_busy == 1'b1 && 
	(ddptype == `CAL_M || ddptype == `LOAD_M || ddptype == `STORE_M);

assign stall = stall_e2d_reg1 | stall_m2d_reg1 | stall_e2d_reg2 | stall_m2d_reg2 | stall_md_busy;

/* TODO: more thorough stall control? */

assign cw_f_pc_enable = ~stall;

assign cw_d_pff_enable = ~stall;

assign cw_e_pff_rst = ~stall;

endmodule

