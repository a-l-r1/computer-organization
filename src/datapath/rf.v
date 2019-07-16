`include "rf.h"

module rf(
	input clk, 
	input [4:0] read_addr1, 
	input [4:0] read_addr2, 
	input [4:0] write_addr, 
	input [31:0] write_data, 
	input write_enable, 
	output [31:0] read_result1, 
	output [31:0] read_result2
)

reg [31:1] registers [31:0];

initial begin
	/* TODO: for command? */
	registers = 0;
end

always @(posedge clk) begin
	if ((write_enable == RF_WRITE_ENABLED) && (write_addr != RF_ADDR_ZERO)) begin
		registers[write_addr] <= write_data;
	end
end

assign read_result1 = (read_addr1 != RF_ADDR_ZERO) ? registers[read_addr1] : 32'b0;

assign read_result2 = (read_addr2 != RF_ADDR_ZERO) ? registers[read_addr2] : 32'b0;

endmodule

