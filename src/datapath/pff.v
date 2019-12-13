`include "pff.h"

module pff(
	input clk, 
	input enable, 
	input rst, 
	input [BIT_WIDTH - 1:0] i, 
	output [BIT_WIDTH - 1:0] o
);

parameter BIT_WIDTH = 32;

reg [BIT_WIDTH - 1:0] data;

initial begin
	data <= 0;
end

always @(posedge clk) begin
	if (rst == 1'b1) begin
		data <= 0;
	end else begin
		if (enable == `PFF_ENABLED) begin
			data <= i;
		end else begin
			data <= data;
		end
	end
end

assign o = data;

endmodule

