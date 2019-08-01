module cpu(
	input clk
)

wire control_curr_instr;

/* Control */

control control(
	.clk(clk), 
	.curr_instr(control_curr_instr), 
	.cw_pc_enable(cw_pc_enable), 
	.cw_d_pff_enable(cw_d_pff_enable), 
	.cw_d_ext_mode(cw_d_ext_mode), 
	.cw_d_rf_read_addr1(cw_d_rf_read_addr1), 
	.cw_d_rf_read_addr2(cw_d_rf_read_addr2), 
	.cw_e_m_alu_num2(cw_e_m_alu_num2), 
	.cw_e_alu_op(cw_e_alu_op), 
	.cw_m_dm_write_enable(cw_m_dm_write_enable), 
	.cw_w_rf_write_enable(cw_w_rf_write_enable), 
	.cw_w_m_rf_write_data(cw_w_m_rf_write_data), 
	.cw_w_rf_write_addr(cw_w_rf_write_addr), 
	.cw_fm_d1(cw_fm_d1), 
	.cw_fm_d2(cw_fm_d2), 
	.cw_fm_e1(cw_fm_e1), 
	.cw_fm_e2(cw_fm_e2)
)

/* IF */

npc npc(
	.curr_pc(wo_pc_curr_pc), 
	.jump_mode(), /* TODO */ 
	.alu_comp_result(wo_alu_comp_result), 
	.num(), /* TODO */
	.next_pc(wo_npc_next_pc)
)

endmodule

