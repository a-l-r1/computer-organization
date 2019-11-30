`include "md.h"

`define PART_NAME "md"

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
	output [31:0] lo, 
	output [31:0] out
);

wire op_cal;

reg [31:0] dh_i, dl_i;
reg [3:0] op_i;
reg [31:0] hi_reg, lo_reg;
reg [31:0] hi_reg_old, lo_reg_old;
reg [3:0] ctr;

assign hi = hi_reg;
assign lo = lo_reg;
assign op_cal = (op == `MD_MULT || op == `MD_MULTU || op == `MD_DIV ||op == `MD_DIVU);
assign busy = (op_cal == 1'b1 || $unsigned(ctr) > $unsigned(0));
assign invalid = ((op_i == `MD_DIV || op_i == `MD_DIVU) && dl_i == 32'b0) ? 1'b1 : 1'b0;
assign out = 
	(op == `MD_MFHI) ? hi_reg : 
	(op == `MD_MFLO) ? lo_reg : 
	32'b0;

initial begin
	dh_i <= 0;
	dl_i <= 0;
	op_i <= 0;
	hi_reg <= 0;
	lo_reg <= 0;
	hi_reg_old <= 0;
	lo_reg_old <= 0;
	ctr <= 0;
end

always @(posedge clk) begin
	if (rst == 1'b1) begin
		dh_i <= 0;
		dl_i <= 0;
		op_i <= 0;
		hi_reg <= 0;
		lo_reg <= 0;
		hi_reg_old <= 0;
		lo_reg_old <= 0;
		ctr <= 0;
	end else begin
		/* NOTE: stop also bars writes to hi_reg and lo_reg */
		if (stop == 1'b1) begin
			ctr <= 0;
			op_i <= `MD_NONE;
		end

		if (restore == 1'b1) begin
			hi_reg <= hi_reg_old;
			lo_reg <= lo_reg_old;
		end
	end

	if (rst == 1'b0 && stop == 1'b0 && restore == 1'b0) begin
		if (op_cal == 1'b1) begin
			dh_i <= dh;
			dl_i <= dl;
			op_i <= op;
			ctr <= 
				(op == `MD_MULT || op == `MD_MULTU) ? 5 : 
				(op == `MD_DIV || op == `MD_DIVU) ? 10 :
				0;
		end

		if (op == `MD_MTHI) begin
			hi_reg <= dh;
			{hi_reg_old, lo_reg_old} <= {hi_reg, lo_reg};
		end

		if (op == `MD_MTLO) begin
			lo_reg <= dh;
			{hi_reg_old, lo_reg_old} <= {hi_reg, lo_reg};
		end 

		if (op == `MD_NONE) begin
			if ($unsigned(ctr) >= $unsigned(1)) begin
				ctr <= $unsigned(ctr) - $unsigned(1);
			end else begin
				if ($unsigned(ctr) == $unsigned(0)) begin
					{hi_reg, lo_reg} <= 
						(op_i == `MD_MULT) ? {{32{dh_i[31]}}, dh_i} * {{32{dl_i[31]}}, dl_i} : 
						(op_i == `MD_MULTU) ? (dh_i * dl_i) : 
						(op_i == `MD_DIV) ? (
							(dl_i != 32'b0) ? {$signed(dh_i) % $signed(dl_i), $signed(dh_i) / $signed(dl_i)} : 
							/* for compatibility with MARS */
							{hi_reg, lo_reg}
						) : 
						(op_i == `MD_DIVU) ? (
							(dl_i != 32'b0) ? {$unsigned(dh_i) % $unsigned(dl_i), $unsigned(dh_i) / $unsigned(dl_i)} : 
						        /* for compatibility with MARS */	
							{hi_reg, lo_reg}
						) : 
						{hi_reg, lo_reg};
					op_i <= `MD_NONE;
				end
			end
		end
	end
end

endmodule

