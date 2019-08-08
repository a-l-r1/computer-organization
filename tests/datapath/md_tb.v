`timescale 1ns / 1ps

`include "md.h"

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:27:20 08/07/2019
// Design Name:   md
// Module Name:   C:/cygwin64/home/A-l-r/co/src/tests/datapath/md_tb.v
// Project Name:  cpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: md
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module md_tb;

	// Inputs
	reg clk;
	reg [31:0] dh;
	reg [31:0] dl;
	reg [3:0] op;

	// Outputs
	wire busy;
	wire invalid;
	wire [31:0] hi;
	wire [31:0] lo;

	// Instantiate the Unit Under Test (UUT)
	md uut (
		.clk(clk), 
		.dh(dh), 
		.dl(dl), 
		.op(op), 
		.busy(busy), 
		.invalid(invalid), 
		.hi(hi), 
		.lo(lo)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		dh = 0;
		dl = 0;
		op = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		
		op = `MD_NONE;
		/* Make sure input changes always take place before stimuli */
		#5;
		
		/* mult */
		dh = 32'h42424242;
		dl = 32'hffff1234;
		op = `MD_MULT;
		#100;
		
		/* flush */
		op = `MD_NONE;
		#20;
		
		/* multu */
		dh = 32'h42424242;
		dl = 32'hffff1234;
		op = `MD_MULTU;
		#100;
		
		/* flush */
		op = `MD_NONE;
		#20;
		
		/* div */
		dh = 32'hf2424242;
		dl = 32'hf1111234;
		op = `MD_DIV;
		#200;
		
		/* flush */
		op = `MD_NONE;
		#20;
		
		/* divu */
		dh = 32'h42424242;
		dl = 32'h1fff1234;
		op = `MD_DIVU;
		#200;
		
		/* flush */
		op = `MD_NONE;
		#20;
		
		/* div by zero */
		dh = 32'h42424242;
		dl = 32'h0;
		op = `MD_DIV;
		#200;
	end
	
	always begin
		#10 clk = ~clk;
	end
      
endmodule

