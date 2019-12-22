module buttons(
	input clk, 
	input rst, 

	input [31:0] addr, 
	input write_enable, 
	input [31:0] write_data, 
	output [31:0] read_result, 
	output irq, 

	input [7:0] user_key
);

reg [7:0] stored;

initial begin
	stored <= 0;
end

always @(posedge clk) begin
	if (rst == 1'b1) begin
		stored <= 0;
	end else begin
		stored <= ~user_key;
	end
end

assign read_result = {24'b0, stored};
assign irq = ~(&user_key);

endmodule

