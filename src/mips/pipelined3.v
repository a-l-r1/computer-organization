module mips(
	input clk, 
	input rst
);

wire [31:0] cpu_addr;
wire [31:0] cpu_write_data, cpu_read_result;
wire [5:0] hwirq;
wire dev_write_enable;

cpu cpu(
	.clk(clk), 
	.rst(rst), 
	.cpu_addr(cpu_addr), 
	.dev_write_enable(dev_write_enable), 
	.cpu_write_data(cpu_write_data), 
	.cpu_read_result(cpu_read_result), 
	.hwirq(hwirq)
);

bridge bridge(
	.clk(clk), 
	.rst(rst), 
	.addr(cpu_addr), 
	.write_enable(dev_write_enable), 
	.write_data(cpu_write_data), 
	.read_result(cpu_read_result), 
	.hwirq(hwirq)
);

endmodule

