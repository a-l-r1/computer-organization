`timescale 1ns / 1ps

`include "ac.h"

`include "dm.h"
`include "bridge.h"

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:39:34 08/10/2019
// Design Name:   ac
// Module Name:   C:/cygwin64/home/A-l-r/co/src/tests/datapath/ac_tb.v
// Project Name:  cpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ac
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ac_tb;

	// Inputs
	reg [31:0] addr;
	reg [2:0] dm_mode;
	reg write_enable;

	// Outputs
	wire [2:0] validity;

	// Instantiate the Unit Under Test (UUT)
	ac uut (
		.addr(addr), 
		.dm_mode(dm_mode), 
		.write_enable(write_enable), 
		.validity(validity)
	);

	initial begin
		// Initialize Inputs
		addr = 0;
		dm_mode = 0;
		write_enable = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		/* valid address, in dm */
		#10;
		addr = 32'h00002004;
		dm_mode = `DM_W;
		write_enable = 1;
		
		#10;
		addr = 32'h00002001;
		dm_mode = `DM_B;
		write_enable = 0;
		
		#10;
		addr = 32'h00002002;
		dm_mode = `DM_H;
		write_enable = 0;
		
		/* valid address, in bridge */
		#10;
		addr = 32'h00007f04;
		dm_mode = `DM_B;
		write_enable = 1;
		
		/* invalid addresses, out of range */
		#10;
		addr = 32'h00007fff;
		dm_mode = `DM_B;
		write_enable = 0;
		
		#10;
		addr = 32'h00003000;
		dm_mode = `DM_W;
		write_enable = 1;
		
		/* invalid addresses, not aligned */
		#10;
		addr = 32'h00000001;
		dm_mode = `DM_H;
		write_enable = 1;
		
		#10;
		addr = 32'h00000003;
		dm_mode = `DM_W;
		write_enable = 0;
	end
      
endmodule

