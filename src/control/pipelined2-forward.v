`include "instr-id.h"
`include "pipelined2.h"

module forward(
	input [8:0] dkind, 
	input [8:0] ekind, 
	input [8:0] mkind, 
	input [8:0] wkind, 
	input [4:0] d_reg1, 
	input [4:0] d_reg2, 
	input [4:0] d_regw, 
	input [4:0] e_reg1, 
	input [4:0] e_reg2, 
	input [4:0] e_regw, 
	input [4:0] m_reg1, 
	input [4:0] m_reg2, 
	input [4:0] m_regw, 
	input [4:0] w_reg1, 
	input [4:0] w_reg2, 
	input [4:0] w_regw, 
	output [2:0] cw_fm_d1, 
	output [2:0] cw_fm_e1, 
	output [2:0] cw_fm_d2, 
	output [2:0] cw_fm_e2, 
	output [2:0] cw_fm_m
);

wire [3:0] ddptype;
wire [3:0] edptype;
wire [3:0] mdptype;
wire [3:0] wdptype;

assign ddptype = dkind[8:5];
assign edptype = ekind[8:5];
assign mdptype = mkind[8:5];
assign wdptype = wkind[8:5];

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

endmodule

