module switches(
	input clk, 
	input rst, 
	input [31:0] addr, 
	input [7:0] dip_switch7, 
	input [7:0] dip_switch6, 
	input [7:0] dip_switch5, 
	input [7:0] dip_switch4, 
	input [7:0] dip_switch3, 
	input [7:0] dip_switch2, 
	input [7:0] dip_switch1, 
	input [7:0] dip_switch0, 
	output [31:0] out
);

parameter BASE_ADDR = 32'h00007f2c;

wire [31:0] real_addr;

assign real_addr = $unsigned(addr) - $unsigned(BASE_ADDR);

reg [63:0] stored;

initial begin
	stored <= 0;
end

always @(posedge clk) begin
	if (rst == 1'b1) begin
		stored <= 0;
	end else begin
		stored <= ~{dip_switch7, dip_switch6, dip_switch5, dip_switch4, 
			dip_switch3, dip_switch2, dip_switch1, dip_switch0};
	end
end

assign out = 
	(real_addr = 32'd0) ? stored[31:0] : 
	(real_addr = 32'd4) ? stored[63:32] : 
	32'h0;

endmodule

