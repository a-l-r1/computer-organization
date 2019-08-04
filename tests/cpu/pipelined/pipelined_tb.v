`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:16:01 08/04/2019
// Design Name:   cpu
// Module Name:   C:/cygwin64/home/A-l-r/co/src/tests/cpu/pipelined/pipelined_tb.v
// Project Name:  cpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: cpu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module pipelined_tb;

	// Inputs
	reg clk;

	// Instantiate the Unit Under Test (UUT)
	cpu uut (
		.clk(clk)
	);

	initial begin
		// Initialize Inputs
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end

	always begin
		#5 clk = ~clk;
	end
endmodule

