`include "instr-id.h"
`include "pipelined3.h"

`include "alu.h"
`include "ac.h"
`include "ext.h"
`include "cp0.h"
`include "npc.h"
`include "md.h"
`include "dm.h"

/* No more function definitions since ISE would crash seeing these functions
* in modules, and iSim would refuse to simulate seeing these functions are out
* of modules. Salute to ISE! */

module kind(
	input [31:0] instr, 
	output [9:0] result
);

wire r, regimm, cop0;
wire rs_zero, rt_zero, rd_zero, shamt_zero;

assign r = (`OP(instr) == 6'b000000);
assign regimm = (`OP(instr) == 6'b000001);
assign cop0 = (`OP(instr) == 6'b010000);

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

	/* (r && `FUNCT(instr) == 6'b001010 && `SHAMT(instr) == 5'b00000) ? `MOVZ : */

	/* 
	(r && `FUNCT(instr) == 6'b011000 && rd_zero && shamt_zero) ? `MULT : 
	(r && `FUNCT(instr) == 6'b011001 && rd_zero && shamt_zero) ? `MULTU : 
	(r && `FUNCT(instr) == 6'b011010 && rd_zero && shamt_zero) ? `DIV : 
	(r && `FUNCT(instr) == 6'b011011 && rd_zero && shamt_zero) ? `DIVU : 
	*/

	(r && `FUNCT(instr) == 6'b010000 && rs_zero && rt_zero && shamt_zero) ? `MFHI : 
	(r && `FUNCT(instr) == 6'b010010 && rs_zero && rt_zero && shamt_zero) ? `MFLO : 

	(r && `FUNCT(instr) == 6'b010001 && rt_zero && rd_zero && shamt_zero) ? `MTHI : 
	(r && `FUNCT(instr) == 6'b010011 && rt_zero && rd_zero && shamt_zero) ? `MTLO : 

	(cop0 && `RS(instr) == 5'b00000 && instr[10:3] == 8'b00000000) ? `MFC0 : 
	(cop0 && `RS(instr) == 5'b00100 && instr[10:3] == 8'b00000000) ? `MTC0 : 
	(cop0 && instr == 32'h42000018) ? `ERET : 

	(cop0 && instr == 32'h42000001) ? `TLBR : 
	(cop0 && instr == 32'h42000002) ? `TLBWI : 
	(cop0 && instr == 32'h42000008) ? `TLBP : 

	`UNKNOWN;
endmodule

module control(
	input clk, 
	input rst, 
	input [31:0] d_instr, 
	input [31:0] e_instr, 
	input [31:0] m_instr, 
	input [31:0] w_instr, 

	input [31:0] rf_read_result2, 
	input e_md_busy, 
	input [31:0] m_dm_addr, 

	input f_im_valid, 
	input e_alu_sig_overflow, 
	input m_dm_valid, 
	input m_bridge_valid, 
	input [31:0] d_pc_curr_pc, 
	input [31:0] e_pc_curr_pc, 
	input [31:0] m_pc_curr_pc, 
	input have2handle, 

	output cw_mmu_write_enable, 

	output cw_f_pc_enable, 
	output cw_d_pff_enable, 
	output cw_d_pff_rst, 
	output cw_e_pff_rst, 
	output cw_m_pff_rst, 
	output cw_w_pff_rst, 

	output [3:0] cw_f_npc_jump_mode, 

	output [2:0] cw_d_ext_mode, 
	output [4:0] cw_d_rf_read_addr1, 
	output [4:0] cw_d_rf_read_addr2, 

	output cw_e_m_alusrc, 
	output [4:0] cw_e_alu_op, 
	output [3:0] cw_e_md_op, 
	output cw_e_md_stop, 
	output cw_e_md_restore, 

	output cw_m_m_bridge, 
	output cw_m_dm_write_enable, 
	output cw_m_dm_stop, 
	output [2:0] cw_m_dm_mode, 
	output [3:0] cw_m_cp0_op, 
	output cw_m_cp0_in_bds, 
	output [4:0] cw_m_cp0_exc, 
	output [31:0] cw_m_cp0_curr_pc, 

	output cw_w_rf_write_enable, 
	output [2:0] cw_w_m_regdata, 
	output [4:0] cw_w_rf_write_addr, 

	output [3:0] cw_fm_d1, 
	output [3:0] cw_fm_d2, 
	output [3:0] cw_fm_e1, 
	output [3:0] cw_fm_e2, 
	output [3:0] cw_fm_m, 
	output [3:0] cw_fm_epc
);

/* Wire and register declarations */

wire [9:0] dkind;
wire [9:0] ekind;
wire [9:0] mkind;
wire [9:0] wkind;

wire [4:0] ddptype;
wire [4:0] edptype;
wire [4:0] mdptype;
wire [4:0] wdptype;

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

wire stall_f, stall_d;
wire cw_f_pc_enable_orig, cw_d_pff_rst_orig, cw_e_pff_rst_orig;

/* F */

wire [3:0] cw_f_npc_jump_mode_orig;

/* M */

/* in_bds pipeline */
wire d_in_bds, e_in_bds, m_in_bds;

wire [3:0] cw_m_cp0_op_orig;

/* Exception ID pipeline */

wire [4:0] d_exc, e_exc, m_exc, m_exc_final;

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

assign ddptype = dkind[9:5];
assign edptype = ekind[9:5];
assign mdptype = mkind[9:5];
assign wdptype = wkind[9:5];

/* Internal pipeline */

pff #(.BIT_WIDTH(5)) e_reg1_(
	.clk(clk), 
	.enable(1'b1), 
	.rst(rst | cw_e_pff_rst), 
	.i(d_reg1), 
	.o(e_reg1)
);

pff #(.BIT_WIDTH(5)) e_reg2_(
	.clk(clk), 
	.enable(1'b1), 
	.rst(rst | cw_e_pff_rst), 
	.i(d_reg2), 
	.o(e_reg2)
);

pff #(.BIT_WIDTH(5)) e_regw_(
	.clk(clk), 
	.enable(1'b1), 
	.rst(rst | cw_e_pff_rst), 
	.i(d_regw), 
	.o(e_regw)
);

pff #(.BIT_WIDTH(5)) m_reg1_(
	.clk(clk), 
	.enable(1'b1), 
	.rst(rst | cw_m_pff_rst), 
	.i(e_reg1), 
	.o(m_reg1)
);

pff #(.BIT_WIDTH(5)) m_reg2_(
	.clk(clk), 
	.enable(1'b1), 
	.rst(rst | cw_m_pff_rst), 
	.i(e_reg2), 
	.o(m_reg2)
);

pff #(.BIT_WIDTH(5)) m_regw_(
	.clk(clk), 
	.enable(1'b1), 
	.rst(rst | cw_m_pff_rst), 
	.i(e_regw), 
	.o(m_regw)
);

pff #(.BIT_WIDTH(5)) w_reg1_(
	.clk(clk), 
	.enable(1'b1), 
	.rst(rst | cw_w_pff_rst), 
	.i(m_reg1), 
	.o(w_reg1)
);

pff #(.BIT_WIDTH(5)) w_reg2_(
	.clk(clk), 
	.enable(1'b1), 
	.rst(rst | cw_w_pff_rst), 
	.i(m_reg2), 
	.o(w_reg2)
);

pff #(.BIT_WIDTH(5)) w_regw_(
	.clk(clk), 
	.enable(1'b1), 
	.rst(rst | cw_w_pff_rst), 
	.i(m_regw), 
	.o(w_regw)
);

/* Normal control signals */

/* npc.jump_mode is controlled by the instruction in level E */

assign cw_f_npc_jump_mode_orig = 
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
	(ddptype == `JUMP_C0) ? `NPC_EPC : 
	`NPC_JUMP_DISABLED;

assign cw_d_ext_mode = 
	(ddptype == `CAL_I) ? (
		(dkind == `LUI) ? `EXT_MODE_PAD : 
		(dkind == `ORI) ? `EXT_MODE_UNSIGNED : 
		(dkind == `ADDI) ? `EXT_MODE_SIGNED : 
		(dkind == `ADDIU) ? `EXT_MODE_SIGNED : 
		(dkind == `ANDI) ? `EXT_MODE_UNSIGNED : 
		(dkind == `XORI) ? `EXT_MODE_UNSIGNED : 
		(dkind == `SLTI) ? `EXT_MODE_SIGNED : 
		(dkind == `SLTIU) ? `EXT_MODE_SIGNED : 
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
		(ekind == `ADDU) ? `ALU_ADDU : 
		(ekind == `SUBU) ? `ALU_SUBU : 
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
		(ekind == `ADDIU) ? `ALU_ADDU : 
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

assign cw_m_m_bridge = 
	($unsigned(m_dm_addr) >= `DM_ADDR_LB && $unsigned(m_dm_addr) <= `DM_ADDR_UB) ? 1'b0 : 
	1'b1;

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
	(wdptype == `CAL_R || wdptype == `CAL_I || wdptype == `LOAD || wdptype == `JUMP_I || wdptype == `JUMP_R || wdptype == `CMOV || wdptype == `LOAD_M || wdptype == `LOAD_C0) ? 1'b1 : 
	1'b0;

/* See doc/datapath/pipelined.md */

assign cw_w_m_regdata = 
	(wdptype == `CAL_R || wdptype == `CAL_I || wdptype == `CMOV) ? 3'd1 : 
	(wdptype == `LOAD) ? 3'd2 : 
	(wdptype == `JUMP_I || wdptype == `JUMP_R) ? 3'd3 : 
	(wdptype == `LOAD_M) ? 3'd4 : 
	(wdptype == `LOAD_C0) ? 3'd5 : 
	3'd0;

assign cw_w_rf_write_addr = w_regw;

/* Register identification */

assign d_reg1 = 
	(ddptype == `CAL_R || ddptype == `CAL_I || ddptype == `LOAD || ddptype == `STORE || ddptype == `BRANCH || ddptype == `JUMP_R || ddptype == `CMOV || ddptype == `CAL_M || ddptype == `STORE_M) ? `drs : 
	`ZERO;

assign d_reg2 = 
	(ddptype == `CAL_R || ddptype == `STORE || ddptype == `CMOV || ddptype == `CAL_M || ddptype == `STORE_C0) ? `drt : 
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
	(ddptype == `CAL_I || ddptype == `LOAD || ddptype == `LOAD_C0) ? `drt : 
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

forward forward(
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
	.d_instr(d_instr), 
	.e_instr(e_instr), 
	.m_instr(m_instr), 
	.w_instr(w_instr), 
	.cw_fm_d1(cw_fm_d1), 
	.cw_fm_e1(cw_fm_e1), 
	.cw_fm_d2(cw_fm_d2), 
	.cw_fm_e2(cw_fm_e2), 
	.cw_fm_m(cw_fm_m), 
	.cw_fm_epc(cw_fm_epc)
);

/* Stall control */

hazard hazard(
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
	.e_md_busy(e_md_busy), 
	.d_instr(d_instr), 
	.e_instr(e_instr), 
	.m_instr(m_instr), 
	.w_instr(w_instr), 

	.stall_f(stall_f), 
	.stall_d(stall_d), 
	.cw_f_pc_enable_orig(cw_f_pc_enable_orig), 
	.cw_d_pff_enable(cw_d_pff_enable), 
	.cw_d_pff_rst_orig(cw_d_pff_rst_orig), 
	.cw_e_pff_rst_orig(cw_e_pff_rst_orig)
);

/* in_bds pipeline */

/* NOTE: d_in_bds checks for the instruction in level D but records for the
 * instruction in level F */

pff #(.BIT_WIDTH(1)) d_in_bds_(
	.clk(clk), 
	.enable(cw_d_pff_enable), 
	.rst(rst | cw_d_pff_rst), 
	.i(
		(ddptype == `JUMP_I || ddptype == `JUMP_R || ddptype == `BRANCH) ? 1'b1 : 
		1'b0
	), 
	.o(d_in_bds)
);

pff #(.BIT_WIDTH(1)) e_in_bds_(
	.clk(clk), 
	.enable(1'b1), 
	.rst(rst | cw_e_pff_rst), 
	.i(d_in_bds), 
	.o(e_in_bds)
);

pff #(.BIT_WIDTH(1)) m_in_bds_(
	.clk(clk), 
	.enable(1'b1), 
	.rst(rst | cw_m_pff_rst), 
	.i(e_in_bds), 
	.o(m_in_bds)
);

/* Exception ID pipeline */

/* Remember the precedence! */

pff #(.BIT_WIDTH(5)) d_exc_(
	.clk(clk), 
	.enable(cw_d_pff_enable), 
	.rst(rst | cw_d_pff_rst), 
	.i(
		(ddptype == `JUMP_C0) ? `EXC_NONE : 
		(f_im_valid == 1'b0) ? `EXC_ADEL : 
		`EXC_NONE
	), 
	.o(d_exc)
);

pff #(.BIT_WIDTH(5)) e_exc_(
	.clk(clk), 
	.enable(1'b1), 
	.rst(rst | cw_e_pff_rst), 
	.i(
		(d_exc != `EXC_NONE) ? d_exc : 
		(dkind == `UNKNOWN) ? `EXC_RI : 
		d_exc
	), 
	.o(e_exc)
);

pff #(.BIT_WIDTH(5)) m_exc_(
	.clk(clk), 
	.enable(1'b1), 
	.rst(rst | cw_m_pff_rst), 
	.i(
		(e_exc != `EXC_NONE) ? e_exc : 
		((edptype == `CAL_R || edptype == `CAL_I) && e_alu_sig_overflow == 1'b1) ? `EXC_OV : 
		(edptype == `LOAD && e_alu_sig_overflow == 1'b1) ? `EXC_ADEL : 
		(edptype == `STORE && e_alu_sig_overflow == 1'b1) ? `EXC_ADES : 
		e_exc
	), 
	.o(m_exc)
);

assign m_exc_final = 
	(m_exc != `EXC_NONE) ? m_exc : 
	(m_dm_valid == 1'b0 && m_bridge_valid == 1'b0) ? (
		/* DM_NONEs are always valid */
		(cw_m_dm_write_enable == 1'b0) ? `EXC_ADEL : 
		`EXC_ADES
	) : 
	m_exc;

/* MMU control signals */

/* Currently only used in STORE_TLB instructions. */
assign cw_mmu_write_enable = 
	(mdptype == `STORE_TLB) ? 1'b1 : 
	1'b0;

/* Coprocessor 0 control signals */

assign cw_m_cp0_op_orig = 
	(mdptype == `STORE_C0) ? `CP0_MTC0 : 
	/* In ISR, so don't consider interrupts. Exceptions won't reach level
	 * M when this signal would be emitted. */
	(mdptype == `JUMP_C0) ? `CP0_EXIT_ISR : 
	(mdptype == `LOAD_TLB) ? `CP0_TLBR : 
	(mdptype == `PROBE_TLB) ? `CP0_TLBP : 
	`CP0_NONE;

/* About to go into ISR when cw_m_cp0_exc != `EXC_NONE, so interrupts are
 * considered. */
assign cw_m_cp0_exc = m_exc_final;

/* There is no D level reset outside ISR, so cm_m_cp0_curr_pc must have
 * a non-zero value. 
 * NOTE: Responsibility for aligning epc is moved here. Is changing addr in
 * the top-level module mips needed? 
 * NOTE: What if the CPU jumps to 32'b0? */
assign cw_m_cp0_curr_pc = 
	/* Remember the precedence! */
	(m_pc_curr_pc != 32'b0) ? {m_pc_curr_pc[31:2], 2'b0} : 
	(e_pc_curr_pc != 32'b0) ? {e_pc_curr_pc[31:2], 2'b0} : 
	{d_pc_curr_pc[31:2], 2'b0};

/* About to go into ISR, so interrupts are considered. */
/* NOTE: There may be bubbles between the instruction in the branch delay slot 
 * and the corresponding branch instruction, so use a pipeline instead. And 
 * backtracking must be done in case of bubbles when interrupts come. */
assign cw_m_cp0_in_bds = 
	/* Remember the precedence! */
	(m_pc_curr_pc != 32'b0) ? m_in_bds : 
	(e_pc_curr_pc != 32'b0) ? e_in_bds : 
	d_in_bds;

/* Exception control */

handler handler(
	.dkind(dkind), 
	.ekind(ekind), 
	.mkind(mkind), 
	.wkind(wkind), 

	.d_exc(d_exc), 
	.e_exc(e_exc), 
	.m_exc(m_exc), 
	.m_exc_final(m_exc_final), 

	.rst(rst), 
	.have2handle(have2handle), 
	.stall_f(stall_f), 
	.stall_d(stall_d), 

	/* cw_d_pff_rst omitted */
	/* cw_e_pff_rst omitted */
	.cw_m_pff_rst(cw_m_pff_rst), 
	.cw_w_pff_rst(cw_w_pff_rst), 

	.cw_f_npc_jump_mode_orig(cw_f_npc_jump_mode_orig), 
	.cw_f_npc_jump_mode(cw_f_npc_jump_mode), 

	.cw_f_pc_enable_orig(cw_f_pc_enable_orig), 
	.cw_f_pc_enable(cw_f_pc_enable), 

	.cw_d_pff_rst_orig(cw_d_pff_rst_orig), 
	.cw_d_pff_rst(cw_d_pff_rst), 

	.cw_e_pff_rst_orig(cw_e_pff_rst_orig), 
	.cw_e_pff_rst(cw_e_pff_rst), 

	.cw_e_md_restore(cw_e_md_restore), 
	.cw_e_md_stop(cw_e_md_stop), 

	.cw_m_dm_stop(cw_m_dm_stop), 

	.cw_m_cp0_op_orig(cw_m_cp0_op_orig), 
	.cw_m_cp0_op(cw_m_cp0_op)
);

endmodule

