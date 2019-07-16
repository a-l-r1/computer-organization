`include "im.h"

module im(
	input [IM_ADDR_WIDTH - 1:0] addr, 
	input enable, 
	output [31:0] result
)

reg [IM_SIZE - 1:0] memory [31:0];

/* TODO: load machine code */

assign result = 
	(enable == IM_ENABLE) ? memory[addr[IM_ADDR_WIDTH - 1:1]] : 
	32'b0;

endmodule

