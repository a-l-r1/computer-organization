`include "npc.h"
`include "alu.h"

`define PART_NAME "npc"

module npc(
	input [31:0] curr_pc, 
	input [2:0] jump_mode, 
	input [1:0] alu_comp_result, 
	input [15:0] num, 
	input [25:0] jnum, 
	input [31:0] reg_, 
	output [31:0] next_pc
);

wire [31:0] extended_offset;
assign extended_offset = {{14{num[15]}}, num, 2'b0};

wire [31:0] base;
assign base = $unsigned(curr_pc) + $unsigned(4);

assign next_pc = 
	(jump_mode == `NPC_JUMP_WHEN_EQUAL && alu_comp_result == `ALU_EQUAL) ? $signed(base) + $signed(extended_offset) : 
	(jump_mode == `NPC_JUMP_WHEN_NOT_EQUAL && alu_comp_result != `ALU_EQUAL) ? $signed(base) + $signed(extended_offset) : 
	(jump_mode == `NPC_JUMP_JNUM) ? {curr_pc[31:28], jnum, 2'b00} : 
	(jump_mode == `NPC_JUMP_REG) ? reg_ : 
	$signed(base);

endmodule

