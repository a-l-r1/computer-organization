`timescale 1ns / 1ps

`include "im.h"

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:48:51 07/24/2019
// Design Name:   im
// Module Name:   Z:/home/a-l-r/co/src/tests/datapath/im_tb.v
// Project Name:  cpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: im
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module im_tb;

	// Inputs
	reg addr;
	reg enable;

	// Outputs
	wire [31:0] result;

	// Instantiate the Unit Under Test (UUT)
	im uut (
		.addr(addr), 
		.enable(enable), 
		.result(result)
	);

	initial begin
		// Initialize Inputs
		addr = 0;
		enable = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		/* make sure the stimuli always take place before the posedge of clk */
		#5;
		

	end
	
	always begin
		#20 clk = ~clk;
	end
      
endmodule

