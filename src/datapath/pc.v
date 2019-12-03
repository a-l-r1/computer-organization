`include "pc.h"

`include "im.h"

module pc(
	input clk, 
	input rst, 
	input [31:0] next_pc, 
	input enable, 
	output [31:0] curr_pc, 
	output invalid
);

reg [31:0] saved_pc;

initial begin
	saved_pc = `IM_START_ADDRESS;
end

always @(posedge clk) begin
	if (rst == 1'b1) begin
		saved_pc <= `IM_START_ADDRESS;
	end else begin
		if (enable == `PC_ENABLED) begin
			saved_pc <= next_pc;
		end
	end
end

assign curr_pc = saved_pc;

endmodule

