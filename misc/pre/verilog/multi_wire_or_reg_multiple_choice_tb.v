`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:22:15 09/09/2019
// Design Name:   multi_wire_or_reg_multiple_choice
// Module Name:   /home/a-l-r/co/src/misc/pre/verilog/multi_wire_or_reg_multiple_choice_tb.v
// Project Name:  verilog
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: multi_wire_or_reg_multiple_choice
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module multi_wire_or_reg_multiple_choice_tb;

	// Inputs
	reg [3:0] a;
	reg [4:7] b;
	reg [8:11] c;

	// Outputs
	wire [3:0] o1;
	wire [4:7] o2;

	// Instantiate the Unit Under Test (UUT)
	multi_wire_or_reg_multiple_choice uut (
		.a(a), 
		.b(b), 
		.c(c), 
		.o1(o1), 
		.o2(o2)
	);

	initial begin
		// Initialize Inputs
		a = 0;
		b = 0;
		c = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

