`include "instr-id.h"
`include "pipelined2.h"

module hazard(
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
	input e_md_busy, 
	output stall
);

`define inf 3'd7

wire [3:0] ddptype;
wire [3:0] edptype;
wire [3:0] mdptype;
wire [3:0] wdptype;

assign ddptype = dkind[8:5];
assign edptype = ekind[8:5];
assign mdptype = mkind[8:5];
assign wdptype = wkind[8:5];

wire [3:0] t_use_reg1;
wire [3:0] t_use_reg2;
wire [3:0] t_new_e;
wire [3:0] t_new_m;

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
	(ddptype == `LOAD_M || ddptype == `STORE_M);

assign stall = stall_e2d_reg1 | stall_m2d_reg1 | stall_e2d_reg2 | stall_m2d_reg2 | stall_md_busy;

endmodule
