`include "mux.h"

module mux2(
	/* just one bit */
	input control, 
	input [BIT_WIDTH - 1:0] input0, 
	input [BIT_WIDTH - 1:0] input1, 
	output [BIT_WIDTH - 1:0] result
);

parameter BIT_WIDTH = 32;

assign result = 
	(control == 1'd0) ? input0 :
	(control == 1'd1) ? input1 : 
	input0;

endmodule

module mux3(
	input [1:0] control, 
	input [BIT_WIDTH - 1:0] input0, 
	input [BIT_WIDTH - 1:0] input1, 
	input [BIT_WIDTH - 1:0] input2, 
	output [BIT_WIDTH - 1:0] result
);

parameter BIT_WIDTH = 32;

assign result = 
	(control == 2'd0) ? input0 : 
	(control == 2'd1) ? input1 : 
	(control == 2'd2) ? input2 : 
	input0;

endmodule

module mux4(
	input [1:0] control, 
	input [BIT_WIDTH - 1:0] input0, 
	input [BIT_WIDTH - 1:0] input1, 
	input [BIT_WIDTH - 1:0] input2, 
	input [BIT_WIDTH - 1:0] input3, 
	output [BIT_WIDDTH - 1:0] result
);

parameter BIT_WIDTH = 32;

assign result = 
	(control == 2'd0) ? input0 :
	(control == 2'd1) ? input1 : 
	(control == 2'd2) ? input2 : 
	(control == 2'd3) ? input3 : 
	input0;

endmodule

module mux5(
	input [2:0] control, 
	input [BIT_WIDTH - 1:0] input0, 
	input [BIT_WIDTH - 1:0] input1, 
	input [BIT_WIDTH - 1:0] input2, 
	input [BIT_WIDTH - 1:0] input3, 
	input [BIT_WIDTH - 1:0] input4, 
	output [BIT_WIDTH - 1:0] result
)

parameter BIT_WIDTH = 32;

assign result = 
	(control == 3'd0) ? input0 : 
	(control == 3'd1) ? input1 : 
	(control == 3'd2) ? input2 : 
	(control == 3'd3) ? input3 : 
	(control == 3'd4) ? input4 : 
	input0;

endmodule

