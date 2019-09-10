`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:18:33 09/09/2019 
// Design Name: 
// Module Name:    both_negedge 
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
module both_negedge(
    input clk,
    input rst
    );
	 
	 reg mem;
	 
	 initial begin
		mem = 1;
	end
	
	always @(*) begin
		mem <= 0;
	end

endmodule
