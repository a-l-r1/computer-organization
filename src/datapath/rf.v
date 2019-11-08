`include "rf.h"

`define PART_NAME "rf"

module rf(
	input clk, 
	input rst, 
	input [31:0] curr_pc, 
	input [4:0] read_addr1, 
	input [4:0] read_addr2, 
	input [4:0] write_addr, 
	input [31:0] write_data, 
	input write_enable, 
	output [31:0] read_result1, 
	output [31:0] read_result2
);

reg [31:0] registers [31:1];

integer i;

initial begin
	for (i = 1; i < 31; i = i + 1) begin
		registers[i] = 32'b0;
	end
end

always @(posedge clk) begin
	if (rst == 1'b1) begin
		for (i = 1; i < 31; i = i + 1) begin
			registers[i] <= 32'b0;
		end
	end else begin
		if (write_enable == `RF_WRITE_ENABLED && write_addr != 0) begin
			$display("@%h: $%d <= %h", curr_pc, write_addr, write_data);
			registers[write_addr] <= write_data;
		end
	end
end

assign read_result1 = (read_addr1 != `RF_ADDR_ZERO) ? registers[read_addr1] : 32'b0;

assign read_result2 = (read_addr2 != `RF_ADDR_ZERO) ? registers[read_addr2] : 32'b0;

endmodule

