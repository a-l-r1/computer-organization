`timescale 1ns / 1ps

`include "npc.h"

`include "alu.h"
`include "cmp.h"

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:50:11 07/24/2019
// Design Name:   npc
// Module Name:   Z:/home/a-l-r/co/src/tests/datapath/npc_tb.v
// Project Name:  cpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: npc
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module npc_tb;

	// Inputs
	reg [31:0] curr_pc;
	reg [3:0] jump_mode;
	reg [1:0] cmp_result;
	reg [15:0] num;

	// Outputs
	wire [31:0] next_pc;

	// Instantiate the Unit Under Test (UUT)
	npc uut (
		.curr_pc(curr_pc), 
		.jump_mode(jump_mode), 
		.cmp_result(cmp_result), 
		.num(num), 
		.next_pc(next_pc)
	);

	initial begin
		// Initialize Inputs
		curr_pc = 0;
		jump_mode = 0;
		cmp_result = 0;
		num = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		/* normal increase with unused num */
		#10;
		curr_pc = 32'h00000004;
		jump_mode = `NPC_JUMP_DISABLED;
		cmp_result = `ALU_EQUAL;
		num = 16'h0008;
		
		/* beq with positive num */
		#10;
		curr_pc = 32'h00000004;
		jump_mode = `NPC_JUMP_WHEN_EQUAL;
		cmp_result = `ALU_EQUAL;
		num = 16'h0008;
		
		/* beq with negative num */
		#10;
		curr_pc = 32'h00000004;
		jump_mode = `NPC_JUMP_WHEN_EQUAL;
		cmp_result = `ALU_EQUAL;
		num = 16'hffff;
		
		/* beq with negative num and `ALU_LARGER */
		#10;
		curr_pc = 32'h00000004;
		jump_mode = `NPC_JUMP_WHEN_EQUAL;
		cmp_result = `ALU_LARGER;
		num = 16'hffff;
		
		/* bne with positive num */
		#10;
		curr_pc = 32'h00000004;
		jump_mode = `NPC_JUMP_WHEN_NOT_EQUAL;
		cmp_result = `ALU_LARGER;
		num = 16'h0008;
		
		/* bgez with positive num */
		#10;
		curr_pc = 32'h00000004;
		jump_mode = `NPC_LARGER_OR_EQUAL;
		cmp_result = `CMP_LARGER;
		num = 16'h0008;
		
		/* bgez with negative num and `CMP_SMALLER */
		#10;
		curr_pc = 32'h00000004;
		jump_mode = `NPC_LARGER_OR_EQUAL;
		cmp_result = `CMP_SMALLER;
		num = 16'hffff;
		
		/* bltz with negative num */
		#10;
		curr_pc = 32'h00000004;
		jump_mode = `NPC_SMALLER;
		cmp_result = `CMP_SMALLER;
		num = 16'hffff;
		
		/* bltz with positive num and `CMP_LARGER */
		#10;
		curr_pc = 32'h00000004;
		jump_mode = `NPC_SMALLER;
		cmp_result = `CMP_LARGER;
		num = 16'h0008;
	end
      
endmodule

