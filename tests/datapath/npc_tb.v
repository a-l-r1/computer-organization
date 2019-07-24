`timescale 1ns / 1ps

`include "npc.h"

`include "alu.h"

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
	reg [2:0] jump_mode;
	reg [1:0] alu_comp_result;
	reg [15:0] num;

	// Outputs
	wire [31:0] next_pc;

	// Instantiate the Unit Under Test (UUT)
	npc uut (
		.curr_pc(curr_pc), 
		.jump_mode(jump_mode), 
		.alu_comp_result(alu_comp_result), 
		.num(num), 
		.next_pc(next_pc)
	);

	initial begin
		// Initialize Inputs
		curr_pc = 0;
		jump_mode = 0;
		alu_comp_result = 0;
		num = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		/* normal increase with unused num */
		#10;
		curr_pc = 32'h00000004;
		jump_mode = `NPC_JUMP_DISABLED;
		alu_comp_result = `ALU_EQUAL;
		num = 16'h0008;
		
		/* beq with positive num */
		#10;
		curr_pc = 32'h00000004;
		jump_mode = `NPC_JUMP_WHEN_EQUAL;
		alu_comp_result = `ALU_EQUAL;
		num = 16'h0008;
		
		/* beq with negative num */
		#10;
		curr_pc = 32'h00000004;
		jump_mode = `NPC_JUMP_WHEN_EQUAL;
		alu_comp_result = `ALU_EQUAL;
		num = 16'hffff;
		
		/* beq with negative num and `ALU_LARGER */
		#10;
		curr_pc = 32'h00000004;
		jump_mode = `NPC_JUMP_WHEN_EQUAL;
		alu_comp_result = `ALU_LARGER;
		num = 16'hffff;
		
		/* bne with positive num */
		#10;
		curr_pc = 32'h00000004;
		jump_mode = `NPC_JUMP_WHEN_NOT_EQUAL;
		alu_comp_result = `ALU_LARGER;
		num = 16'h0008;
	end
      
endmodule

