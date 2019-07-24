`timescale 1ns / 1ps

`include "alu.h"

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:17:41 07/24/2019
// Design Name:   alu
// Module Name:   Z:/home/a-l-r/co/src/tests/datapath/alu_tb.v
// Project Name:  cpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: alu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module alu_tb;

	// Inputs
	reg [31:0] num1;
	reg [31:0] num2;
	reg [4:0] op;

	// Outputs
	wire [31:0] result;
	wire [1:0] comp_result;
	wire [1:0] sig_comp_result;
	wire overflow;
	wire op_invalid;

	// Instantiate the Unit Under Test (UUT)
	alu uut (
		.num1(num1), 
		.num2(num2), 
		.op(op), 
		.result(result), 
		.comp_result(comp_result), 
		.sig_comp_result(sig_comp_result), 
		.overflow(overflow), 
		.op_invalid(op_invalid)
	);

	initial begin
		// Initialize Inputs
		num1 = 0;
		num2 = 0;
		op = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		
		/* 2 + 2 != 5 */
		#10;
		num1 = 32'h00000002;
		num2 = 32'h00000002;
		op = `ALU_ADD;
		
		/* add, overflow */
		#10;
		num1 = 32'hffffffff;
		num2 = 32'h00000001;
		op = `ALU_ADD;
		
		/* sub, underflow */
		#10;
		num1 = 32'h00000000;
		num2 = 32'h00000001;
		op = `ALU_SUB;
		
		/* comparison not tested */
		
		/* and */
		#10;
		num1 = 32'h89abcdef;
		num2 = 32'h01234567;
		op = `ALU_AND;
		
		/* or */
		#10;
		op = `ALU_OR;
		
		/* not */
		#10;
		op = `ALU_NOT;
		
		/* xor */
		#10;
		op = `ALU_XOR;
	end
      
endmodule

