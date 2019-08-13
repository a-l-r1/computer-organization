`include "cp0.h"

`define PART_NAME "cp0"

`include "debug/debug.h"

module cp0(
	input clk, 
	input rst, 
	input [4:0] addr, 
	input write_enable, 
	input [31:0] write_data, 
	input exit_isr, 
	input in_bds, 
	input [5:0] hwirq, 
	input [4:0] exc, 
	input [31:0] curr_pc, 
	output [31:0] read_result, 
	output [31:0] epc, 
	output have2handle
);

reg exl, g_allow_hwirq, in_bds_i;
reg [5:0] allow_hwirq, hwirq_i;
reg [4:0] exc_i;
reg [31:0] epc_i;

/* epc already declared */
wire [31:0] sr, cause, prid;

wire have_irq, have_exc;
wire write_valid;

assign sr = {16'b0, allow_hwirq, 8'b0, exl, g_allow_hwirq};
assign cause = {in_bds_i, 15'b0, hwirq_i, 3'b0, exc_i, 2'b0};
assign epc = epc_i;
assign prid = 32'h0000002a;

assign read_result = 
	(addr == 5'd12) ? sr : 
	(addr == 5'd13) ? cause : 
	(addr == 5'd14) ? epc : 
	(addr == 5'd15) ? prid : 
	32'b0;

assign have_irq = ((hwirq & allow_hwirq) != 0 && g_allow_hwirq == 1'b1 && exl == 1'b0);
assign have_exc = (exc != `EXC_NONE && exl == 1'b0);

assign have2handle = (have_irq || have_exc);

assign write_valid = ((write_enable == 1'b1) && (addr == 5'd12 || addr == 5'd13 || addr == 5'd14));

initial begin
	allow_hwirq <= 6'b111111;
	exl <= 1'b0;
	g_allow_hwirq <= 1'b1;
	in_bds_i <= 1'b1;
	hwirq_i <= 6'b0;
	exc_i <= 5'd0;
	epc_i <= 32'h0;
end

always @(posedge clk) begin
	if (have2handle == 1'b1) begin
		exl <= 1'b1;
		in_bds_i <= in_bds;
		epc_i <= (in_bds == 1'b1) ? $unsigned(curr_pc) - $unsigned(4) : $unsigned(curr_pc);
		if (have_irq == 1'b1) begin
			exc_i <= 0;
		end else begin
			if (have_exc == 1'b1) begin
				exc_i <= exc;
			end
		end
	end else begin
		if (write_valid == 1'b1) begin
			case (addr)
				5'd12: {allow_hwirq, exl, g_allow_hwirq} <= {write_data[15:10], write_data[1], write_data[0]};
				5'd13: {in_bds_i, hwirq_i, exc_i} <= {write_data[31], write_data[15:10], write_data[6:2]};
				5'd14: epc_i <= write_data;
				/* default omitted */
			endcase
		end else begin
			if (exit_isr == 1'b1) begin
				exl <= 1'b0;
			end
		end
	end

	if (~(write_valid == 1'b1 && addr == 5'd13)) begin
		hwirq_i <= hwirq;
	end
end

endmodule

