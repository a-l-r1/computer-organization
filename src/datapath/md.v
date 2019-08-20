`include "md.h"

`define PART_NAME "md"

`include "debug/debug.h"

module md(
	input clk, 
	input rst, 
	input [31:0] dh, 
	input [31:0] dl, 
	input [3:0] op, 
	input stop, 
	input restore, 
	output busy, 
	output invalid, 
	output [31:0] hi, 
	output [31:0] lo
);

reg [31:0] dh_i, dl_i;
reg [3:0] op_i;
reg [31:0] hi_reg, lo_reg;
reg [31:0] old_hi, old_lo;
reg [3:0] ctr;
reg on_rst;

assign hi = hi_reg;
assign lo = lo_reg;
assign busy = ($unsigned(ctr) > $unsigned(0)) ? 1'b1 : 1'b0;
assign invalid = ((op_i == `MD_DIV || op_i == `MD_DIVU) && dl_i == 32'b0) ? 1'b1 : 1'b0;

initial begin
	dh_i <= 0;
	dl_i <= 0;
	op_i <= 0;
	hi_reg <= 0;
	lo_reg <= 0;
	old_hi <= 0;
	old_lo <= 0;
	ctr <= 0;
	on_rst <= 0;
end

always @(negedge clk) begin
	if (on_rst == 1'b1) begin
		on_rst <= 1'b0;
	end else begin

		if (!(op == `MD_NONE || stop == 1'b1 || restore == 1'b1)) begin
			if (op == `MD_MTHI) begin
				op_i <= op;
				hi_reg <= dh;
				old_hi <= hi_reg;
				old_lo <= lo_reg;
			end
			if (op == `MD_MTLO) begin
				op_i <= op;
				lo_reg <= dh;
				old_hi <= hi_reg;
				old_lo <= lo_reg;
			end
			if (op == `MD_MULT || op == `MD_MULTU) begin
				op_i <= op;
				ctr <= 4'd5;
				dh_i <= dh;
				dl_i <= dl;
			end
			if (op == `MD_DIV || op == `MD_DIVU) begin
				op_i <= op;
				ctr <= 4'd10;
				dh_i <= dh;
				dl_i <= dl;
			end
		end
	end
end

always @(posedge clk) begin
	if (rst == 1'b1) begin
		ctr <= 0;
		hi_reg <= 0;
		lo_reg <= 0;
		old_hi <= 0;
		old_lo <= 0;
		dh_i <= 0;
		dl_i <= 0;
		op_i <= 0;
		on_rst <= 1'b1;
	end else begin

		if (restore == 1'b0 && stop == 1'b0) begin
			if ($unsigned(ctr) > $unsigned(1)) begin
				ctr <= $unsigned(ctr) - $unsigned(1);
			/* ctr == 0 || ctr == 1 */
			end else begin
				if ($unsigned(ctr) == $unsigned(1)) begin
					ctr <= 0;
					{hi_reg, lo_reg} <= 
						(op_i == `MD_MULT) ? {{32{dh_i[31]}}, dh_i} * {{32{dl_i[31]}}, dl_i} : 
						(op_i == `MD_MULTU) ? (dh_i * dl_i) : 
						(op_i == `MD_DIV) ? (
							(dl_i != 32'b0) ? {$signed(dh_i) % $signed(dl_i), $signed(dh_i) / $signed(dl_i)} : 
							{hi_reg, lo_reg}
						) : 
						(op_i == `MD_DIVU) ? (
							(dl_i != 32'b0) ? {$unsigned(dh_i) % $unsigned(dl_i), $unsigned(dh_i) / $unsigned(dl_i)} : 
							{hi_reg, lo_reg}
						) : 
						{hi_reg, lo_reg};
					{old_hi, old_lo} <= {hi_reg, lo_reg};
				end
			end
		end
	end
end

endmodule

