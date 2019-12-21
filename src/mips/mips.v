module mips(
	input clk_in, 
	input sys_rstn, 

	input uart_rxd, 
	output uart_txd, 

	input uart_rxd2, 
	output uart_txd2, 

	input [7:0] dip_switch0,
	input [7:0] dip_switch1,
	input [7:0] dip_switch2,
	input [7:0] dip_switch3,
	input [7:0] dip_switch4,
	input [7:0] dip_switch5,
	input [7:0] dip_switch6,
	input [7:0] dip_switch7,

	output [31:0] led_light, 

	output [7:0] digital_tube0, 
	output [3:0] digital_tube_sel0, 
	output [7:0] digital_tube1, 
	output [3:0] digital_tube_sel1, 
	output [7:0] digital_tube2, 
	output digital_tube_sel2, 

	input [7:0] user_key
);

wire clk, clk_2x;

clk_ipcore clk_ipcore(
	.CLK_IN1(clk_in), 
	.CLK_OUT1(clk), 
	.CLK_OUT2(clk_2x)
);

wire rst;
assign rst = ~sys_rstn;

/* cpu <-> wrapper */

wire [31:0] test_m_addr, test_m_wdata;
wire test_m_we;

/* cpu <-> bridge */

wire [31:0] cpu_addr;
wire [31:0] cpu_write_data, cpu_read_result;
wire [7:2] hwirq;
wire [2:0] dm_mode;

wire dev_write_enable, bridge_valid, bridge_stop;

/* bridge <-> devices */

wire [31:0] timer_addr, timer_write_data, timer_read_result;
wire timer_write_enable, timer_irq;

wire [31:0] uart_addr, uart_write_data, uart_read_result;
wire uart_write_enable, uart_irq;

wire [31:0] switches_addr, switches_write_data, switches_read_result;
wire switches_write_enable, switches_irq;

wire [31:0] led_addr, led_write_data, led_read_result;
wire led_write_enable, led_irq;

wire [31:0] nixie_addr, nixie_write_data, nixie_read_result;
wire nixie_write_enable, nixie_irq;

wire [31:0] buttons_addr, buttons_write_data, buttons_read_result;
wire buttons_write_enable, buttons_irq;

cpu cpu(
	.clk(clk), 
	.clk_2x(clk_2x), 
	.rst(rst), 
	.cpu_read_result(cpu_read_result), 
	.hwirq(hwirq), 
	.bridge_valid(bridge_valid), 
	.cpu_addr(cpu_addr), 
	.dev_write_enable(dev_write_enable), 
	.dm_mode(dm_mode), 
	.cpu_write_data(cpu_write_data), 
	/* .test_addr(dummy_test_addr), */
	/* now unused */
	.test_addr(), 
	.bridge_stop(bridge_stop), 

	.test_m_addr(test_m_addr), 
	.test_m_we(test_m_we), 
	.test_m_wdata(test_m_wdata)
);

/*
wrapper wrapper(
	.clk(clk), 
	.reset(rst), 

	.F_addr(0), 
	.F_instr(0), 

	.M_addr(test_m_addr), 
	.M_WE(test_m_we), 
	.M_RE(0), 
	.M_Wdata(test_m_wdata), 
	.M_Rdata(0), 

	.user_F_addr(), 
	.user_F_instr(), 
	.user_M_addr(), 
	.user_M_WE(), 
	.user_M_RE(), 
	.user_M_WData(), 
	.user_M_RData(), 

	.rxd(uart_rxd2), 
	.txd(uart_txd2), 

	.txd_buffer()
);
*/

/* NOTE: timer[01]_addr are formal addresses (32-bit). Address slicing is done
 * at the declarations of the corresponding input ports of timer[01]. */

bridge bridge(
	.clk(clk), 
	.rst(rst), 

	.dm_mode(dm_mode), 
	.valid(bridge_valid), 
	.stop(bridge_stop), 

	.addr(cpu_addr), 
	.write_enable(dev_write_enable), 
	.write_data(cpu_write_data), 
	.read_result(cpu_read_result), 
	.hwirq(hwirq), 

	.timer_addr(timer_addr), 
	.timer_write_enable(timer_write_enable), 
	.timer_write_data(timer_write_data), 
	.timer_read_result(timer_read_result), 
	.timer_irq(timer_irq), 

	.uart_addr(uart_addr), 
	.uart_write_enable(uart_write_enable), 
	.uart_write_data(uart_write_data), 
	.uart_read_result(uart_read_result), 
	.uart_irq(uart_irq), 

	.switches_addr(switches_addr), 
	.switches_write_enable(switches_write_enable), 
	.switches_write_data(switches_write_data), 
	.switches_read_result(switches_read_result), 
	.switches_irq(switches_irq), 

	.led_addr(led_addr), 
	.led_write_enable(led_write_enable), 
	.led_write_data(led_write_data), 
	.led_read_result(led_read_result), 
	.led_irq(led_irq), 

	.nixie_addr(nixie_addr), 
	.nixie_write_enable(nixie_write_enable), 
	.nixie_write_data(nixie_write_data), 
	.nixie_read_result(nixie_read_result), 
	.nixie_irq(nixie_irq), 

	.buttons_addr(buttons_addr), 
	.buttons_write_enable(buttons_write_enable), 
	.buttons_write_data(buttons_write_data), 
	.buttons_read_result(buttons_read_result), 
	.buttons_irq(buttons_irq)
);

timer timer(
	.clk(clk), 
	.rst(rst), 

	.addr(timer_addr[3:2]), 
	.write_enable(timer_write_enable), 
	.write_data(timer_write_data), 
	.read_result(timer_read_result), 
	.irq(timer_irq)
);

uart_shim uart_shim(
	.clk(clk), 
	.rst(rst), 

	.addr(uart_addr[4:2]), 
	.write_enable(uart_write_enable), 
	.write_data(uart_write_data), 
	.read_result(uart_read_result), 
	.irq(uart_irq), 

	.uart_rxd(uart_rxd), 
	.uart_txd(uart_txd)
);

switches switches(
	.clk(clk), 
	.rst(rst), 

	.addr(switches_addr[2]), 
	.write_enable(switches_write_enable), 
	.write_data(switches_write_data), 
	.read_result(switches_read_result), 
	.irq(switches_irq), 

	.dip_switch0(dip_switch0), 
	.dip_switch1(dip_switch1), 
	.dip_switch2(dip_switch2), 
	.dip_switch3(dip_switch3), 
	.dip_switch4(dip_switch4), 
	.dip_switch5(dip_switch5), 
	.dip_switch6(dip_switch6), 
	.dip_switch7(dip_switch7)
);

led led(
	.clk(clk), 
	.rst(rst), 

	.addr(led_addr), 
	.write_enable(led_write_enable), 
	.write_data(led_write_data), 
	.read_result(led_read_result), 
	.irq(led_irq), 

	.led_light(led_light)
);

nixie nixie(
	.clk(clk), 
	.rst(rst), 

	.addr(nixie_addr[2]), 
	.write_enable(nixie_write_enable), 
	.write_data(nixie_write_data), 
	.read_result(nixie_read_result), 
	.irq(nixie_irq), 

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

	.addr(buttons_addr), 
	.write_enable(buttons_write_enable), 
	.write_data(buttons_write_data), 
	.read_result(buttons_read_result), 
	.irq(buttons_irq), 
	
	.user_key(user_key)
);

endmodule

