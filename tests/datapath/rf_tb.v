`timescale 1ns / 1ps

`include "rf.h"

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:46:01 07/24/2019
// Design Name:   rf
// Module Name:   Z:/home/a-l-r/co/src/tests/datapath/rf_tb.v
// Project Name:  cpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: rf
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module rf_tb;

	// Inputs
	reg clk;
	reg [4:0] read_addr1;
	reg [4:0] read_addr2;
	reg [4:0] write_addr;
	reg [31:0] write_data;
	reg write_enable;

	// Outputs
	wire [31:0] read_result1;
	wire [31:0] read_result2;

	// Instantiate the Unit Under Test (UUT)
	rf uut (
		.clk(clk), 
		.read_addr1(read_addr1), 
		.read_addr2(read_addr2), 
		.write_addr(write_addr), 
		.write_data(write_data), 
		.write_enable(write_enable), 
		.read_result1(read_result1), 
		.read_result2(read_result2)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		read_addr1 = 0;
		read_addr2 = 0;
		write_addr = 0;
		write_data = 0;
		write_enable = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		/* make sure the signals change before the posedge of clk */
		#5;
		
		/* read $0 and a normal register */
		read_addr1 = 0;
		read_addr2 = 1;
		
		/* write to $0 */
		write_enable = 1;
		write_addr = 0;
		write_data = 32'hdeedbeef;
		
		#20;
		/* read from $0 again and another normal register */
		read_addr1 = 0;
		read_addr2 = 1;
		
		/* write to a normal register */
		write_enable = 1;
		write_addr = 2;
		write_data = 32'h42424242;
		
		#20;
		/* read from $0 again and the register written before */
		read_addr1 = 0;
		read_addr2 = 2;
		
		/* don't write */
		write_enable = 0;
		write_data = 32'hdeedbeef;
		
		#20;
		/* read from the register written before again */
		read_addr1 = 0;
		read_addr2 = 2;
		
		/* don't write, either */
		write_enable = 0;
	end
	
	always begin
		#10 clk = ~clk;
	end
      
endmodule

