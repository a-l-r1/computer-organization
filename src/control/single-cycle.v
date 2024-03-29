`include "single-cycle.h"

`include "alu.h"
`include "dm.h"
`include "ext.h"
`include "im.h"
`include "npc.h"
`include "pc.h"
`include "rf.h"

`define PART_NAME "control"

`include "debug/debug.h"

module control(
	input [31:0] curr_instr, 
	output cm_rf_write_addr, 
	output cm_rf_write_data, 
	output cm_alu_num2, 
	output [2:0] cw_npc_jump_mode, 
	output cw_pc_enable, 
	output cw_im_enable, 
	output cw_rf_write_enable, 
	output [4:0] cw_alu_op, 
	output [2:0] cw_ext_mode, 
	output cw_dm_write_enable
);

/* actually unused */
assign cw_pc_enable = `PC_ENABLED;
assign cw_im_enable = `IM_ENABLED;

wire [7:0] curr_instr_kind;

assign curr_instr_kind = 
	(`GET_OP(curr_instr) == `INSTR_MAGIC_RTYPE_OP && `GET_FUNCT(curr_instr) == `INSTR_MAGIC_ADDU_FUNCT) ? `INSTR_ADDU : 
	(`GET_OP(curr_instr) == `INSTR_MAGIC_RTYPE_OP && `GET_FUNCT(curr_instr) == `INSTR_MAGIC_SUBU_FUNCT) ? `INSTR_SUBU : 
	(`GET_OP(curr_instr) == `INSTR_MAGIC_LUI_OP) ? `INSTR_LUI : 
	(`GET_OP(curr_instr) == `INSTR_MAGIC_ORI_OP) ? `INSTR_ORI : 
	(`GET_OP(curr_instr) == `INSTR_MAGIC_LW_OP) ? `INSTR_LW : 
	(`GET_OP(curr_instr) == `INSTR_MAGIC_SW_OP) ? `INSTR_SW : 
	(`GET_OP(curr_instr) == `INSTR_MAGIC_BEQ_OP) ? `INSTR_BEQ : 
	(`GET_OP(curr_instr) == `INSTR_MAGIC_RTYPE_OP && `GET_FUNCT(curr_instr) == `INSTR_MAGIC_NOP_FUNCT) ? `INSTR_NOP : 
	`INSTR_UNKNOWN;

/* TODO: instruction type identification not implemented */

assign cm_rf_write_addr = 
	(curr_instr_kind == `INSTR_ADDU || curr_instr_kind == `INSTR_SUBU) ? `CM_RF_WRITE_ADDR_IM_DATA_15_11 : 
	(curr_instr_kind == `INSTR_LUI || curr_instr_kind == `INSTR_ORI || curr_instr_kind == `INSTR_LW || curr_instr_kind == `INSTR_SW || curr_instr_kind == `INSTR_BEQ || curr_instr_kind == `INSTR_NOP) ? `CM_RF_WRITE_ADDR_IM_DATA_20_16 : 
	`CM_RF_WRITE_ADDR_IM_DATA_20_16;

assign cm_rf_write_data = 
	(curr_instr_kind == `INSTR_ADDU || curr_instr_kind == `INSTR_SUBU || curr_instr_kind == `INSTR_LUI || curr_instr_kind == `INSTR_ORI || curr_instr_kind == `INSTR_SW || curr_instr_kind == `INSTR_BEQ || curr_instr_kind == `INSTR_NOP) ? `CM_RF_WRITE_DATA_ALU_RESULT : 
	(curr_instr_kind == `INSTR_LW) ? `CM_RF_WRITE_DATA_DM_READ_RESULT :
	`CM_RF_WRITE_DATA_ALU_RESULT;

assign cm_alu_num2 = 
	(curr_instr_kind == `INSTR_ADDU || curr_instr_kind == `INSTR_SUBU || curr_instr_kind == `INSTR_BEQ || curr_instr_kind == `INSTR_NOP) ? `CM_ALU_NUM2_RF_READ_RESULT2 : 
	(curr_instr_kind == `INSTR_LUI || curr_instr_kind == `INSTR_ORI || curr_instr_kind == `INSTR_LW || curr_instr_kind == `INSTR_SW) ? `CM_ALU_NUM2_EXT_RESULT : 
	`CM_ALU_NUM2_RF_READ_RESULT2;

assign cw_npc_jump_mode =
	(curr_instr_kind == `INSTR_BEQ) ? `NPC_JUMP_WHEN_EQUAL : 
	`NPC_JUMP_DISABLED;

assign cw_rf_write_enable =
	(curr_instr_kind == `INSTR_ADDU || curr_instr_kind == `INSTR_SUBU || curr_instr_kind == `INSTR_LUI || curr_instr_kind == `INSTR_ORI || curr_instr_kind == `INSTR_LW) ? `RF_WRITE_ENABLED : 
	`RF_WRITE_DISABLED;

assign cw_alu_op =
	(curr_instr_kind == `INSTR_ADDU) ? `ALU_ADD : 
	(curr_instr_kind == `INSTR_SUBU) ? `ALU_SUB : 
	(curr_instr_kind == `INSTR_LUI) ? `ALU_OR : 
	(curr_instr_kind == `INSTR_ORI) ? `ALU_OR : 
	(curr_instr_kind == `INSTR_LW) ? `ALU_ADD : 
	(curr_instr_kind == `INSTR_SW) ? `ALU_ADD : 
	(curr_instr_kind == `INSTR_BEQ) ? `ALU_OR : 
	(curr_instr_kind == `INSTR_NOP) ? `ALU_OR : 
	`ALU_OR;

assign cw_ext_mode =
	(curr_instr_kind == `INSTR_ADDU || curr_instr_kind == `INSTR_SUBU || curr_instr_kind == `INSTR_ORI || curr_instr_kind == `INSTR_BEQ || curr_instr_kind == `INSTR_NOP) ? `EXT_MODE_UNSIGNED :  
	(curr_instr_kind == `INSTR_LUI) ? `EXT_MODE_PAD : 
	(curr_instr_kind == `INSTR_LW || curr_instr_kind == `INSTR_SW) ? `EXT_MODE_SIGNED : 
	`EXT_MODE_UNSIGNED;

assign cw_dm_write_enable = 
	(curr_instr_kind == `INSTR_SW) ? `DM_WRITE_ENABLED : 
	`DM_WRITE_DISABLED;

/* TODO: what if curr_instr doesn't change between clock cycles? */
always @(curr_instr) begin
	`debug_write(("curr_instr = 0x%08x, op = 0b%6b, funct = 0b%6b, kind = %0d\n",
		curr_instr, `GET_OP(curr_instr), `GET_FUNCT(curr_instr), curr_instr_kind));
end

endmodule
