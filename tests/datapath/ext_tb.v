`timescale 1ns / 1ps

`include "ext.h"

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
		/* signed extension, positive number */
		#10;
		mode = `EXT_MODE_SIGNED;
		num = 16'h0002;
		
		/* signed extension, negative number */
		#10;
		mode = `EXT_MODE_SIGNED;
		num = 16'hffff;
		
		/* unsigned extension, negative number */
		#10;
		mode = `EXT_MODE_UNSIGNED;
		num = 16'h0002;
		
		/* padded extension (for lui) */
		#10;
		mode = `EXT_MODE_PAD;
		num = 16'h1234;
		
		/* one extension */
		#10;
		mode = `EXT_MODE_ONE;
		num = 16'h1234;
	end
      
endmodule

