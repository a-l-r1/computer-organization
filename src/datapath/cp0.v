`include "cp0.h"

`define PART_NAME "cp0"

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

`define g_allow_hwirq sr[0]
`define exl sr[1]
`define allow_hwirq sr[15:10]

`define exc_i cause[6:2]
`define hwirq_i cause[15:10]
`define in_bds_i cause[31]

`define sr sr
`define cause cause
`define epc_i epc_i

/* epc already declared */
reg [31:0] sr, cause, epc_i;
wire [31:0] prid;

wire have_irq, have_exc;
wire write_valid;

assign epc = epc_i;
assign prid = `CP0_PRID;

assign read_result = 
	(addr == 5'd12) ? sr : 
	(addr == 5'd13) ? cause : 
	(addr == 5'd14) ? epc : 
	(addr == 5'd15) ? prid : 
	32'b0;

assign have_irq = ((hwirq & `allow_hwirq) != 0 && `g_allow_hwirq == 1'b1 && `exl == 1'b0);
assign have_exc = (exc != `EXC_NONE);

assign have2handle = (have_irq || have_exc);

assign write_valid = ((write_enable == 1'b1) && (addr == 5'd12 || addr == 5'd13 || addr == 5'd14));

initial begin
`ifdef MARS_COMPAT
	sr <= 32'h0000ff11;
	cause <= 0;
	epc_i <= 0;
`else /* MARS_COMPAT */
	sr <= 0;
	cause <= 0;
	epc_i <= 0;
`endif /* MARS_COMPAT */
end

always @(posedge clk) begin
	if (have2handle == 1'b1) begin
		`exl <= 1'b1;
		`in_bds_i <= in_bds;
		`epc_i <= (in_bds == 1'b1) ? $unsigned(curr_pc) - $unsigned(4) : 
			$unsigned(curr_pc);

		if (have_irq == 1'b1) begin
			`exc_i <= `EXC_INT;
		end else begin
			if (have_exc == 1'b1) begin
				`exc_i <= exc;
			end
		end
`ifdef MARS_COMPAT
		cause[9:8] <= 2'b0;
`endif /* MARS_COMPAT */

	end else begin
		if (write_valid == 1'b1) begin
			case (addr)
`ifdef MARS_COMPAT
				5'd12: sr <= write_data;
				5'd13: cause <= write_data;
				5'd14: epc_i <= write_data;
`else /* MARS_COMPAT */
				5'd12: {`allow_hwirq, `exl, `g_allow_hwirq} <= {write_data[15:10], write_data[1], write_data[0]};
				/* NOTE: for compliance with cscore */
				/* 5'd13: {`in_bds_i, `hwirq_i, `exc_i} <= {write_data[31], write_data[15:10], write_data[6:2]}; */
				5'd14: epc_i <= write_data;
`endif /* MARS_COMPAT */
				/* default omitted */
			endcase
		end else begin
			if (exit_isr == 1'b1) begin
				`exl <= 1'b0;
			end
		end
	end

	/* MARS doesn't even update it's hardware IRQ related bits */
`ifndef MARS_COMPAT
	if (~(have2handle == 1'b0 && write_valid == 1'b1 && addr == 5'd13)) begin
		`hwirq_i <= hwirq;
	end
`endif /* MARS_COMPAT */
end

endmodule

