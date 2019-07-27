`include "dm.h"

module dm(
	input clk, 
	input [31:0] read_addr, 
	input [31:0] write_addr, 
	input [31:0] write_data, 
	input write_enable, 
	output [31:0] read_result
);

reg [31:0] memory [`DM_ADDR_WIDTH - 1:0];

integer i;

initial begin
	for (i = 0; i < `DM_ADDR_WIDTH; i = i + 1) begin
		memory[i] = 32'b0;
	end
end

always @(posedge clk) begin
	if (write_enable == `DM_WRITE_ENABLE) begin
		memory[write_addr[`DM_ADDR_WIDTH - 1:2]] <= write_data;
	end

	`normal_display((`DM_OUTPUT_FORMAT, write_addr, memory[write_addr[`DM_ADDR_WIDTH - 1:2]], write_result));
end

assign read_result = memory[read_addr[`DM_ADDR_WIDTH - 1:2]];

always @(posedge clk) begin
	`debug_write(("write_enable = %0d, read_addr = 0x%08x, write_addr = 0x%08x\n", write_enable, read_addr, write_addr));
	`debug_write(("read_result = 0x%08x, write_result = 0x%08x\n", read_result, write_result));
end

endmodule

