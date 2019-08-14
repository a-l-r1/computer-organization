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
	reg [1:0] cmp_sig_result;
	reg [15:0] num;
	reg [25:0] jnum;
	reg [31:0] reg_;
	reg [31:0] epc;

	// Outputs
	wire [31:0] next_pc;

	// Instantiate the Unit Under Test (UUT)
	npc uut (
		.curr_pc(curr_pc), 
		.jump_mode(jump_mode), 
		.cmp_result(cmp_result),
		.cmp_sig_result(cmp_sig_result), 
		.num(num), 
		.jnum(jnum), 
		.reg_(reg_), 
		.epc(epc), 
		.next_pc(next_pc)
	);

	initial begin
		// Initialize Inputs
		curr_pc = 0;
		jump_mode = 0;
		cmp_result = 0;
		cmp_sig_result = 0;
		num = 0;
		jnum = 0;
		reg_ = 0;
		epc = 0;

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
		
		/* bgez, bgtz, bltz, blez, jnum and reg untested, since tests of p5 and p6 have passed */
		
		/* jump to isr */
		#10;
		curr_pc = 32'h00000004;
		jump_mode = `NPC_ISR;
		cmp_result = `CMP_EQUAL;
		num = 16'h0000;
		epc = 32'h00004000;
		
		/* jump back to epc */
		#10;
		curr_pc = 32'h00000008;
		jump_mode = `NPC_EPC;
		cmp_result = `CMP_EQUAL;
		num = 16'h0000;
		epc = 32'h00003004;
	end
      
endmodule

