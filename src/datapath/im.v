`include "im.h"
`include "npc.h"

`define PART_NAME "im"

module im(
	input [31:0] addr, 
	input enable, 
	output [31:0] result, 
	output valid
);

reg [31:0] memory [`IM_SIZE - 1:0];

integer i;

initial begin
	for (i = 0; i < `IM_SIZE; i = i + 1) begin
		memory[i] = 32'b0;
	end

	$readmemh(`IM_CODE_FILENAME, memory, 0);
	$readmemh(`IM_ISR_CODE_FILENAME, memory, ($unsigned(`IM_ISR_ADDRESS) - $unsigned(`IM_START_ADDRESS)) >> $unsigned(2), 2047);
end

wire [31:0] im_calculated_address;

assign valid = 
	($unsigned(addr) >= $unsigned(`IM_ADDR_LB)) && 
	($unsigned(addr) <= $unsigned(`IM_ADDR_UB)) && 
	(addr[1:0] == 2'b0);

/* Don't worry about underflows, it's taken care of by the first check in 
 * assign result */
assign im_calculated_address = $unsigned(addr) - $unsigned(`IM_START_ADDRESS);

assign result = 
	/* Remember the precedence! */
	(valid == 1'b0) ? 32'b0 : 
	(enable == `IM_ENABLE && $unsigned(addr) >= $unsigned(`IM_START_ADDRESS)) ? memory[im_calculated_address[`IM_ADDR_WIDTH - 1:2]] : 
	32'b0;

endmodule

