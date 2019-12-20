module uart_shim(
	input clk, 
	input rst, 

	input [2:0] addr, 
	input write_enable, 
	input [31:0] write_data, 
	output [31:0] read_result, 
	output irq, 

	input uart_rxd, 
	output uart_txd
);

MiniUART uart(
	.CLK_I(clk), 
	.RST_I(rst), 

	.ADD_I(addr[2:0]), 
	.STB_I(write_enable), 
	.WE_I(write_enable), 
	.DAT_I(write_data), 
	.DAT_O(read_result), 
	.IRQ_O(irq), 

	/* unused */
	.ACK_O(), 
	
	.RxD(uart_rxd), 
	.TxD(uart_txd)
);

endmodule

