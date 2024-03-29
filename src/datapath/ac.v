`include "ac.h"

`include "dm.h"
`include "bridge.h"

`define PART_NAME "ac"

`include "debug/debug.h"

module ac(
	input [31:0] addr, 
	input [2:0] dm_mode, 
	output [2:0] validity
);

wire [3:0] curr_dev;
wire oorange, bad_alignment, bad_mode;

assign curr_dev = 
	($unsigned(addr) >= $unsigned(`BRIDGE_TIMER_LB) && $unsigned(addr) <= $unsigned(`BRIDGE_TIMER_UB)) ? 4'd0 : 
	($unsigned(addr) >= $unsigned(`BRIDGE_UART_LB) && $unsigned(addr) <= $unsigned(`BRIDGE_UART_UB)) ? 4'd1 : 
	($unsigned(addr) >= $unsigned(`BRIDGE_SWITCHES_LB) && $unsigned(addr) <= $unsigned(`BRIDGE_SWITCHES_UB)) ? 4'd2 : 
	($unsigned(addr) >= $unsigned(`BRIDGE_LED_LB) && $unsigned(addr) <= $unsigned(`BRIDGE_LED_UB)) ? 4'd3 : 
	($unsigned(addr) >= $unsigned(`BRIDGE_NIXIE_LB) && $unsigned(addr) <= $unsigned(`BRIDGE_NIXIE_UB)) ? 4'd4 : 
	($unsigned(addr) >= $unsigned(`BRIDGE_BUTTONS_LB) && $unsigned(addr) <= $unsigned(`BRIDGE_BUTTONS_UB)) ? 4'd5 : 
	($unsigned(addr) >= $unsigned(`DM_ADDR_LB) && $unsigned(addr) <= $unsigned(`DM_ADDR_UB)) ? 4'd14 : 
	4'd15;

assign oorange = (curr_dev == 4'd15);

assign bad_alignment = 
	((dm_mode == `DM_H || dm_mode == `DM_HU) && addr[0] != 1'b0) || 
	(dm_mode == `DM_W && addr[1:0] != 2'b0);

assign bad_mode = 
	(curr_dev == 4'd0 || curr_dev == 4'd1) ? (
		(dm_mode != `DM_W) ? 1'b1 : 
		1'b0
	) : 
	1'b0;

assign unwriteable = 
	/* not complete but enough */
	/* TODO: more unwriteable registers? */
	(addr == $unsigned(`BRIDGE_TIMER_LB) + 8);

assign invalid = (oorange || bad_alignment || bad_mode || unwriteable) && (dm_mode != `DM_NONE);

assign validity = 
	(invalid) ? `AC_BAD : 
	`AC_VALID;

endmodule

