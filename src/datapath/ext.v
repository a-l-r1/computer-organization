`include "ext.h"

module ext(
	input [15:0] num,
	input [2:0] mode,
	output [31:0] result
);

assign result = 
	(mode == EXT_MODE_SIGNED) ? {16{num[14]}, num} : 
	(mode == EXT_MODE_UNSIGNED) ? {16'b0, num} : 
	(mode == EXT_MODE_PAD) ? {num, 16'b0} : 
	(mode == EXT_MODE_ONE) ? {16'b1, num} : 
	32'b0;

endmodule
