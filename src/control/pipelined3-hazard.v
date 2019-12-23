`include "instr-id.h"
`include "pipelined3.h"

module hazard(
	input [9:0] dkind, 
	input [9:0] ekind, 
	input [9:0] mkind, 
	input [9:0] wkind, 
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
	input e_md_busy, 
	input [31:0] d_instr, 
	input [31:0] e_instr, 
	input [31:0] m_instr, 
	input [31:0] w_instr, 

	output stall_f, 
	output stall_d, 
	output cw_f_pc_enable_orig, 
	output cw_d_pff_enable, 
	output cw_d_pff_rst_orig, 
	output cw_e_pff_rst_orig
);

wire [4:0] ddptype;
wire [4:0] edptype;
wire [4:0] mdptype;
wire [4:0] wdptype;

wire [2:0] t_use_reg1;
wire [2:0] t_use_reg2;
wire [2:0] t_new_e;
wire [2:0] t_new_m;

wire stall_e2d_reg1, stall_m2d_reg1, stall_e2d_reg2, stall_m2d_reg2, stall_md_busy, stall_tnew_mtc0_eret;

assign ddptype = dkind[9:5];
assign edptype = ekind[9:5];
assign mdptype = mkind[9:5];
assign wdptype = wkind[9:5];

/* Stall control */

assign t_use_reg1 = 
	(ddptype == `CAL_R || ddptype == `CAL_I || ddptype == `LOAD || ddptype == `STORE || ddptype == `CAL_M || ddptype == `STORE_M) ? 3'd1 : 
	(ddptype == `BRANCH || ddptype == `JUMP_R || ddptype == `CMOV) ? 3'd0 : 
	`inf;

assign t_use_reg2 = 
	(ddptype == `STORE || ddptype == `STORE_C0) ? 3'd2 : 
	(ddptype == `CAL_R || ddptype == `CAL_I || ddptype == `CAL_M || ddptype == `STORE_M) ? 3'd1 : 
	(ddptype == `BRANCH || ddptype == `CMOV) ? 3'd0 : 
	`inf;

assign t_new_e = 
	(edptype == `LOAD || edptype == `LOAD_C0) ? 3'd2 : 
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

assign stall_tnew_mtc0_eret = 
	ddptype == `JUMP_C0 && 
	(edptype == `STORE_C0 && `RT(e_instr) != 0 && `RD(e_instr) == `cp0_epc) && 
	(`fwable(e_reg2, m_regw)) && 
	($unsigned(t_new_m) > $unsigned(0));

assign stall_d = stall_e2d_reg1 | stall_m2d_reg1 | stall_e2d_reg2 | stall_m2d_reg2 | stall_md_busy | stall_tnew_mtc0_eret;

assign stall_f = (ddptype == `STORE_TLB || edptype == `STORE_TLB || mdptype == `STORE_TLB);

assign {cw_f_pc_enable_orig, cw_d_pff_enable, cw_d_pff_rst_orig, cw_e_pff_rst_orig} = 
	/* Remember the precedence! */
	(stall_f == 1'b1) ? {1'b0, 1'b0, 1'b1, 1'b0} : 
	(stall_d == 1'b1) ? {1'b0, 1'b0, 1'b0, 1'b1} : 
	{1'b1, 1'b1, 1'b0, 1'b0};

endmodule

