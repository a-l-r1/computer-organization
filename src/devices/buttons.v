module buttons(
	input clk, 
	input rst, 
	input [7:0] input_, 
	input [31:0] addr, 
	output [31:0] out
);

parameter BASE_ADDR = 0x7fff0100;

reg [7:0] stored;

initial begin
	stored <= 0;
end

always @(posedge clk) begin
	if (rst == 1'b1) begin
		stored <= 0;
	end else begin
		stored <= input;
	end
end

assign out = 
	(addr == BASE_ADDR) ? {24'b0, stored} : 
	32'b0;

endmodule

