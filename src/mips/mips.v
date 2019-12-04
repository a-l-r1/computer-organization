module mips(
	input clk, 
	input reset, 
	input interrupt, 
	output [31:0] addr
);

wire rst;
assign rst = reset;

wire [31:0] cpu_addr;
wire [31:0] cpu_write_data, cpu_read_result;
wire [7:2] hwirq;
wire [2:0] dm_mode;

wire dev_write_enable, bridge_valid, bridge_stop;

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

bridge bridge(
	.clk(clk), 
	.rst(rst), 
	.addr(cpu_addr), 
	.write_enable(dev_write_enable), 
	.dm_mode(dm_mode), 
	.write_data(cpu_write_data), 
	.test_interrupt(interrupt), 
	.read_result(cpu_read_result), 
	.hwirq(hwirq), 
	.valid(bridge_valid), 
	.stop(bridge_stop)
);

endmodule

