`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   09:13:43 12/22/2019
// Design Name:   wrapper
// Module Name:   /home/a-l-r/co/src/project/wrapper_postsynthesis_tb.v
// Project Name:  cpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: wrapper
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module wrapper_postsynthesis_tb;

	// Inputs
	reg clk;
	reg reset;
	reg [31:0] F_addr;
	reg [31:0] F_instr;
	reg [31:0] M_addr;
	reg M_WE;
	reg M_RE;
	reg [31:0] M_WData;
	reg [31:0] M_RData;
	reg rxd;

	// Outputs
	wire [31:0] user_F_addr;
	wire [31:0] user_F_instr;
	wire [31:0] user_M_addr;
	wire user_M_WE;
	wire user_M_RE;
	wire [31:0] user_M_WData;
	wire [31:0] user_M_RData;
	wire TxD;
	wire [7:0] txd_buffer;

	// Instantiate the Unit Under Test (UUT)
	wrapper uut (
		.clk(clk), 
		.reset(reset), 
		.F_addr(F_addr), 
		.F_instr(F_instr), 
		.M_addr(M_addr), 
		.M_WE(M_WE), 
		.M_RE(M_RE), 
		.M_WData(M_WData), 
		.M_RData(M_RData), 
		.user_F_addr(user_F_addr), 
		.user_F_instr(user_F_instr), 
		.user_M_addr(user_M_addr), 
		.user_M_WE(user_M_WE), 
		.user_M_RE(user_M_RE), 
		.user_M_WData(user_M_WData), 
		.user_M_RData(user_M_RData), 
		.rxd(rxd), 
		.TxD(TxD), 
		.txd_buffer(txd_buffer)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		F_addr = 0;
		F_instr = 0;
		M_addr = 0;
		M_WE = 0;
		M_RE = 0;
		M_WData = 0;
		M_RData = 0;
		rxd = 0;

		// Wait 100 ns for global reset to finish
		#100;
		reset = 0;
        
		// Add stimulus here
		#20;
		M_addr = 32'h0000002a;
		M_WE = 1;
		M_WData = 32'hcafebabe;
		
		#10;
		M_WE = 0;
	end
   
	/* 10MHz main clock */
	always #5 clk = ~clk;
	
endmodule

