`include "pff.h"

`define PART_NAME "pff"

`include "debug/debug.h"

module pff(
	input clk, 
	input enable, 
	input [BIT_WIDTH - 1:0] i, 
	output [BIT_WIDTH - 1:0] o
);

parameter BIT_WIDTH = 32;

reg [BIT_WIDTH - 1:0] data;

initial begin
	data <= 0;
end

always @(posedge clk) begin
	if (enable == `PFF_ENABLED) begin
		data <= i;
	end
end

assign o = (enable == `PFF_ENABLED) ? data : 
	0;

endmodule

