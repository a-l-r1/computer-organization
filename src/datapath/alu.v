`include "alu.h"

`define PART_NAME "alu"

`include "debug/debug.h"

module alu(
	input [31:0] num1, 
	input [31:0] num2, 
	input [4:0] op, 
	output [31:0] result, 
	output [1:0] comp_result, 
	output [1:0] sig_comp_result, 
	output overflow, 
	output op_invalid
);

assign {op_invalid, result} = 
	(op == `ALU_ADD) ? {1'b0, $unsigned(num1) + $unsigned(num2)} : 
	(op == `ALU_SUB) ? {1'b0, $unsigned(num1) - $unsigned(num2)} : 
	(op == `ALU_AND) ? {1'b0, $unsigned(num1) & $unsigned(num2)} : 
	(op == `ALU_OR) ? {1'b0, $unsigned(num1) | $unsigned(num2)} : 
	(op == `ALU_NOT) ? {1'b0, ~$unsigned(num1)} : 
	(op == `ALU_XOR) ? {1'b0, $unsigned(num1) ^ $unsigned(num2)} : 
	(op == `ALU_MOVZ) ? {1'b0, $unsigned(num1)} : 
	{1'b1, 32'b0};

wire [32:0] intermediate_result;

/* TODO: is this correct? */
assign intermediate_result = 
	(op == `ALU_ADD) ? $unsigned(num1) + $unsigned(num2) : 
	(op == `ALU_SUB) ? $unsigned(num1) - $unsigned(num2) : 
	33'b0;

assign overflow = intermediate_result[32];

assign comp_result = 
   ($unsigned(num1) == $unsigned(num2)) ? `ALU_EQUAL : 
	($unsigned(num1) < $unsigned(num2)) ? `ALU_SMALLER : 
	`ALU_LARGER;

assign sig_comp_result = 
	($signed(num1) == $signed(num2)) ? `ALU_EQUAL : 
	($signed(num1) < $signed(num2)) ? `ALU_SMALLER : 
	`ALU_LARGER;

/* TODO: what if both num1 and num2 don't change? */
always @(num1 or num2) begin
	`debug_write(("num1 = 0x%08x, num2 = 0x%08x, op = 0b%5b, result = 0x%08x\n", num1, num2, op, result));
end

endmodule

