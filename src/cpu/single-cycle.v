`include "control.h"

`include "npc.h"
`include "pc.h"
`include "im.h"

`include "rf.h"

`include "alu.h"

`include "dm.h"

module cpu(
	input clk
)

/* Control */

/* wire declarations */

wire w_control_curr_instr;
wire cm_rf_write_addr, cm_rf_write_data, cm_alu_num2;
wire cw_npc_jump_mode, cw_pc_enable, cw_im_enable, cw_rf_write_enable, cw_alu_op, cw_ext_mode, cw_dm_write_enable;

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

wire w_npc_curr_pc;
wire w_pc_next_pc;
wire w_im_addr;
wire wo_im_result;
/* break circular dependency of im and control */
assign w_control_curr_instr = wo_im_result;

/* ID / WB */

wire [4:0] m_rf_write_addr, [31:0] m_rf_write_data;
wire [4:0] w_rf_write_addr, [31:0] w_rf_write_data;
wire [15:0] wo_ext_result;

/* EX */

wire [31:0] m_alu_num2; 
wire [31:0] w_alu_num1;
wire [31:0] wo_alu_result;
wire [1:0] wo_alu_comp_result;

/* MEM */

wire [31:0] wo_dm_read_result;

/* module references */

/* IF */

npc npc(
	.curr_pc(w_npc_curr_pc), 
	.jump_mode(cw_npc_jump_mode), 
	.alu_comp_result(wo_alu_comp_result), 
	.num(w_im_data[15:0]), 
	.next_pc(w_pc_next_pc)
)

pc pc(
	.clk(clk), 
	.next_pc(w_pc_next_pc), 
	.enable(cw_pc_enable), 
	.curr_pc(w_im_addr)
)

im im(
	.addr(w_im_addr), 
	.enable(cw_im_enable), 
	.result(w_control_curr_instr, w_im_result)
)

/* ID / WB */

mux2 m_rf_write_addr(
	.BIT_WIDTH(5), 
	.control(cm_rf_write_addr), 
	.result(m_rf_write_addr), 
	.input0(wo_im_result[20:16]), 
	.input1(wo_im_result[15:11])
)

mux2 m_rf_write_data(
	.BIT_WIDTH(32), 
	.control(cm_rf_write_data), 
	.result(m_rf_write_data), 
	.input0(w_alu_result), 
	.input1(w_dm_read_result)
)

rf rf(
	.clk(clk), 
	.read_addr1(wo_im_result[25:21]), 
	.read_addr2(wo_im_result[20:16]), 
	.write_addr(m_rf_write_addr), 
	.write_data(m_rf_write_data), 
	.write_enable(cw_write_enable), 
	.read_result1(w_alu_num1), 
	.read_result2(wo_rf_read_result2) 
)

ext ext(
	.num(wo_im_result[15:0]), 
	.mode(cw_ext_mode), 
	.result(wo_ext_result)
)

/* EX */

mux2 m_alu_num2(
	.BIT_WIDTH(32), 
	.control(cm_alu_num2), 
	.result(m_alu_num2), 
	.input0(wo_rf_read_result2), 
	.input1(wo_ext_result)
)

alu alu(
	.num1(w_alu_num1), 
	.num2(m_alu_num2), 
	.op(cw_alu_op), 
	.result(wo_alu_result), 
	.comp_result(wo_alu_comp_result), 
	/* unused */
	.sig_comp_result(), 
	/* unused */
	.overflow(), 
	/* unused */
	.op_invalid()
)

/* MEM */

dm dm(
	.clk(clk), 
	.read_addr(wo_alu_result), 
	.write_addr(wo_alu_result), 
	.write_data(wo_rf_read_result2), 
	.write_enable(cw_write_enable), 
	.read_result(wo_dm_read_result), 
)

endmodule
