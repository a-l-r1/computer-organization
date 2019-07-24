`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:19:38 07/24/2019
// Design Name:   ext
// Module Name:   Z:/home/a-l-r/co/src/tests/datapath/ext_tb.v
// Project Name:  cpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ext
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ext_tb;

	// Inputs
	reg [15:0] num;
	reg [2:0] mode;

	// Outputs
	wire [31:0] result;

	// Instantiate the Unit Under Test (UUT)
	ext uut (
		.num(num), 
		.mode(mode), 
		.result(result)
	);

	initial begin
		// Initialize Inputs
		num = 0;
		mode = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

