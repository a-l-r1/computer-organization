`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:52:15 09/07/2019 
// Design Name: 
// Module Name:    counter 
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
module code(
    input Clk,
    input Reset,
    input Slt, 
    input En,
    output reg [63:0] Output0,
    output reg [63:0] Output1
    );

reg [1:0] Output1_Valid;

initial begin
	Output0 <= 0;
	Output1 <= 0;
	Output1_Valid <= 0;
end

always @(posedge Clk) begin
	if (Reset == 1'b1) begin
		Output0 <= 0;
		Output1 <= 0;
		Output1_Valid <= 0;
	end else begin
		if (En == 1'b1) begin
			if (Slt == 1'b0) begin
				Output0 <= $unsigned(Output0) + $unsigned(1);
			end
			if (Slt == 1'b1) begin
				if ($unsigned(Output1_Valid) <= $unsigned(2)) begin
					Output1_Valid <= $unsigned(Output1_Valid) + $unsigned(1);
				end else begin
					Output1_Valid <= 0;
					Output1 <= $unsigned(Output1) + $unsigned(1);
				end
			end
		end
	end	
end

endmodule
