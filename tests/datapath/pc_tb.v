`timescale 1ns / 1ps

`include "pc.h"

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:28:18 07/26/2019
// Design Name:   pc
// Module Name:   Z:/home/a-l-r/co/src/tests/datapath/pc_tb.v
// Project Name:  cpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: pc
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module pc_tb;

	// Inputs
	reg clk;
	reg [31:0] next_pc;
	reg enable;

	// Outputs
	wire [31:0] curr_pc;

	// Instantiate the Unit Under Test (UUT)
	pc uut (
		.clk(clk), 
		.next_pc(next_pc), 
		.enable(enable), 
		.curr_pc(curr_pc)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		next_pc = 0;
		enable = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		/* make sure the stimuli always take place before the posedge of clk */
		#5;
		
		/* normal update */
		#20;
		next_pc = 32'h00000004;
		enable = `PC_ENABLED;
		
		/* don't update */
		#20;
		next_pc = 32'hdeedbeef;
		enable = `PC_DISABLED;
		
		/* update again */
		#20;
		next_pc = 32'h0000002a;
		enable = `PC_ENABLED;
	end
	
	always begin
		#10 clk = ~clk;
	end
      
endmodule

