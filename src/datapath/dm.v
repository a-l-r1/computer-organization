`include "dm.h"

`define PART_NAME "dm"

`include "debug/debug.h"

module dm(
	input clk, 
	input [31:0] curr_pc, 
	input [31:0] read_addr, 
	input [31:0] write_addr, 
	input [31:0] write_data, 
	input write_enable, 
	input [2:0] mode, 
	output [31:0] read_result, 
	output invalid
);

`define rword memory[read_addr[`DM_ADDR_WIDTH - 1:2]]
`define wword memory[write_addr[`DM_ADDR_WIDTH - 1:2]]

reg [31:0] memory [`DM_SIZE - 1:0];

wire [31:0] op_addr;
wire [31:0] new_word;
wire valid;

integer i;

initial begin
	for (i = 0; i < `DM_SIZE; i = i + 1) begin
		memory[i] = 32'b0;
	end
end

always @(posedge clk) begin
	`debug_write(("curr_pc = 0x%08x, mode = 0x%08x, write_enable = %0d, read_addr = 0x%08x, write_addr = 0x%08x\n", curr_pc, mode, write_enable, read_addr, write_addr));
	`debug_write(("read_result = 0x%08x, write_data = 0x%08x\n", read_result, write_data));
end

assign op_addr = (write_enable == `DM_WRITE_ENABLED) ? write_addr : read_addr;

assign valid = 
	mode == `DM_NONE || 
	(mode == `DM_W && op_addr[1:0] == 2'b0) || 
	(mode == `DM_H && op_addr[0] == 1'b0) || 
	(mode == `DM_HU && op_addr[0] == 1'b0) || 
	mode == `DM_B || 
	mode == `DM_BU;

assign invalid = ~valid;

assign new_word = 
	/* The next line has the most precedence */
	(invalid == 1'b1) ? 32'b0 : 
	(mode == `DM_W) ? write_data : 
	(mode == `DM_H) ? (
		(write_addr[1] == 1'b0) ? {`wword[31:16], write_data[15:8], write_data[7:0]} : 
		{write_data[15:8], write_data[7:0], `wword[15:0]}
	) : 
	(mode == `DM_B) ? (
		(write_addr[1:0] == 2'b00) ? {`wword[31:8], write_data[7:0]} : 
		(write_addr[1:0] == 2'b01) ? {`wword[31:16], write_data[7:0], `wword[7:0]} : 
		(write_addr[1:0] == 2'b10) ? {`wword[31:24], write_data[7:0], `wword[15:0]} : 
		(write_addr[1:0] == 2'b11) ? {write_data[7:0], `wword[23:0]} : 
		`wword
	) : 
	`wword;

always @(posedge clk) begin
	if (write_enable == `DM_WRITE_ENABLED && invalid == 1'b0) begin
		memory[write_addr[`DM_ADDR_WIDTH:2]] <= new_word;
		`normal_display((`DM_OUTPUT_FORMAT, $time, curr_pc, {write_addr[31:2], 2'b0}, new_word));
	end
end

assign read_result = 
	/* The next line has the most precedence */
	(invalid == 1'b1) ? 32'b0 : 
	(mode == `DM_NONE) ? 32'b0 : 
	(mode == `DM_W) ? `rword : 
	(mode == `DM_H) ? (
		(read_addr[1] == 1'b0) ? {{16{`rword[15]}}, `rword[15:0]} : {{16{`rword[31]}}, `rword[31:16]}
	) : 
	(mode == `DM_HU) ? (
		(read_addr[1] == 1'b0) ? {{16{1'b0}}, `rword[15:0]} : {{16{1'b0}}, `rword[31:16]}
	) : 
	(mode == `DM_B) ? (
		(read_addr[1:0] == 2'b00) ? {{24{`rword[7]}}, `rword[7:0]} : 
		(read_addr[1:0] == 2'b01) ? {{24{`rword[15]}}, `rword[15:8]} : 
		(read_addr[1:0] == 2'b10) ? {{24{`rword[23]}}, `rword[23:16]} : 
		(read_addr[1:0] == 2'b11) ? {{24{`rword[31]}}, `rword[31:24]} : 
		`rword[7:0]
	) : 
	(mode == `DM_BU) ? (
		(read_addr[1:0] == 2'b00) ? {{24{1'b0}}, `rword[7:0]} : 
		(read_addr[1:0] == 2'b01) ? {{24{1'b0}}, `rword[15:8]} : 
		(read_addr[1:0] == 2'b10) ? {{24{1'b0}}, `rword[23:16]} : 
		(read_addr[1:0] == 2'b11) ? {{24{1'b0}}, `rword[31:24]} : 
		`rword[7:0]
	) : 
	32'b0;

endmodule

