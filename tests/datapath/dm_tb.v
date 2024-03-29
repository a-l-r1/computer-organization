`timescale 1ns / 1ps

`include "dm.h"

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:13:00 07/24/2019
// Design Name:   dm
// Module Name:   Z:/home/a-l-r/co/src/tests/datapath/dm_tb.v
// Project Name:  cpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: dm
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module dm_tb;

	// Inputs
	reg clk;
	reg [31:0] read_addr;
	reg [31:0] write_addr;
	reg [31:0] write_data;
	reg write_enable;
	reg [2:0] mode;

	// Outputs
	wire [31:0] read_result;

	// Instantiate the Unit Under Test (UUT)
	dm uut (
		.clk(clk), 
		.read_addr(read_addr), 
		.write_addr(write_addr), 
		.write_data(write_data), 
		.write_enable(write_enable), 
		.mode(mode), 
		.read_result(read_result), 
		.invalid(invalid)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		read_addr = 0;
		write_addr = 0;
		write_data = 0;
		write_enable = 0;
		mode = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		/* make sure the stimuli comes before the posedge of clk */
		#5;
		
		/* read the 1st word */
		#20;
		read_addr = 0;
		write_addr = 4;
		write_data = 32'hdeadbeef;
		write_enable = 1'b0;
		mode = `DM_W;
		
		/* write the 2nd word and read the 1st one */
		#20;
		read_addr = 0;
		write_addr = 4;
		write_data = 32'h01234567;
		write_enable = `DM_WRITE_ENABLED;
		mode = `DM_W;
		
		/* write the 1st word and read the 2nd one */
		#20;
		read_addr = 4;
		write_addr = 0;
		write_data = 32'h42424242;
		write_enable = `DM_WRITE_ENABLED;
		mode = `DM_W;
		
		/* read the 1st word, don't write */
		#20;
		read_addr = 0;
		write_addr = 4;
		write_data = 32'hdeadbeef;
		write_enable = `DM_WRITE_DISABLED;
		mode = `DM_W;
		
		/* read the 2nd word, don't write either */
		#20;
		read_addr = 4;
		write_addr = 0;
		write_data = 32'hdeadbeef;
		write_enable = `DM_WRITE_DISABLED;
		mode = `DM_W;
		
		/* large address */
		#20;
		read_addr = 32'h01234564;
		write_addr = 0;
		write_data = 32'hdeadbeef;
		write_enable = 1'b0;
		mode = `DM_W;
		
		/* Read by half word */
		#20;
		read_addr = 32'h00000000;
		write_addr = 0;
		write_data = 32'hdeadbeef;
		write_enable = 1'b0;
		mode = `DM_H;
		
		#20;
		read_addr = 32'h00000002;
		mode = `DM_H;
		
		#20;
		read_addr = 32'h00000000;
		mode = `DM_HU;
		
		#20;
		read_addr = 32'h00000002;
		mode = `DM_HU;
		
		/* Read by byte */
		#20;
		read_addr = 32'h00000000;
		mode = `DM_B;
		
		#20;
		read_addr = 32'h00000001;
		mode = `DM_BU;
		
		/* Write by half word */
		#20;
		read_addr = 32'h00000000;
		write_addr = 32'h00000002;
		write_data = 32'hf1f2f3f4;
		mode = `DM_H;
		write_enable = 1'b1;
		
		/* Write by byte */
		#20;
		read_addr = 32'h00000000;
		write_addr = 32'h00000001;
		write_data = 32'hf5f6f7f8;
		mode = `DM_B;
		write_enable = 1'b1;
		
		/* Check the result */
		#20;
		read_addr = 32'h00000000;
		mode = `DM_W;
		write_enable = 1'b0;
	end
	
	always begin
		#10 clk = ~clk;
	end
      
endmodule

