`include "npc.h"
`include "alu.h"

module npc(
	input [31:0] curr_pc, 
	input [2:0] jump_mode, 
	input [1:0] alu_comp_result, 
	input [15:0] num, 
	output [31:0] next_pc
)

assign next_pc = 
	(jump_mode == `NPC_JUMP_WHEN_EQUAL && alu_comp_result == `ALU_EQUAL) ? $signed(curr_pc) + $signed({16{num[15]}, num}) : 
	(jump_mode == `NPC_JUMP_WHEN_NOT_EQUAL && alu_comp_result != `ALU_EQUAL) ? $signed(curr_pc) + $signed({16{num[15]}, num}) : 
	$unsigned(curr_pc) + $unsigned(4);

endmodule

