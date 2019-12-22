`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:06:16 12/21/2019
// Design Name:   mips
// Module Name:   /home/a-l-r/co/src/tests/cpu/pipelined3/pipelined3_p8_at_tb2.v
// Project Name:  cpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mips
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module pipelined3_p8_at_tb2;

	// Inputs
	reg clk_in;
	reg sys_rstn;
	reg uart_rxd;
	reg uart_rxd2;
	reg [7:0] dip_switch0;
	reg [7:0] dip_switch1;
	reg [7:0] dip_switch2;
	reg [7:0] dip_switch3;
	reg [7:0] dip_switch4;
	reg [7:0] dip_switch5;
	reg [7:0] dip_switch6;
	reg [7:0] dip_switch7;
	reg [7:0] user_key;

	// Outputs
	wire uart_txd;
	wire uart_txd2;
	wire [31:0] led_light;
	wire [7:0] digital_tube0;
	wire [3:0] digital_tube_sel0;
	wire [7:0] digital_tube1;
	wire [3:0] digital_tube_sel1;
	wire [7:0] digital_tube2;
	wire digital_tube_sel2;

	// Instantiate the Unit Under Test (UUT)
	mips uut (
		.clk_in(clk_in), 
		.sys_rstn(sys_rstn), 
		.uart_rxd(uart_rxd), 
		.uart_txd(uart_txd), 
		.uart_rxd2(uart_rxd2), 
		.uart_txd2(uart_txd2), 
		.dip_switch0(dip_switch0), 
		.dip_switch1(dip_switch1), 
		.dip_switch2(dip_switch2), 
		.dip_switch3(dip_switch3), 
		.dip_switch4(dip_switch4), 
		.dip_switch5(dip_switch5), 
		.dip_switch6(dip_switch6), 
		.dip_switch7(dip_switch7), 
		.led_light(led_light), 
		.digital_tube0(digital_tube0), 
		.digital_tube_sel0(digital_tube_sel0), 
		.digital_tube1(digital_tube1), 
		.digital_tube_sel1(digital_tube_sel1), 
		.digital_tube2(digital_tube2), 
		.digital_tube_sel2(digital_tube_sel2), 
		.user_key(user_key)
	);

	initial begin
		clk_in = 0;
		sys_rstn = 0;
		{dip_switch7,dip_switch6,dip_switch5,dip_switch4,dip_switch3,dip_switch2,dip_switch1,dip_switch0} = ~0;
		uart_rxd = 1;
		uart_rxd2 = 1;
		
		user_key = ~0;
		#600
		sys_rstn = 1;

		#1000
		user_key = 8'b11111110;
		#10
		user_key = 8'b11111111;
		#2000
		user_key = 8'b11111110;
		#10
		user_key = 8'b11111111;
		#2000
		user_key = 8'b11111110;
		#10
		user_key = 8'b11111111;
		#2000
		user_key = 8'b11111110;
		#10
		user_key = 8'b11111111;
		#2000
		user_key = 8'b11111110;
		#10
		user_key = 8'b11111111;
		#2000
		user_key = 8'b11111110;
		#10
		user_key = 8'b11111111;
		#2000
		user_key = 8'b11111110;
		#10
		user_key = 8'b11111111;
		#2000
		user_key = 8'b11111110;
		#10
		user_key = 8'b11111111;
		#2000
		user_key = 8'b11111110;
		#10
		user_key = 8'b11111111;
		
	end
	always #1 clk_in = ~clk_in;
      
endmodule

