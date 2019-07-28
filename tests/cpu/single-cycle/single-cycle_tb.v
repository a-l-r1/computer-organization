`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:00:26 07/27/2019
// Design Name:   cpu
// Module Name:   Z:/home/a-l-r/co/src/project/single-cycle_tb.v
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

module single_cycle_tb;

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
		/* No stimuli, but finishing the simulation is needed */
		#1000; $finish;
	end
	
	always begin
		#10 clk = ~clk;
	end

endmodule

