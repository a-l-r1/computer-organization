`include "bridge.h"

`include "dm.h"

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
	($unsigned(addr) >= $unsigned(`BRIDGE_TIMER_LB) && $unsigned(addr) <= $unsigned(`BRIDGE_TIMER_UB)) ? 4'd0 : 
	($unsigned(addr) >= $unsigned(`BRIDGE_UART_LB) && $unsigned(addr) <= $unsigned(`BRIDGE_UART_UB)) ? 4'd1 : 
	($unsigned(addr) >= $unsigned(`BRIDGE_SWITCHES_LB) && $unsigned(addr) <= $unsigned(`BRIDGE_SWITCHES_UB)) ? 4'd2 : 
	($unsigned(addr) >= $unsigned(`BRIDGE_LED_LB) && $unsigned(addr) <= $unsigned(`BRIDGE_LED_UB)) ? 4'd3 : 
	($unsigned(addr) >= $unsigned(`BRIDGE_NIXIE_LB) && $unsigned(addr) <= $unsigned(`BRIDGE_NIXIE_UB)) ? 4'd4 : 
	($unsigned(addr) >= $unsigned(`BRIDGE_BUTTONS_LB) && $unsigned(addr) <= $unsigned(`BRIDGE_BUTTONS_UB)) ? 4'd5 : 
	($unsigned(addr) >= $unsigned(`DM_ADDR_LB) && $unsigned(addr) <= $unsigned(`DM_ADDR_UB)) ? 4'd14 : 
	4'd15;

wire [31:0] timer_read_result, uart_read_result, switches_read_result, led_read_result, nixie_read_result, buttons_read_result;
wire timer_write_enable, uart_write_enable, switches_write_enable, led_write_enable, nixie_write_enable, buttons_write_enable;
wire timer_irq, uart_irq;

timer #(.BASE(`BRIDGE_TIMER_LB)) timer(
	.clk(clk), 
	.rst(rst), 
	.addr(addr), 
	.write_enable(timer_write_enable), 
	.write_data(write_data), 
	.read_result(timer_read_result), 
	.irq(timer_irq)
);

wire [2:0] uart_add_i;
wire uart_stb_i, uart_ack_o;

assign uart_add_i = 
	(curr_dev == 4'd1) ? ($unsigned(addr) - $unsigned(`BRIDGE_UART_LB) / 4) : 
	3'b0;

assign uart_stb_i = (curr_dev == 4'd1);

MiniUART uart(
	.CLK_I(clk), 
	.DAT_I(write_data), 
	.DAT_O(uart_read_result), 
	.RST_I(rst), 
	.ADD_I(uart_add_i), 
	.STB_I(uart_stb_i), 
	.WE_I(uart_write_enable), 
	.ACK_O(uart_ack_o), 
	.RxD(uart_rxd), 
	.TxD(uart_txd), 
	.IRQ_data_complete(uart_irq)
);

switches #(.BASE(`BRIDGE_SWITCHES_LB)) switches(
	.clk(clk), 
	.rst(rst), 
	.addr(addr), 
	.dip_switch7(dip_switch7), 
	.dip_switch6(dip_switch6), 
	.dip_switch5(dip_switch5), 
	.dip_switch4(dip_switch4), 
	.dip_switch3(dip_switch3), 
	.dip_switch2(dip_switch2),  
	.dip_switch1(dip_switch1), 
	.dip_switch0(dip_switch0), 
	.out(switches_read_result)
);

led led(
	.clk(clk), 
	.rst(rst), 
	.we(led_write_enable), 
	.wd(write_data), 
	.addr(addr), 
	.led_light(led_read_result)
);

nixie nixie(
	.clk(clk), 
	.rst(rst), 
	.we(nixie_write_enable), 
	.wd(write_data), 
	.addr(addr), 
	.rd(nixie_read_result), 
	.digital_tube0(digital_tube0), 
	.digital_tube1(digital_tube1), 
	.digital_tube2(digital_tube2), 
	.digital_tube_sel0(digital_tube_sel0), 
	.digital_tube_sel1(digital_tube_sel1), 
	.digital_tube_sel2(digital_tube_sel2)
);

buttons buttons(
	.clk(clk), 
	.rst(rst), 
	.input_(user_key), 
	.addr(addr), 
	.out(buttons_read_result)
);

assign read_result = 
	(curr_dev == 4'd0) ? timer_read_result : 
	(curr_dev == 4'd1) ? uart_read_result : 
	(curr_dev == 4'd2) ? switches_read_result : 
	(curr_dev == 4'd3) ? led_read_result : 
	(curr_dev == 4'd4) ? nixie_read_result : 
	(curr_dev == 4'd5) ? buttons_read_result : 
	32'b0;

assign timer_write_enable = (write_enable && (curr_dev == 4'd0));
assign uart_write_enable = (write_enable && (curr_dev == 4'd1));
assign switches_write_enable = (write_enable && (curr_dev == 4'd2));
assign led_write_enable = (write_enable && (curr_dev == 4'd3));
assign nixie_write_enable = (write_enable && (curr_dev == 4'd4));
assign buttons_write_enable = (write_enable && (curr_dev == 4'd5));

assign hwirq = {4'b0, uart_irq, timer_irq};

endmodule

