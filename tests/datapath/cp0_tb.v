`timescale 1ns / 1ps

`include "cp0.h"

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:44:44 08/10/2019
// Design Name:   cp0
// Module Name:   C:/cygwin64/home/A-l-r/co/src/tests/datapath/cp0_tb.v
// Project Name:  cpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: cp0
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module cp0_tb;

	// Inputs
	reg clk;
	reg rst;
	reg [4:0] addr;
	reg write_enable;
	reg [31:0] write_data;
	reg exit_isr;
	reg in_bds;
	reg [5:0] hwirq;
	reg [4:0] exc;
	reg [31:0] curr_pc;

	// Outputs
	wire [31:0] read_result;
	wire [31:0] epc;
	wire have2handle;

	// Instantiate the Unit Under Test (UUT)
	cp0 uut (
		.clk(clk), 
		.rst(rst), 
		.addr(addr), 
		.write_enable(write_enable), 
		.write_data(write_data), 
		.exit_isr(exit_isr), 
		.in_bds(in_bds), 
		.hwirq(hwirq), 
		.exc(exc), 
		.curr_pc(curr_pc), 
		.read_result(read_result), 
		.epc(epc), 
		.have2handle(have2handle)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		addr = 0;
		write_enable = 0;
		write_data = 0;
		exit_isr = 0;
		in_bds = 0;
		hwirq = 0;
		exc = 0;
		curr_pc = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		/* Make sure the stimuli always happen before the posedge of clk */
		#5;
		
		/* read data */
		#20;
		addr = 12;
		
		/* write data */
		#20;
		write_enable = 1;
		addr = 12;
		write_data = {16'b0, 6'b000001, 8'b0, 1'b0, 1'b1};
		
		#20;
		write_enable = 0;
		
		/* exceptions */
		#20;
		exc = `EXC_ADEL;
		
		#20;
		exc = 5'd0;
		
		/* hwirq in exceptions */
		#20;
		hwirq = 6'b001000;
		
		#20;
		hwirq = 6'b0;
		
		/* exit isr */
		#20;
		exit_isr = 1'b1;
		
		#20;
		exit_isr = 1'b0;
		
		/* interrupts and exceptions, interrupts is of priority */
		#20;
		exc = `EXC_ADES;
		hwirq = 6'b000001;
		
		/* exit isr */
		#20;
		hwirq = 6'b000000;
		exc = `EXC_NONE;
		exit_isr = 1'b1;
		
		#20;
		exit_isr = 1'b0;
	end
	
	always begin
		#10 clk = ~clk;
	end
      
endmodule

