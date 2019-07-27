`include "npc.h"
`include "alu.h"

module npc(
	input [31:0] curr_pc, 
	input [2:0] jump_mode, 
	input [1:0] alu_comp_result, 
	input [15:0] num, 
	output [31:0] next_pc
);

wire [31:0] extended_offset;
assign extended_offset = {{14{num[15]}}, num, 2'b0};

wire [31:0] base;
assign base = $unsigned(curr_pc) + $unsigned(4);

assign next_pc = 
	(jump_mode == `NPC_JUMP_WHEN_EQUAL && alu_comp_result == `ALU_EQUAL) ? $signed(base) + $signed(extended_offset) : 
	(jump_mode == `NPC_JUMP_WHEN_NOT_EQUAL && alu_comp_result != `ALU_EQUAL) ? $signed(base) + $signed(extended_offset) : 
	$signed(base);

/* TODO: what if all the signals don't change? */
always @* begin
	`debug_write(("curr_pc = 0x%08x, jump_mode = 0b%03b, alu_comp_result = 0b%02b, num = 0x%04x, next_pc = 0x%08x\n", 
		curr_pc, jump_mode, alu_comp_result, num, next_pc));
end

endmodule

