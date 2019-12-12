module led(
	input clk, 
	input rst, 
	input we, 
	input [31:0] wd, 
	input [31:0] addr, 
	output [31:0] led_light
);

reg [31:0] stored;

initial begin
	stored <= 0;
end

always @(posedge clk) begin
	if (rst == 1'b1) begin
		stored <= 0;
	end else begin
		if (we == 1'b1 && addr == `BASE_ADDR) begin
			stored <= wd;
		end
	end
end

assign led_light = ~stored;

endmodule

