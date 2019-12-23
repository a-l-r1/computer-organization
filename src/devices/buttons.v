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
reg irq_reg;

initial begin
	stored <= 0;
	irq_reg <= 0;
end

always @(posedge clk) begin
	if (rst == 1'b1) begin
		stored <= 0;
		irq_reg <= 0;
	end else begin
		stored <= ~user_key;

		/* Some of the switches has just been raised. */
		if ((&user_key) == 1'b0 && stored != ~user_key) begin
			irq_reg <= 1'b1;
		end

		/* Keep irq on for only one cycle. */
		if (irq_reg == 1'b1) begin
			irq_reg <= 1'b0;
		end
	end
end

assign read_result = {24'b0, stored};
assign irq = irq_reg;

endmodule

