`include "im.h"

`define PART_NAME "im"

`include "debug/debug.h"

module im(
	input [31:0] addr, 
	input enable, 
	output [31:0] result
);

reg [31:0] memory [`IM_SIZE - 1:0];

integer i;

initial begin
	for (i = 0; i < `IM_SIZE; i = i + 1) begin
		memory[i] = 32'b0;
	end

	$readmemh(`IM_CODE_FILENAME, memory, 0);
end

/* TODO: what if the address doesn't change? */

always @(addr) begin
	`debug_write(("enable = %0d, addr = 0x%08x, real_addr = 0x%08x, result = 0x%08x\n",
		enable, addr, ($unsigned(addr) - $unsigned(`IM_START_ADDRESS))[`IM_ADDR_WIDTH - 1:2], result));
end

assign result = 
	(enable == `IM_ENABLE && $unsigned(addr) < $unsigned(`IM_START_ADDRESS)) ? 32'b0 : 
	(enable == `IM_ENABLE && $unsigned(addr) >= $unsigned(`IM_START_ADDRESS)) ? memory[($unsigned(addr) - $unsigned(`IM_START_ADDRESS))[`IM_ADDR_WIDTH - 1:2]] : 
	32'b0;

endmodule

