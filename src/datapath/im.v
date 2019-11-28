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
	$readmemh(`IM_ISR_CODE_FILENAME, memory, ($unsigned(`IM_ISR_START_ADDRESS) - $unsigned(`IM_START_ADDRESS)) >> $unsigned(2), 2047);
end

wire [31:0] im_calculated_address;

/* Don't worry about underflows, it's taken care of by the first check in 
 * assign result */
assign im_calculated_address = $unsigned(addr) - $unsigned(`IM_START_ADDRESS);

assign result = 
	(enable == `IM_ENABLE && $unsigned(addr) < $unsigned(`IM_START_ADDRESS)) ? 32'b0 : 
	(enable == `IM_ENABLE && $unsigned(addr) >= $unsigned(`IM_START_ADDRESS)) ? memory[im_calculated_address[`IM_ADDR_WIDTH - 1:2]] : 
	32'b0;

endmodule

