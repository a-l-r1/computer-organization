module led(
	input clk, 
	input rst, 
	input write_enable, 
	input [31:0] write_data, 
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
		if (write_enable == 1'b1) begin
			stored <= wd;
		end
	end
end

assign led_light = ~stored;

endmodule
