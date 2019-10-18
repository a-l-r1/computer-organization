`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:19:03 10/17/2019 
// Design Name: 
// Module Name:    gray 
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
module gray(
	input Clk, 
	input Reset, 
	input En, 
	output [2:0] Output, 
	output Overflow
    );

reg [2:0] ctr;
reg Overflow;

initial begin
	ctr <= 0;
	Overflow <= 0;
end

always @(posedge Clk) begin
	if (Reset == 1'b1) begin
		ctr <= 0;
		Overflow <= 0;
	end else begin
		if (En == 1'b1) begin
			ctr <= $unsigned(ctr) + $unsigned(1);
		end
		if (ctr == 3'd7) begin
			Overflow <= 1'b1;
		end
	end
end

assign Output = 
	(ctr == 3'd0) ? 3'b000 : 
	(ctr == 3'd1) ? 3'b001 : 
	(ctr == 3'd2) ? 3'b011 : 
	(ctr == 3'd3) ? 3'b010 : 
	(ctr == 3'd4) ? 3'b110 : 
	(ctr == 3'd5) ? 3'b111 : 
	(ctr == 3'd6) ? 3'b101 : 
	(ctr == 3'd7) ? 3'b100 : 
	3'b000;

endmodule
