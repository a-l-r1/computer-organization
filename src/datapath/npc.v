`include "npc.h"
`include "alu.h"
`include "cmp.h"

`define PART_NAME "npc"

`include "debug/debug.h"

module npc(
	input [31:0] curr_pc, 
	input [3:0] jump_mode, 
	input [1:0] cmp_result, 
	input [1:0] cmp_sig_result, 
	input [15:0] num, 
	input [25:0] jnum, 
	input [31:0] reg_,
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
	$unsigned(base) + $unsigned(4);

/* TODO: what if all the signals don't change? */
always @* begin
	`debug_write(("curr_pc = 0x%08x, base = 0x%08x, jump_mode = 0b%03b, cmp_result = 0b%02b, num = 0x%04x, reg_ = 0x%08x, next_pc = 0x%08x\n", \
		curr_pc, base, jump_mode, cmp_result, num, reg_, next_pc));
end

endmodule

