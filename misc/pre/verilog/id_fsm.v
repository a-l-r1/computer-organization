`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:16:07 09/08/2019 
// Design Name: 
// Module Name:    id_fsm 
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
module id_fsm(
    input [7:0] char,
    input clk,
    output out
    );

wire [1:0] input_;
assign input_ = 
	($unsigned(char) >= 48 && $unsigned(char) <= 57) ? 2'b00 : 
	(($unsigned(char) >= 65 && $unsigned(char) <= 90) || ($unsigned(char) >= 97 && $unsigned(char) <= 122)) ? 2'b01 : 
	2'b10;

reg [1:0] state;

initial begin
	state <= 0;
end

always @(posedge clk) begin
	case (state)
		2'b00: begin
			if (input_ == 2'b01) state <= 2'b01;
			else state <= 2'b00;
		end
		2'b01: begin
			if (input_ == 2'b00) state <= 2'b10;
			if (input_ == 2'b01) state <= 2'b01;
			if (input_ == 2'b10) state <= 2'b00;
		end
		2'b10: begin
			if (input_ == 2'b00) state <= 2'b10;
			if (input_ == 2'b01) state <= 2'b01;
			if (input_ == 2'b10) state <= 2'b00;
		end
		default: state <= 2'b00;
	endcase
end

assign out = (state == 2'b10);

endmodule
