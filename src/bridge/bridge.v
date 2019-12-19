`include "bridge.h"
`include "dm.h"

module bridge(
	input clk, 
	input rst, 
	input [2:0] dm_mode, 
	output valid, 
	input stop, 

	input [31:0] addr, 
	input write_enable, 
	input [31:0] write_data, 
	output [31:0] read_result, 
	output [7:2] hwirq, 

	output [31:0] timer_addr, 
	output timer_write_enable, 
	output [31:0] timer_write_data, 
	input [31:0] timer_read_result, 
	input timer_irq, 

	output [31:0] uart_addr, 
	output uart_write_enable, 
	output [31:0] uart_write_data, 
	input [31:0] uart_read_result, 
	input uart_irq, 

	output [31:0] switches_addr, 
	output switches_write_enable, 
	output [31:0] switches_write_data, 
	input [31:0] switches_read_result, 
	input switches_irq, 

	output [31:0] led_addr, 
	output led_write_enable, 
	output [31:0] led_write_data, 
	input [31:0] led_read_result, 
	input led_irq, 

	output [31:0] nixie_addr, 
	output nixie_write_enable, 
	output [31:0] nixie_write_data, 
	input [31:0] nixie_read_result, 
	input nixie_irq, 

	output [31:0] buttons_addr, 
	output buttons_write_enable, 
	output [31:0] buttons_write_data, 
	input [31:0] buttons_read_result, 
	input buttons_irq
);

wire [3:0] curr_dev;

assign curr_dev = 
	($unsigned(addr) >= $unsigned(`BRIDGE_TIMER_LB) && $unsigned(addr) <= $unsigned(`BRIDGE_TIMER_UB)) ? `BRIDGE_TIMER : 
	($unsigned(addr) >= $unsigned(`BRIDGE_UART_LB) && $unsigned(addr) <= $unsigned(`BRIDGE_UART_UB)) ? `BRIDGE_UART : 
	($unsigned(addr) >= $unsigned(`BRIDGE_SWITCHES_LB) && $unsigned(addr) <= $unsigned(`BRIDGE_SWITCHES_UB)) ? `BRIDGE_SWITCHES : 
	($unsigned(addr) >= $unsigned(`BRIDGE_LED_LB) && $unsigned(addr) <= $unsigned(`BRIDGE_LED_UB)) ? `BRIDGE_LED : 
	($unsigned(addr) >= $unsigned(`BRIDGE_NIXIE_LB) && $unsigned(addr) <= $unsigned(`BRIDGE_NIXIE_UB)) ? `BRIDGE_NIXIE : 
	($unsigned(addr) >= $unsigned(`BRIDGE_BUTTONS_LB) && $unsigned(addr) <= $unsigned(`BRIDGE_BUTTONS_UB)) ? `BRIDGE_BUTTONS : 
	4'd15;

/* TODO: checking for more devices */
assign valid = 
	(dm_mode == `DM_NONE) || 

	(
		(curr_dev == `BRIDGE_TIMER) && 
		(dm_mode == `DM_W && addr[1:0] == 2'b0) && 
		(~(
			(dm_mode == `DM_W) && 
			(addr[1:0] == 2'b0) && 
			(write_enable == 1'b1) && 
			(
				(addr == $unsigned(`BRIDGE_TIMER_LB) + $unsigned(8))
			)
		))
	) || 

	(
		curr_dev == `BRIDGE_UART
	) || 

	(
		curr_dev == `BRIDGE_SWITCHES
	) || 

	(
		curr_dev == `BRIDGE_LED
	) || 

	(
		curr_dev == `BRIDGE_NIXIE
	) || 

	(
		curr_dev == `BRIDGE_BUTTONS
	);

assign timer_addr = 
	(curr_dev == `BRIDGE_TIMER) ? $unsigned(addr) - $unsigned(`BRIDGE_TIMER_LB) : 
	32'b0;
assign timer_write_enable = 
	(valid == 1'b1) && 
	(write_enable == 1'b1) && 
	(stop == 1'b0) && 
	(curr_dev == `BRIDGE_TIMER);
assign timer_write_data = write_data;

assign uart_addr = 
	(curr_dev == `BRIDGE_UART) ? $unsigned(addr) - $unsigned(`BRIDGE_UART_LB) : 
	32'b0;
assign uart_write_enable = 
        (valid == 1'b1) && 
        (write_enable == 1'b1) && 
        (stop == 1'b0) && 
        (curr_dev == `BRIDGE_UART);
assign uart_write_data = write_data;

assign switches_addr =
        (curr_dev == `BRIDGE_SWITCHES) ? $unsigned(addr) - $unsigned(`BRIDGE_SWITCHES_LB) : 
        32'b0;
assign switches_write_enable = 
        (valid == 1'b1) && 
        (write_enable == 1'b1) && 
        (stop == 1'b0) && 
        (curr_dev == `BRIDGE_SWITCHES);
assign switches_write_data = write_data;

assign led_addr =
        (curr_dev == `BRIDGE_LED) ? $unsigned(addr) - $unsigned(`BRIDGE_LED_LB) : 
        32'b0;
assign led_write_enable = 
        (valid == 1'b1) && 
        (write_enable == 1'b1) && 
        (stop == 1'b0) && 
        (curr_dev == `BRIDGE_LED);
assign led_write_data = write_data;

assign nixie_addr =
        (curr_dev == `BRIDGE_NIXIE) ? $unsigned(addr) - $unsigned(`BRIDGE_NIXIE_LB) : 
        32'b0;
assign nixie_write_enable = 
        (valid == 1'b1) && 
        (write_enable == 1'b1) && 
        (stop == 1'b0) && 
        (curr_dev == `BRIDGE_NIXIE);
assign nixie_write_data = write_data;

assign buttons_addr =
        (curr_dev == `BRIDGE_BUTTONS) ? $unsigned(addr) - $unsigned(`BRIDGE_BUTTONS_LB) : 
        32'b0;
assign buttons_write_enable = 
        (valid == 1'b1) && 
        (write_enable == 1'b1) && 
        (stop == 1'b0) && 
        (curr_dev == `BRIDGE_BUTTONS);
assign buttons_write_data = write_data;

assign read_result = 
	(curr_dev == `BRIDGE_TIMER) ? timer_read_result : 
	(curr_dev == `BRIDGE_UART) ? uart_read_result : 
	(curr_dev == `BRIDGE_SWITCHES) ? switches_read_result : 
	(curr_dev == `BRIDGE_LED) ? led_read_result : 
	(curr_dev == `BRIDGE_NIXIE) ? nixie_read_result : 
	(curr_dev == `BRIDGE_BUTTONS) ? buttons_read_result : 
	32'b0;

assign hwirq = {buttons_irq, nixie_irq, led_irq, switches_irq, uart_irq, timer_irq}; 

endmodule

