`include "single-cycle.h"

`include "npc.h"
`include "pc.h"
`include "im.h"

`include "rf.h"

`include "alu.h"

`include "dm.h"

module cpu(
	input clk
);

/* Control */

/* wire declarations */

wire [31:0] w_control_curr_instr;
wire cm_rf_write_addr, cm_rf_write_data, cm_alu_num2;
wire cw_pc_enable, cw_im_enable, cw_rf_write_enable, cw_dm_write_enable;
wire [2:0] cw_npc_jump_mode;
wire [4:0] cw_alu_op;
wire [2:0] cw_ext_mode;

/* module references */

control control(
	.curr_instr(w_control_curr_instr), 
	.cm_rf_write_addr(cm_rf_write_addr), 
	.cm_rf_write_data(cm_rf_write_data), 
	.cm_alu_num2(cm_alu_num2), 
	.cw_npc_jump_mode(cw_npc_jump_mode), 
	.cw_pc_enable(cw_pc_enable), 
	.cw_im_enable(cw_im_enable), 
	.cw_rf_write_enable(cw_rf_write_enable), 
	.cw_alu_op(cw_alu_op), 
	.cw_ext_mode(cw_ext_mode), 
	.cw_dm_write_enable(cw_dm_write_enable)
);

/* wire declarations */

/* IF */

wire [31:0] w_pc_next_pc;
wire [31:0] w_im_addr;
wire [31:0] wo_im_result;
/* break circular dependency of im and control */
assign w_control_curr_instr = wo_im_result;

/* ID / WB */

wire [4:0] mo_rf_write_addr;
wire [31:0] mo_rf_write_data;
wire [31:0] wo_ext_result;
wire [31:0] wo_rf_read_result2;

/* EX */

wire [31:0] mo_alu_num2;
wire [31:0] w_alu_num1;
wire [31:0] wo_alu_result;
wire [1:0] wo_alu_comp_result;

/* MEM */

wire [31:0] wo_dm_read_result;

/* module references */

/* IF */

npc npc(
	.curr_pc(w_im_addr), 
	.jump_mode(cw_npc_jump_mode), 
	.alu_comp_result(wo_alu_comp_result), 
	.num(wo_im_result[15:0]), 
	.next_pc(w_pc_next_pc)
);

pc pc(
	.clk(clk), 
	.next_pc(w_pc_next_pc), 
	.enable(cw_pc_enable), 
	.curr_pc(w_im_addr)
);

im im(
	.addr(w_im_addr), 
	.enable(cw_im_enable), 
	.result(wo_im_result)
);

/* ID / WB */

mux2 #(.BIT_WIDTH(5)) m_rf_write_addr (
	.control(cm_rf_write_addr), 
	.result(mo_rf_write_addr), 
	.input0(wo_im_result[20:16]), 
	.input1(wo_im_result[15:11])
);

mux2 #(.BIT_WIDTH(32)) m_rf_write_data (
	.control(cm_rf_write_data), 
	.result(mo_rf_write_data), 
	.input0(wo_alu_result), 
	.input1(wo_dm_read_result)
);

rf rf(
	.clk(clk), 
	.read_addr1(wo_im_result[25:21]), 
	.read_addr2(wo_im_result[20:16]), 
	.write_addr(mo_rf_write_addr), 
	.write_data(mo_rf_write_data), 
	.write_enable(cw_write_enable), 
	.read_result1(w_alu_num1), 
	.read_result2(wo_rf_read_result2) 
);

ext ext(
	.num(wo_im_result[15:0]), 
	.mode(cw_ext_mode), 
	.result(wo_ext_result)
);

/* EX */

mux2 #(.BIT_WIDTH(32)) m_alu_num2 (
	.control(cm_alu_num2), 
	.result(mo_alu_num2), 
	.input0(wo_rf_read_result2), 
	.input1(wo_ext_result)
);

alu alu(
	.num1(w_alu_num1), 
	.num2(mo_alu_num2), 
	.op(cw_alu_op), 
	.result(wo_alu_result), 
	.comp_result(wo_alu_comp_result), 
	/* unused */
	.sig_comp_result(), 
	/* unused */
	.overflow(), 
	/* unused */
	.op_invalid()
);

/* MEM */

dm dm(
	.clk(clk), 
	.read_addr(wo_alu_result), 
	.write_addr(wo_alu_result), 
	.write_data(wo_rf_read_result2), 
	.write_enable(cw_write_enable), 
	.read_result(wo_dm_read_result)
);

endmodule

