`include "npc.h"

`include "alu.h"
`include "cmp.h"
`include "im.h"

`define PART_NAME "npc"

module npc(
	input [31:0] curr_pc, 
	input [3:0] jump_mode, 
	input [1:0] cmp_result, 
	input [1:0] cmp_sig_result, 
	input [15:0] num, 
	input [25:0] jnum, 
	input [31:0] reg_,
	input [31:0] epc, 
	output [31:0] next_pc
);

wire [31:0] extended_offset;
wire [31:0] base;
wire [31:0] b_target;

assign extended_offset = {{14{num[15]}}, num, 2'b0};

assign base = $unsigned(curr_pc);

/* Target PC of BRANCH datapath type */

assign b_target = $signed(base) + $signed(extended_offset);

assign next_pc = 
	(jump_mode == `NPC_EQUAL && cmp_result == `CMP_EQUAL) ? b_target : 
	(jump_mode == `NPC_NOT_EQUAL && cmp_result != `CMP_EQUAL) ? b_target : 
	(jump_mode == `NPC_LARGER && cmp_result == `CMP_LARGER) ? b_target : 
	(jump_mode == `NPC_SMALLER && cmp_result == `CMP_SMALLER) ? b_target : 
	(jump_mode == `NPC_LARGER_OR_EQUAL && (cmp_result == `CMP_LARGER || cmp_result == `CMP_EQUAL)) ? b_target : 
	(jump_mode == `NPC_SMALLER_OR_EQUAL && (cmp_result == `CMP_SMALLER || cmp_result == `CMP_EQUAL)) ? b_target : 
	(jump_mode == `NPC_SIG_LARGER && cmp_sig_result == `CMP_LARGER) ? b_target : 
	(jump_mode == `NPC_SIG_SMALLER && cmp_sig_result == `CMP_SMALLER) ? b_target : 
	(jump_mode == `NPC_SIG_LARGER_OR_EQUAL && (cmp_sig_result == `CMP_LARGER || cmp_sig_result == `CMP_EQUAL)) ? b_target : 
	(jump_mode == `NPC_SIG_SMALLER_OR_EQUAL && (cmp_sig_result == `CMP_SMALLER || cmp_sig_result == `CMP_EQUAL)) ? b_target : 
	(jump_mode == `NPC_REG) ? reg_ : 
	(jump_mode == `NPC_J) ? {base[31:28], jnum, 2'b0} : 
	(jump_mode == `NPC_ISR) ? `IM_ISR_ADDRESS : 
	(jump_mode == `NPC_EPC) ? epc : 
	$unsigned(base) + $unsigned(4);

endmodule

