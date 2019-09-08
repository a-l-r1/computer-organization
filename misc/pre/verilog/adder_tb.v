`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:31:26 09/07/2019
// Design Name:   adder
// Module Name:   /home/a-l-r/co/src/misc/pre/verilog/adder_tb.v
// Project Name:  verilog
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: adder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module adder_tb;

	// Inputs
	reg [3:0] A;
	reg [3:0] B;
	reg Clk;
	reg En;

	// Outputs
	wire [3:0] Sum;
	wire Overflow;

	// Instantiate the Unit Under Test (UUT)
	adder uut (
		.A(A), 
		.B(B), 
		.Clk(Clk), 
		.En(En), 
		.Sum(Sum), 
		.Overflow(Overflow)
	);

	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;
		Clk = 0;
		En = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		#5;
		
		#20;
		A = 4'b1111;
		B = 4'b1111;
		
		#20;
		En = 1;
		
		#20;
		En = 0;
		A = 4'b0001;
		B = 4'b0001;
		
		#20;
		En = 1;
	end
	
	always begin
		#10 Clk = ~Clk;
	end
      
endmodule

