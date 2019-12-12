module switches(
	input clk, 
	input rst, 
	input addr, 
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
	(addr = 1'b0) ? stored[31:0] : 
	(addr = 1'b1) ? stored[63:32] : 
	32'b0;

endmodule

