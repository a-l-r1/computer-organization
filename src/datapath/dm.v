`include "dm.h"

module dm(
	input clk, 
	input [`DM_ADDR_WIDTH - 1:0] read_addr, 
	input [`DM_ADDR_WIDTH - 1:0] write_addr, 
	input [31:0] write_data, 
	input write_enable, 
	output [`DM_ADDR_WIDTH - 1:0] read_result
);

reg [31:0] memory [`DM_ADDR_WIDTH - 1:0];

integer i;

initial begin
	for (i = 0; i < `DM_ADDR_WIDTH; i = i + 1) begin
		memory[i] = 32'b0;
	end
end

always @(posedge clk) begin
	if (write_enable == `DM_ENABLE) begin
		memory[write_addr[`DM_ADDR_WIDTH - 1:2]] <= write_data;
	end
end

assign read_result = memory[read_addr[`DM_ADDR_WIDTH - 1:2]];

endmodule

