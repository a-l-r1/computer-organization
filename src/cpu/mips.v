`include "single-cycle.h"

`include "npc.h"
`include "pc.h"
`include "im.h"

`include "rf.h"

`include "alu.h"

`include "dm.h"

module mips(
	input clk, 
	input reset
);

/* Control */

/* wire declarations */

wire [31:0] control_curr_instr;
wire cm_rf_write_addr, cm_rf_write_data, cm_alu_num2;
wire cw_pc_enable, cw_im_enable, cw_rf_write_enable, cw_dm_write_enable;
wire [2:0] cw_npc_jump_mode;
wire [4:0] cw_alu_op;
wire [2:0] cw_ext_mode;

/* module references */

control control(
	.curr_instr(control_curr_instr), 
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

wire [31:0] npc_next_pc;
wire [31:0] pc_curr_pc;
wire [31:0] im_result;
/* break circular dependency of im and control */
assign control_curr_instr = im_result;

/* ID / WB */

wire [4:0] m_rf_write_addr;
wire [31:0] m_rf_write_data;
wire [31:0] ext_result;
wire [31:0] rf_read_result2;

/* EX */

wire [31:0] m_alu_num2;
wire [31:0] rf_read_result1;
wire [31:0] alu_result;
wire [1:0] alu_comp_result;

/* MEM */

wire [31:0] dm_read_result;

/* module references */

/* IF */

npc npc(
	.curr_pc(pc_curr_pc), 
	.jump_mode(cw_npc_jump_mode), 
	.alu_comp_result(alu_comp_result), 
	.num(im_result[15:0]), 
	.next_pc(npc_next_pc)
);

pc pc(
	.clk(clk), 
	.rst(rst), 
	.next_pc(npc_next_pc), 
	.enable(cw_pc_enable), 
	.curr_pc(pc_curr_pc)
);

im im(
	.addr(pc_curr_pc), 
	.enable(cw_im_enable), 
	.result(im_result)
);

/* ID / WB */

mux2 #(.BIT_WIDTH(5)) mux_rf_write_addr (
	.control(cm_rf_write_addr), 
	.result(m_rf_write_addr), 
	.input0(im_result[20:16]), 
	.input1(im_result[15:11])
);

mux2 #(.BIT_WIDTH(32)) mux_rf_write_data (
	.control(cm_rf_write_data), 
	.result(m_rf_write_data), 
	.input0(alu_result), 
	.input1(dm_read_result)
);

rf rf(
	.clk(clk), 
	.rst(rst), 
	.curr_pc(pc_curr_pc), 
	.read_addr1(im_result[25:21]), 
	.read_addr2(im_result[20:16]), 
	.write_addr(m_rf_write_addr), 
	.write_data(m_rf_write_data), 
	.write_enable(cw_rf_write_enable), 
	.read_result1(rf_read_result1), 
	.read_result2(rf_read_result2) 
);

ext ext(
	.num(im_result[15:0]), 
	.mode(cw_ext_mode), 
	.result(ext_result)
);

/* EX */

mux2 #(.BIT_WIDTH(32)) mux_alu_num2 (
	.control(cm_alu_num2), 
	.result(m_alu_num2), 
	.input0(rf_read_result2), 
	.input1(ext_result)
);

alu alu(
	.num1(rf_read_result1), 
	.num2(m_alu_num2), 
	.op(cw_alu_op), 
	.result(alu_result), 
	.comp_result(alu_comp_result), 
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
	.rst(rst), 
	.curr_pc(pc_curr_pc), 
	.read_addr(alu_result), 
	.write_addr(alu_result), 
	.write_data(rf_read_result2), 
	.write_enable(cw_dm_write_enable), 
	.read_result(dm_read_result)
);

endmodule

