`include "pc.h"

module pc(
	input clk, 
	input [31:0] next_pc, 
	input enable, 
	output [31:0] curr_pc
)

reg [31:0] saved_pc;

initial begin
	saved_pc = 32'b0;
end

always @(posedge clk) begin
	if (enable == PC_ENABLED) begin
		saved_pc <= curr_pc;
	end
end

assign curr_pc = saved_pc;

endmodule

