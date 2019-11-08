`include "dm.h"

`define PART_NAME "dm"

module dm(
	input clk, 
	input rst, 
	input [31:0] curr_pc, 
	input [31:0] read_addr, 
	input [31:0] write_addr, 
	input [31:0] write_data, 
	input write_enable, 
	output [31:0] read_result
);

reg [31:0] memory [`DM_SIZE - 1:0];

integer i;

initial begin
	for (i = 0; i < `DM_SIZE; i = i + 1) begin
		memory[i] = 32'b0;
	end
end

always @(posedge clk) begin
	if (rst == 1'b1) begin
		for (i = 0; i < `DM_SIZE; i = i + 1) begin
			memory[i] <= 32'b0;
		end
	end else begin
		if (write_enable == `DM_WRITE_ENABLE) begin
			memory[write_addr[`DM_ADDR_WIDTH - 1:2]] <= write_data;
			$display(`DM_OUTPUT_FORMAT, curr_pc, write_addr, write_data);
		end
	end
end

assign read_result = memory[read_addr[`DM_ADDR_WIDTH - 1:2]];

endmodule

