`include "alu.h"

`define PART_NAME "alu"

`include "debug/debug.h"

module alu(
	input [31:0] num1, 
	input [31:0] num2, 
	input [4:0] shamt, 
	input [4:0] op, 
	output [31:0] result, 
	output [1:0] cmp_result, 
	output [1:0] sig_cmp_result, 
	output overflow, 
	output sig_overflow, 
	output op_invalid
);

wire [6:0] actual_shamt;
wire [31:0] sll_result, srl_result, sra_result;

assign actual_shamt = 
	(op == `ALU_SLL || op == `ALU_SRL || op == `ALU_SRA) ? shamt : 
	(op == `ALU_SLLV || op == `ALU_SRLV || op == `ALU_SRAV) ? num1[4:0] : 
	5'b0;

assign sll_result = 
	(actual_shamt == 0) ? {num2[31:0], {0{1'b0}}} :
	(actual_shamt == 1) ? {num2[30:0], {1{1'b0}}} :
	(actual_shamt == 2) ? {num2[29:0], {2{1'b0}}} :
	(actual_shamt == 3) ? {num2[28:0], {3{1'b0}}} :
	(actual_shamt == 4) ? {num2[27:0], {4{1'b0}}} :
	(actual_shamt == 5) ? {num2[26:0], {5{1'b0}}} :
	(actual_shamt == 6) ? {num2[25:0], {6{1'b0}}} :
	(actual_shamt == 7) ? {num2[24:0], {7{1'b0}}} :
	(actual_shamt == 8) ? {num2[23:0], {8{1'b0}}} :
	(actual_shamt == 9) ? {num2[22:0], {9{1'b0}}} :
	(actual_shamt == 10) ? {num2[21:0], {10{1'b0}}} :
	(actual_shamt == 11) ? {num2[20:0], {11{1'b0}}} :
	(actual_shamt == 12) ? {num2[19:0], {12{1'b0}}} :
	(actual_shamt == 13) ? {num2[18:0], {13{1'b0}}} :
	(actual_shamt == 14) ? {num2[17:0], {14{1'b0}}} :
	(actual_shamt == 15) ? {num2[16:0], {15{1'b0}}} :
	(actual_shamt == 16) ? {num2[15:0], {16{1'b0}}} :
	(actual_shamt == 17) ? {num2[14:0], {17{1'b0}}} :
	(actual_shamt == 18) ? {num2[13:0], {18{1'b0}}} :
	(actual_shamt == 19) ? {num2[12:0], {19{1'b0}}} :
	(actual_shamt == 20) ? {num2[11:0], {20{1'b0}}} :
	(actual_shamt == 21) ? {num2[10:0], {21{1'b0}}} :
	(actual_shamt == 22) ? {num2[9:0], {22{1'b0}}} :
	(actual_shamt == 23) ? {num2[8:0], {23{1'b0}}} :
	(actual_shamt == 24) ? {num2[7:0], {24{1'b0}}} :
	(actual_shamt == 25) ? {num2[6:0], {25{1'b0}}} :
	(actual_shamt == 26) ? {num2[5:0], {26{1'b0}}} :
	(actual_shamt == 27) ? {num2[4:0], {27{1'b0}}} :
	(actual_shamt == 28) ? {num2[3:0], {28{1'b0}}} :
	(actual_shamt == 29) ? {num2[2:0], {29{1'b0}}} :
	(actual_shamt == 30) ? {num2[1:0], {30{1'b0}}} :
	(actual_shamt == 31) ? {num2[0:0], {31{1'b0}}} :
	num2;

assign srl_result = 
	(actual_shamt == 0) ? {{0{1'b0}}, num2[31:0]} :
	(actual_shamt == 1) ? {{1{1'b0}}, num2[31:1]} :
	(actual_shamt == 2) ? {{2{1'b0}}, num2[31:2]} :
	(actual_shamt == 3) ? {{3{1'b0}}, num2[31:3]} :
	(actual_shamt == 4) ? {{4{1'b0}}, num2[31:4]} :
	(actual_shamt == 5) ? {{5{1'b0}}, num2[31:5]} :
	(actual_shamt == 6) ? {{6{1'b0}}, num2[31:6]} :
	(actual_shamt == 7) ? {{7{1'b0}}, num2[31:7]} :
	(actual_shamt == 8) ? {{8{1'b0}}, num2[31:8]} :
	(actual_shamt == 9) ? {{9{1'b0}}, num2[31:9]} :
	(actual_shamt == 10) ? {{10{1'b0}}, num2[31:10]} :
	(actual_shamt == 11) ? {{11{1'b0}}, num2[31:11]} :
	(actual_shamt == 12) ? {{12{1'b0}}, num2[31:12]} :
	(actual_shamt == 13) ? {{13{1'b0}}, num2[31:13]} :
	(actual_shamt == 14) ? {{14{1'b0}}, num2[31:14]} :
	(actual_shamt == 15) ? {{15{1'b0}}, num2[31:15]} :
	(actual_shamt == 16) ? {{16{1'b0}}, num2[31:16]} :
	(actual_shamt == 17) ? {{17{1'b0}}, num2[31:17]} :
	(actual_shamt == 18) ? {{18{1'b0}}, num2[31:18]} :
	(actual_shamt == 19) ? {{19{1'b0}}, num2[31:19]} :
	(actual_shamt == 20) ? {{20{1'b0}}, num2[31:20]} :
	(actual_shamt == 21) ? {{21{1'b0}}, num2[31:21]} :
	(actual_shamt == 22) ? {{22{1'b0}}, num2[31:22]} :
	(actual_shamt == 23) ? {{23{1'b0}}, num2[31:23]} :
	(actual_shamt == 24) ? {{24{1'b0}}, num2[31:24]} :
	(actual_shamt == 25) ? {{25{1'b0}}, num2[31:25]} :
	(actual_shamt == 26) ? {{26{1'b0}}, num2[31:26]} :
	(actual_shamt == 27) ? {{27{1'b0}}, num2[31:27]} :
	(actual_shamt == 28) ? {{28{1'b0}}, num2[31:28]} :
	(actual_shamt == 29) ? {{29{1'b0}}, num2[31:29]} :
	(actual_shamt == 30) ? {{30{1'b0}}, num2[31:30]} :
	(actual_shamt == 31) ? {{31{1'b0}}, num2[31:31]} :
	num2;

assign sra_result = 
	(actual_shamt == 0) ? {{0{num2[31]}}, num2[31:0]} :
	(actual_shamt == 1) ? {{1{num2[31]}}, num2[31:1]} :
	(actual_shamt == 2) ? {{2{num2[31]}}, num2[31:2]} :
	(actual_shamt == 3) ? {{3{num2[31]}}, num2[31:3]} :
	(actual_shamt == 4) ? {{4{num2[31]}}, num2[31:4]} :
	(actual_shamt == 5) ? {{5{num2[31]}}, num2[31:5]} :
	(actual_shamt == 6) ? {{6{num2[31]}}, num2[31:6]} :
	(actual_shamt == 7) ? {{7{num2[31]}}, num2[31:7]} :
	(actual_shamt == 8) ? {{8{num2[31]}}, num2[31:8]} :
	(actual_shamt == 9) ? {{9{num2[31]}}, num2[31:9]} :
	(actual_shamt == 10) ? {{10{num2[31]}}, num2[31:10]} :
	(actual_shamt == 11) ? {{11{num2[31]}}, num2[31:11]} :
	(actual_shamt == 12) ? {{12{num2[31]}}, num2[31:12]} :
	(actual_shamt == 13) ? {{13{num2[31]}}, num2[31:13]} :
	(actual_shamt == 14) ? {{14{num2[31]}}, num2[31:14]} :
	(actual_shamt == 15) ? {{15{num2[31]}}, num2[31:15]} :
	(actual_shamt == 16) ? {{16{num2[31]}}, num2[31:16]} :
	(actual_shamt == 17) ? {{17{num2[31]}}, num2[31:17]} :
	(actual_shamt == 18) ? {{18{num2[31]}}, num2[31:18]} :
	(actual_shamt == 19) ? {{19{num2[31]}}, num2[31:19]} :
	(actual_shamt == 20) ? {{20{num2[31]}}, num2[31:20]} :
	(actual_shamt == 21) ? {{21{num2[31]}}, num2[31:21]} :
	(actual_shamt == 22) ? {{22{num2[31]}}, num2[31:22]} :
	(actual_shamt == 23) ? {{23{num2[31]}}, num2[31:23]} :
	(actual_shamt == 24) ? {{24{num2[31]}}, num2[31:24]} :
	(actual_shamt == 25) ? {{25{num2[31]}}, num2[31:25]} :
	(actual_shamt == 26) ? {{26{num2[31]}}, num2[31:26]} :
	(actual_shamt == 27) ? {{27{num2[31]}}, num2[31:27]} :
	(actual_shamt == 28) ? {{28{num2[31]}}, num2[31:28]} :
	(actual_shamt == 29) ? {{29{num2[31]}}, num2[31:29]} :
	(actual_shamt == 30) ? {{30{num2[31]}}, num2[31:30]} :
	(actual_shamt == 31) ? {{31{num2[31]}}, num2[31:31]} :
	num2;

assign {op_invalid, result} = 
	(op == `ALU_ADD) ? {1'b0, $unsigned(num1) + $unsigned(num2)} : 
	(op == `ALU_SUB) ? {1'b0, $unsigned(num1) - $unsigned(num2)} : 
	(op == `ALU_AND) ? {1'b0, $unsigned(num1) & $unsigned(num2)} : 
	(op == `ALU_OR) ? {1'b0, $unsigned(num1) | $unsigned(num2)} : 
	(op == `ALU_NOT) ? {1'b0, ~$unsigned(num1)} : 
	(op == `ALU_XOR) ? {1'b0, $unsigned(num1) ^ $unsigned(num2)} : 
	(op == `ALU_MOVZ) ? {1'b0, $unsigned(num1)} : 
	(op == `ALU_NOR) ? {1'b0, ~($unsigned(num1) | $unsigned(num2))} : 
	(op == `ALU_SLT) ? {1'b0, (
		$signed(num1) < $signed(num2) ? 32'b1 : 32'b0
	)} : 
	(op == `ALU_SLTU) ? {1'b0, (
		$unsigned(num1) < $unsigned(num2) ? 32'b1 : 32'b0
	)} : 
	(op == `ALU_SLL || op == `ALU_SLLV) ? {1'b0, sll_result} : 
	(op == `ALU_SRL || op == `ALU_SRLV) ? {1'b0, srl_result} :  
	(op == `ALU_SRA || op == `ALU_SRAV) ? {1'b0, sra_result} : 
	{1'b1, 32'b0};

wire [32:0] intermediate_result, sig_intermediate_result;

/* TODO: is this correct? */
assign intermediate_result = 
	(op == `ALU_ADD) ? $unsigned(num1) + $unsigned(num2) : 
	(op == `ALU_SUB) ? $unsigned(num1) - $unsigned(num2) : 
	33'b0;

assign overflow = intermediate_result[32];

assign sig_intermediate_result = 
	(op == `ALU_ADD) ? $signed({num1[31], num1}) + $signed({num2[31], num2}) : 
	(op == `ALU_SUB) ? $signed({num1[31], num1}) - $signed({num2[31], num2}) : 
	33'b0;

/* Mind the difference in bit lengths */
assign sig_overflow = (sig_intermediate_result[32] != result[31]);

assign cmp_result = 
	($unsigned(num1) == $unsigned(num2)) ? `ALU_EQUAL : 
	($unsigned(num1) < $unsigned(num2)) ? `ALU_SMALLER : 
	`ALU_LARGER;

assign sig_cmp_result = 
	($signed(num1) == $signed(num2)) ? `ALU_EQUAL : 
	($signed(num1) < $signed(num2)) ? `ALU_SMALLER : 
	`ALU_LARGER;

endmodule

