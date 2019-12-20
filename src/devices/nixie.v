`include "nixie.h"

module nixie(
	input clk, 
	input rst, 

	input addr, 
	input write_enable, 
	input [31:0] write_data, 
	output [31:0] read_result, 
	output irq, 

	output [7:0] digital_tube0, 
	output [7:0] digital_tube1, 
	output [7:0] digital_tube2, 
	output [3:0] digital_tube_sel0, 
	output [3:0] digital_tube_sel1, 
	output digital_tube_sel2
);

reg [31:0] ctr;
reg [3:0] phase;

reg [7:0] tube2;
reg [15:0] tube1, tube0;

wire [3:0] data0, data1, data2;

initial begin
	ctr <= `NIXIE_CTR;
	phase <= 4'b1000;
	tube0 <= 0;
	tube1 <= 0;
	tube2 <= 0;
end

nixie_decoder decoder0(
	.data(data0), 
	.out(digital_tube0)
);

nixie_decoder decoder1(
	.data(data1), 
	.out(digital_tube1)
);

nixie_decoder decoder2(
	.data(data2), 
	.out(digital_tube2)
);

always @(posedge clk) begin
	if (rst == 1'b1) begin
		ctr <= 0;
		phase <= 4'b1000;
		tube0 <= 0;
		tube1 <= 0;
		tube2 <= 0;
	end else begin

		if (write_enable == 1'b1) begin
			case (addr)
				1'b0: {tube1, tube0} <= write_data;
				1'b1: tube2 <= write_data[7:0];
				default: begin
				end
			endcase

		end else begin
			if ($unsigned(ctr) > $unsigned(0)) begin
				ctr <= $unsigned(ctr) - $unsigned(1);
			end else begin
				ctr <= `NIXIE_CTR;
				case (phase)
					4'b1000: phase <= 4'b0100;
					4'b0100: phase <= 4'b0010;
					4'b0010: phase <= 4'b0001;
					4'b0001: phase <= 4'b1000;
					default: phase <= 4'b1000;
				endcase
			end
		end
	end
end

assign digital_tube_sel0 = phase;
assign digital_tube_sel1 = phase;
assign digital_tube_sel2 = 1'b1;

assign data0 = 
	(phase == 4'b1000) ? tube0[15:12] : 
	(phase == 4'b0100) ? tube0[11:8] : 
	(phase == 4'b0010) ? tube0[7:4] : 
	tube0[3:0];

assign data1 = 
	(phase == 4'b1000) ? tube1[15:12] : 
	(phase == 4'b0100) ? tube1[11:8] : 
	(phase == 4'b0010) ? tube1[7:4] : 
	tube1[3:0];

assign data2 = tube2[3:0];

assign read_result = 
	(addr == 1'b0) ? {tube1, tube0} : 
	(addr == 1'b1) ? {24'b0, tube2} : 
	32'b0;

assign irq = 1'b0;

endmodule

