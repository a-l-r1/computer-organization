`include "im.h"
`include "pc.h"
`include "npc.h"

module im(
	input clk, 
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

	/* NOTE: Assume initial PC to be directly mapped. Have to use bitmask
	 * since ISE is really capable to seemingly dismiss all other sensible
	 * solutions. */
	$readmemh(`IM_CODE_FILENAME, memory, ($unsigned(`PC_START_ADDRESS) - $unsigned(`IM_ADDR_LB) >> $unsigned(2)) & 32'h0000ffff);
	$readmemh(`IM_ISR_CODE_FILENAME, memory, ($unsigned(`IM_ISR_ADDRESS) - $unsigned(`IM_ADDR_LB)) >> $unsigned(2), 4095);
end

wire [31:0] im_calculated_address;
wire [31:0] im_ipcore_result;

assign valid = 
	($unsigned(addr) >= $unsigned(`IM_ADDR_LB)) && 
	($unsigned(addr) <= $unsigned(`IM_ADDR_UB)) && 
	(addr[1:0] == 2'b0);

assign im_calculated_address = 
	(valid == 1'b1) ? $unsigned(addr) - $unsigned(`IM_ADDR_LB) : 
	32'b0;

/*
im_ipcore im_ipcore(
	.clka(clk), 
	.wea(4'b0), 
	.addra(im_calculated_address[14:2]), 
	.dina(32'b0), 
	.douta(im_ipcore_result)
);
*/

assign result = 
	/* Remember the precedence! */
	(valid == 1'b0) ? 32'b0 : 
	memory[im_calculated_address[`IM_ADDR_WIDTH:2]];

endmodule

