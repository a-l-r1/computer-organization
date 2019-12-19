`include "dm.h"

module dm(
	input clk, 
	input rst, 
	input [31:0] curr_pc, 
	input [31:0] read_addr, 
	input [31:0] write_addr, 
	input [31:0] write_data, 
	input write_enable, 
	input [2:0] mode, 
	input stop, 
	output [31:0] read_result, 
	output valid
);

/*
`define rword memory[read_addr[`DM_ADDR_WIDTH - 1:2]]
`define wword memory[write_addr[`DM_ADDR_WIDTH - 1:2]]
*/

/* reg [31:0] memory [`DM_SIZE - 1:0]; */

wire [31:0] op_addr;
wire [31:0] new_word;
wire [31:0] dm_ipcore_read_result;
wire [3:0] write_bitmask;

integer i;

/*
initial begin
	for (i = 0; i < `DM_SIZE; i = i + 1) begin
		memory[i] = 32'b0;
	end
end
*/

assign op_addr = (write_enable == `DM_WRITE_ENABLED) ? write_addr : read_addr;

assign valid = 
	(mode == `DM_NONE) || 
	(
		$unsigned(op_addr) >= $unsigned(`DM_ADDR_LB) && 
		$unsigned(op_addr) <= $unsigned(`DM_ADDR_UB) && 
		(
			(mode == `DM_W && op_addr[1:0] == 2'b0) || 
			((mode == `DM_H || mode == `DM_HU) && op_addr[0] == 1'b0) || 
			(mode == `DM_B || mode == `DM_BU)
		)
	);

assign write_bitmask = 
	/* Remember the precedence! */
	(valid == 1'b0 || write_enable == 1'b0 || stop == 1'b1) ? 4'b0000 : 
	(mode == `DM_W) ? 4'b1111 : 
	(mode == `DM_H) ? (
		(write_addr[1] == 1'b0) ? 4'b0011 : 
		(write_addr[1] == 1'b1) ? 4'b1100 : 
		4'b0000
	) : 
	(mode == `DM_B) ? (
		(write_addr[1:0] == 2'b00) ? 4'b0001 : 
		(write_addr[1:0] == 2'b01) ? 4'b0010 : 
		(write_addr[1:0] == 2'b10) ? 4'b0100 : 
		(write_addr[1:0] == 2'b11) ? 4'b1000 : 
		4'b0000
	) : 
	4'b0000;

/*
assign new_word = 
	/ Remember the precedence! /
	(valid == 1'b0 || write_enable == 1'b0) ? `wword : 
	(write_bitmask == 4'b0000) ? `wword : 
	(write_bitmask == 4'b1111) ? write_data : 
	(write_bitmask == 4'b0011) ? {`wword[31:16], write_data[15:0]} : 
	(write_bitmask == 4'b1100) ? {write_data[15:0], `wword[15:0]} : 
	(write_bitmask == 4'b0001) ? {`wword[31:24], `wword[23:16], `wword[15:8], write_data[7:0]} : 
	(write_bitmask == 4'b0010) ? {`wword[31:24], `wword[23:16], write_data[7:0], `wword[7:0]} : 
	(write_bitmask == 4'b0100) ? {`wword[31:24], write_data[7:0], `wword[15:8], `wword[7:0]} : 
	(write_bitmask == 4'b1000) ? {write_data[7:0], `wword[23:16], `wword[15:8], `wword[7:0]} : 
	`wword;

always @(posedge clk) begin
	if (rst == 1'b1) begin
		for (i = 0; i < `DM_SIZE; i = i + 1) begin
			memory[i] = 32'b0;
		end
	end else begin
		if (write_enable == `DM_WRITE_ENABLED && valid == 1'b1 && stop == 1'b0) begin
			/ NOTE: DO NOT USE $display(..., memory[i]). /
			memory[write_addr[`DM_ADDR_WIDTH:2]] <= new_word;
			$display(`DM_OUTPUT_FORMAT, $time, curr_pc, {write_addr[31:2], 2'b0}, new_word);
		end
	end
end
*/

/* NOTE: Use doubled frequency clock and hardcoded address width. */
dm_ipcore dm_ipcore(
	.clka(clk), 
	.wea(write_bitmask), 
	.addra(op_addr[14:2]), 
	.dina(write_data), 
	.douta(dm_ipcore_read_result)
);

/*
assign read_result = 
	/ Remember the precedence! /
	(valid == 1'b0 || mode == `DM_NONE) ? 32'b0 : 
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
*/

`define rword dm_ipcore_read_result

assign read_result = 
	/* Remember the precedence! */
	(valid == 1'b0 || mode == `DM_NONE) ? 32'b0 : 
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

