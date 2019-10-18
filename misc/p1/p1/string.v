`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:25:17 10/17/2019 
// Design Name: 
// Module Name:    string 
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
module string(
	input clk, 
	input clr, 
	input [7:0] in, 
	output out
    );

`define INIT 0
`define GOOD 1
`define WAITNUM 2
`define BAD 3

reg [3:0] state;

initial begin
	state <= 0;
end

always @(posedge clk or posedge clr) begin
	if (clr == 1'b1) begin
		state <= 0;
	end else begin
		case (state)
			`INIT: state <= 
				(in == 43 || in == 42) ? `BAD : /* + * */
				(in >= 48 && in <= 57) ? `GOOD : /* [0-9] */
				`BAD; /* others */
			
			`GOOD: state <= 
				(in == 43 || in == 42) ? `WAITNUM : /* + * */
				(in >= 48 && in <= 57) ? `BAD : /* [0-9] */
				`BAD; /* others */
			
			`WAITNUM: state <= 
				(in == 43 || in == 42) ? `BAD : /* + * */
				(in >= 48 && in <= 57) ? `GOOD : /* [0-9] */
				`BAD; /* others */
			
			`BAD: state <= `BAD;
			default: state <= `INIT;
		endcase
	end
end

assign out = (state == `GOOD);

endmodule
