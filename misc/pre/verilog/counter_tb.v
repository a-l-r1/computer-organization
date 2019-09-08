`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:57:35 09/07/2019
// Design Name:   counter
// Module Name:   /home/a-l-r/co/src/misc/pre/verilog/counter_tb.v
// Project Name:  verilog
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: counter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module counter_tb;

	// Inputs
	reg Clk;
	reg Reset;
	reg Slt;
	reg En;

	// Outputs
	wire [63:0] Output0;
	wire [63:0] Output1;

	// Instantiate the Unit Under Test (UUT)
	code uut (
		.Clk(Clk), 
		.Reset(Reset), 
		.Slt(Slt), 
		.En(En), 
		.Output0(Output0), 
		.Output1(Output1)
	);

	initial begin
		// Initialize Inputs
		Clk = 0;
		Reset = 1;
		Slt = 0;
		En = 0;
        
		// Add stimulus here
		#10;
		Reset = 0;
		Slt = 0;
		En = 1;
	end
	
	always begin
		#5 Clk = ~Clk;
	end
      
endmodule

