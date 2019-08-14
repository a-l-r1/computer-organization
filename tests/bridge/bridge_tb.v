`timescale 1ns / 1ps

`include "bridge.h"

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:05:53 08/10/2019
// Design Name:   bridge
// Module Name:   C:/cygwin64/home/A-l-r/co/src/tests/bridge/bridge_tb.v
// Project Name:  cpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: bridge
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module bridge_tb;

	// Inputs
	reg clk;
	reg rst;
	reg [31:0] addr;
	reg write_enable;
	reg [31:0] write_data;

	// Outputs
	wire [31:0] read_result;
	wire [5:0] hwirq;

	// Instantiate the Unit Under Test (UUT)
	bridge uut (
		.clk(clk), 
		.rst(rst), 
		.addr(addr), 
		.write_enable(write_enable), 
		.write_data(write_data), 
		.read_result(read_result), 
		.hwirq(hwirq)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		addr = 0;
		write_enable = 0;
		write_data = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		/* Make sure the stimuli always take place before the posedge of clk */
		#5;
		
		/* no writing */
		#20;
		write_enable = 0;
		addr = `BRIDGE_TIMER0_LB;
		
		#20;
		write_enable = 0;
		addr = `BRIDGE_TIMER0_LB + 4;
		
		#20;
		write_enable = 0;
		addr = `BRIDGE_TIMER1_LB + 8;
		
		/* no writing, unaligned */
		#20;
		write_enable = 0;
		addr = `BRIDGE_TIMER0_LB + 1;
		
		/* no writing, out of range */
		/* plus 1 because `BRIDGE_TIMER1_UB is the address of the last valid byte */
		#20;
		write_enable = 0;
		addr = `BRIDGE_TIMER1_UB + 1 + 16;
		
		/* write preset */
		#20;
		write_enable = 1;
		addr = `BRIDGE_TIMER0_BASE + 4;
		write_data = 32'h5;
		
		/* read from it */
		#20;
		write_enable = 0;
		addr = `BRIDGE_TIMER0_BASE + 4;
		
		/* let timer0 count, mode == 1'b0 */
		/* {28'b0, allow_irq, 1'b0, mode, enable} */
		#20;
		write_enable = 1;
		addr = `BRIDGE_TIMER0_BASE + 0;
		write_data = 32'b1001;
		
		#20;
		write_enable = 0;
		
		/* LOAD -> CNT -> CNT -> CNT -> CNT -> CNT -> INT -> IDLE -> IDLE */
		#20; #20; #20; #20; #20; #20; #20; #20; #20;
		
		/* disable irq of timer0 */
		#20;
		write_enable = 1;
		addr = `BRIDGE_TIMER0_BASE + 0;
		write_data = 32'b0;
		
		/* wait a cycle to make it actually effective */
		#20;
		write_enable = 0;
		
		/* let timer0 count, mode == 1'b1 */
		/* {28'b0, allow_irq, 1'b0, mode, enable} */
		#20;
		write_enable = 1;
		addr = `BRIDGE_TIMER0_BASE + 0;
		write_data = 32'b1011;
		
		#20;
		write_enable = 0;
		write_data = 32'b0;
		
		/* LOAD -> CNT -> CNT -> CNT -> CNT -> CNT -> INT -> IDLE */
		#20; #20; #20; #20; #20; #20; #20; #20;
		
		/* stop timer0's counting */
		/* {28'b0, allow_irq, mode, 1'b0, enable} */
		write_enable = 1;
		addr = `BRIDGE_TIMER0_BASE + 0;
		write_data = 32'b0;
		
		/* let timer0 count, mode == 1'b1 */
		/* {28'b0, allow_irq, 1'b0, mode, enable} */
		#20;
		write_enable = 1;
		addr = `BRIDGE_TIMER0_BASE + 0;
		write_data = 32'b1001;
		
		#20;
		write_enable = 0;
		write_data = 32'b0;
		
		/* LOAD -> CNT -> CNT */
		#20; #20; #20;
		
		/* disable irq of timer0 */
		write_enable = 1;
		addr = `BRIDGE_TIMER0_BASE + 0;
		write_data = 32'b0001;
		
		#20;
		write_enable = 0;
		write_data = 32'b0;
		
		/* CNT -> CNT -> CNT -> INT -> IDLE -> IDLE*/
		#20; #20; #20; #20; #20; #20;
		
		/* final reset */
		#20;
		write_enable = 0;
		addr = `BRIDGE_TIMER0_BASE;
		write_data = 32'b0;
	end
	
	always begin
		#10 clk = ~clk;
	end
      
endmodule

