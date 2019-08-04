`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:38:06 08/04/2019
// Design Name:   cmp
// Module Name:   C:/cygwin64/home/A-l-r/co/src/tests/datapath/cmp_tb.v
// Project Name:  cpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: cmp
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module cmp_tb;

	// Inputs
	reg [31:0] reg1;
	reg [31:0] reg2;

	// Outputs
	wire [1:0] cmp;
	wire [1:0] sig_cmp;
	wire [1:0] reg2_sig_cmp;

	// Instantiate the Unit Under Test (UUT)
	cmp uut (
		.reg1(reg1), 
		.reg2(reg2), 
		.cmp(cmp), 
		.sig_cmp(sig_cmp), 
		.reg2_sig_cmp(reg2_sig_cmp)
	);

	initial begin
		// Initialize Inputs
		reg1 = 0;
		reg2 = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		reg1 = 32'hffffffff;
		reg2 = 32'h42424242;
	end
      
endmodule

