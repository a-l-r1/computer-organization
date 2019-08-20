`include "rf.h"

`define PART_NAME "rf"

`include "debug/debug.h"

module rf(
	input clk, 
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
	for (i = 1; i <= 31; i = i + 1) begin
		registers[i] = 32'b0;
	end
end

always @(posedge clk) begin
	`debug_write(("curr_pc = 0x%08x, write_enable = %0d, read_addr1 = %0d, read_addr2 = %0d, write_addr = %0d\n", curr_pc, write_enable, read_addr1, read_addr2, write_addr));
	`debug_write(("read_result1 = 0x%08x, read_result2 = 0x%08x, write_data = 0x%08x\n", read_result1, read_result2, write_data));
end

always @(posedge clk) begin
	if (rst == 1'b1) begin
		registers[1] <= 0;
		registers[2] <= 0;
		registers[3] <= 0;
		registers[4] <= 0;
		registers[5] <= 0;
		registers[6] <= 0;
		registers[7] <= 0;
		registers[8] <= 0;
		registers[9] <= 0;
		registers[10] <= 0;
		registers[11] <= 0;
		registers[12] <= 0;
		registers[13] <= 0;
		registers[14] <= 0;
		registers[15] <= 0;
		registers[16] <= 0;
		registers[17] <= 0;
		registers[18] <= 0;
		registers[19] <= 0;
		registers[20] <= 0;
		registers[21] <= 0;
		registers[22] <= 0;
		registers[23] <= 0;
		registers[24] <= 0;
		registers[25] <= 0;
		registers[26] <= 0;
		registers[27] <= 0;
		registers[28] <= 0;
		registers[29] <= 0;
		registers[30] <= 0;
		registers[31] <= 0;
	end else begin
		if (write_enable == `RF_WRITE_ENABLED) begin
			if (write_addr != `RF_ADDR_ZERO) begin
				`normal_display((`RF_OUTPUT_FORMAT, $time, curr_pc, write_addr, write_data));
				registers[write_addr] <= write_data;
			end
		end
	end
end

assign read_result1 = (read_addr1 != `RF_ADDR_ZERO) ? registers[read_addr1] : 32'b0;

assign read_result2 = (read_addr2 != `RF_ADDR_ZERO) ? registers[read_addr2] : 32'b0;

endmodule

