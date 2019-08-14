`include "bridge.h"

module bridge(
	input clk, 
	input rst, 
	input [31:0] addr, 
	input write_enable, 
	input [31:0] write_data, 
	output [31:0] read_result, 
	output [5:0] hwirq
);

wire [3:0] curr_dev;
assign curr_dev = 
	($unsigned(addr) >= $unsigned(`BRIDGE_TIMER0_LB) && $unsigned(addr) <= $unsigned(`BRIDGE_TIMER0_UB)) ? 4'd0 : 
	($unsigned(addr) >= $unsigned(`BRIDGE_TIMER1_LB) && $unsigned(addr) <= $unsigned(`BRIDGE_TIMER1_UB)) ? 4'd1 : 
	4'd15;

wire [31:0] timer0_read_result, timer1_read_result;
wire timer0_write_enable, timer1_write_enable;
wire timer0_irq, timer1_irq;

timer #(.BASE(`BRIDGE_TIMER0_BASE)) timer0 (
	.clk(clk), 
	.rst(rst), 
	.addr(addr), 
	.write_enable(timer0_write_enable), 
	.write_data(write_data), 
	.read_result(timer0_read_result), 
	.irq(timer0_irq)
);

timer #(.BASE(`BRIDGE_TIMER1_BASE)) timer1 (
	.clk(clk), 
	.rst(rst), 
	.addr(addr), 
	.write_enable(timer1_write_enable), 
	.write_data(write_data), 
	.read_result(timer1_read_result), 
	.irq(timer1_irq)
);

assign read_result = 
	(curr_dev == 4'd0) ? timer0_read_result : 
	(curr_dev == 4'd1) ? timer1_read_result : 
	32'b0;

assign timer0_write_enable = (write_enable && (curr_dev == 4'd0));
assign timer1_write_enable = (write_enable && (curr_dev == 4'd1));

assign hwirq = {4'b0, timer1_irq, timer0_irq};

endmodule

