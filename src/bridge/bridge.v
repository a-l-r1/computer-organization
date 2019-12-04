`include "bridge.h"
`include "dm.h"

module bridge(
	input clk, 
	input rst, 
	input [31:0] addr, 
	input write_enable, 
	input [2:0] dm_mode, 
	input [31:0] write_data, 
	input test_interrupt, 
	input stop, 
	output [31:0] read_result, 
	output [7:2] hwirq, 
	output valid
);

wire [3:0] curr_dev;

wire timer0_write_enable, timer1_write_enable;
/* NOTE: timer[01]_addr are formal addresses (32-bit). Address slicing is done
 * at the declarations of the corresponding input ports of timer[01]. */
wire [31:0] timer0_addr, timer1_addr;
wire [31:0] timer0_read_result, timer1_read_result;
wire timer0_irq, timer1_irq;

assign curr_dev = 
	($unsigned(addr) >= $unsigned(`BRIDGE_TIMER0_LB) && $unsigned(addr) <= $unsigned(`BRIDGE_TIMER0_UB)) ? 4'd0 : 
	($unsigned(addr) >= $unsigned(`BRIDGE_TIMER1_LB) && $unsigned(addr) <= $unsigned(`BRIDGE_TIMER1_UB)) ? 4'd1 : 
	4'd15;

assign read_result = 
	(curr_dev == 4'd0) ? timer0_read_result : 
	(curr_dev == 4'd1) ? timer1_read_result : 
	32'b0;

assign valid = 
	(dm_mode == `DM_NONE) || 
	(
		(curr_dev == 4'd0 || curr_dev == 4'd1) && 
		(dm_mode == `DM_W && addr[1:0] == 2'b0) && 
		(~(
			(dm_mode == `DM_W) && 
			(addr[1:0] == 2'b0) && 
			(write_enable == 1'b1) && 
			(
				(addr == $unsigned(`BRIDGE_TIMER0_LB) + $unsigned(8)) || 
				(addr == $unsigned(`BRIDGE_TIMER1_LB) + $unsigned(8))
			)
		))
	);

assign timer0_write_enable = 
	(valid == 1'b1) && 
	(write_enable == 1'b1) && 
	(stop == 1'b0) && 
	(curr_dev == 4'd0);
assign timer0_addr = 
	(curr_dev == 4'd0) ? $unsigned(addr) - $unsigned(`BRIDGE_TIMER0_BASE) : 
	2'b0;

assign timer1_write_enable = 
	(valid == 1'b1) && 
	(write_enable == 1'b1) && 
	(stop == 1'b0) && 
	(curr_dev == 4'd1);
assign timer1_addr = 
	(curr_dev == 4'd1) ? $unsigned(addr) - $unsigned(`BRIDGE_TIMER1_BASE) : 
	2'b0;

assign hwirq = {3'b0, test_interrupt, timer1_irq, timer0_irq};

timer timer0 (
	.clk(clk), 
	.rst(rst), 
	.addr(timer0_addr[3:2]), 
	.write_enable(timer0_write_enable), 
	.write_data(write_data), 
	.read_result(timer0_read_result), 
	.irq(timer0_irq)
);

timer timer1 (
	.clk(clk), 
	.rst(rst), 
	.addr(timer1_addr[3:2]), 
	.write_enable(timer1_write_enable), 
	.write_data(write_data), 
	.read_result(timer1_read_result), 
	.irq(timer1_irq)
);

endmodule

