`include "alu.h"
`include "cmp.h"

module cmp(
	input [31:0] reg1, 
	input [31:0] reg2, 
	output [1:0] cmp, 
	output [1:0] sig_cmp, 
	output [1:0] reg2_sig_cmp
);

assign cmp = 
	($unsigned(reg1) > $unsigned(reg2)) ? `CMP_LARGER : 
	($unsigned(reg1) < $unsigned(reg2)) ? `CMP_SMALLER : 
	`CMP_EQUAL;

assign sig_cmp = 
	($signed(reg1) > $signed(reg2)) ? `CMP_LARGER : 
	($signed(reg1) < $signed(reg2)) ? `CMP_SMALLER : 
	`CMP_EQUAL;

assign reg2_sig_cmp = 
	($signed(reg2) > $signed(0)) ? `CMP_LARGER : 
	($signed(reg2) < $signed(0)) ? `CMP_SMALLER : 
	`CMP_EQUAL;

endmodule

