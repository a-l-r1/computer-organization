`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:46:58 09/07/2019 
// Design Name: 
// Module Name:    pipeline 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module pipeline(
    input [31:0] A1,
    input [31:0] A2,
    input [31:0] B1,
    input [31:0] B2,
    input clk,
    output reg [31:0] C = 0
    );

reg [31:0] p1, p2;

initial begin
	p1 <= 0;
	p2 <= 0;
end

always @(posedge clk) begin
	p1 <= $unsigned(A1) * $unsigned(B1);
	p2 <= $unsigned(A2) * $unsigned(B2);
	C <= $unsigned(p1) + $unsigned(p2);
end

endmodule
