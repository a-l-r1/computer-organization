module buttons(
	input clk, 
	input rst, 
	input [7:0] input_, 
	input [31:0] addr, 
	output [31:0] out
);

reg [7:0] stored;

initial begin
	stored <= 0;
end

always @(posedge clk) begin
	if (rst == 1'b1) begin
		stored <= 0;
	end else begin
		stored <= ~input_;
	end
end

assign out = {24'b0, stored};

endmodule

