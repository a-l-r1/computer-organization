module mips(
	input clk_in, 
	input sys_rstn
);

wire clk, rst;
assign clk = clk_in;
assign rst = sys_rstn;

/* cpu <-> bridge */

wire [31:0] cpu_addr;
wire [31:0] cpu_write_data, cpu_read_result;
wire [7:2] hwirq;
wire [2:0] dm_mode;

wire dev_write_enable, bridge_valid, bridge_stop;

/* bridge <-> timers */

wire [31:0] timer0_addr, timer1_addr;
wire [31:0] timer0_write_data, timer1_write_data;
wire [31:0] timer0_read_result, timer1_read_result;
wire timer0_write_enable, timer1_write_enable;
wire timer0_irq, timer1_irq;

cpu cpu(
	.clk(clk), 
	.rst(rst), 
	.cpu_read_result(cpu_read_result), 
	.hwirq(hwirq), 
	.bridge_valid(bridge_valid), 
	.cpu_addr(cpu_addr), 
	.dev_write_enable(dev_write_enable), 
	.dm_mode(dm_mode), 
	.cpu_write_data(cpu_write_data), 
	.test_addr(addr), 
	.bridge_stop(bridge_stop)
);

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

	.timer0_addr(timer0_addr), 
	.timer0_write_enable(timer0_write_enable), 
	.timer0_write_data(timer0_write_data), 
	.timer0_read_result(timer0_read_result), 
	.timer0_irq(timer0_irq), 

	.timer1_addr(timer1_addr), 
	.timer1_write_enable(timer1_write_enable), 
	.timer1_write_data(timer1_write_data), 
	.timer1_read_result(timer1_read_result), 
	.timer1_irq(timer1_irq), 

	.test_interrupt(1'b0)
);

timer timer0 (
	.clk(clk), 
	.rst(rst), 

	.addr(timer0_addr[3:2]), 
	.write_enable(timer0_write_enable), 
	.write_data(timer0_write_data), 
	.read_result(timer0_read_result), 
	.irq(timer0_irq)
);

timer timer1 (
	.clk(clk), 
	.rst(rst), 

	.addr(timer1_addr[3:2]), 
	.write_enable(timer1_write_enable), 
	.write_data(timer1_write_data), 
	.read_result(timer1_read_result), 
	.irq(timer1_irq)
);

endmodule

