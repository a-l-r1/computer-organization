`include "cp0.h"

`include "mmu.h"

module cp0(
	input clk, 
	input rst, 

	input [3:0] op, 
	input [4:0] addr, 
	input [31:0] write_data, 
	output [31:0] read_result, 

	input in_bds, 
	input [5:0] hwirq, 
	input [4:0] exc, 
	input [31:0] curr_pc, 
	output [31:0] epc, 
	output have2handle, 

	input [31:0] mmu_entryhi, 
	input [31:0] mmu_entrylo0, 
	input [31:0] mmu_entrylo1, 
	output [`TLB_ADDR_WIDTH - 1:0] cp0_tlb_index, 
	output [31:0] cp0_entryhi, 
	output [31:0] cp0_entrylo0, 
	output [31:0] cp0_entrylo1, 

	input mmu_hit_cp0, 
	input [`TLB_ADDR_WIDTH - 1:0] mmu_hit_cp0_index
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
reg [31:0] entryhi, entrylo0, entrylo1, index;
wire [31:0] prid;

wire have_irq, have_exc;
wire write_valid;

assign epc = epc_i;
assign prid = `CP0_PRID;

assign read_result = 
	(addr == 5'd0) ? index : 
	(addr == 5'd2) ? entrylo0 : 
	(addr == 5'd3) ? entrylo1 : 
	(addr == 5'd10) ? entryhi : 
	(addr == 5'd12) ? sr : 
	(addr == 5'd13) ? cause : 
	(addr == 5'd14) ? epc : 
	(addr == 5'd15) ? prid : 
	32'b0;

assign cp0_entryhi = entryhi;
assign cp0_entrylo0 = entrylo0;
assign cp0_entrylo1 = entrylo1;
assign cp0_tlb_index = index[`TLB_ADDR_WIDTH - 1:0];

assign have_irq = ((hwirq & `allow_hwirq) != 0 && `g_allow_hwirq == 1'b1 && `exl == 1'b0);
assign have_exc = ((exc != `EXC_NONE) && (`exl == 1'b0));

assign have2handle = (have_irq || have_exc);

assign write_valid = ((op == `CP0_MTC0) && (addr == 5'd12 || addr == 5'd13 || addr == 5'd14));

initial begin
`ifdef MARS_COMPAT
	sr <= 32'h0000ff11;
	cause <= 0;
	epc_i <= 0;
	entryhi <= 0;
	entrylo0 <= 0;
	entrylo1 <= 0;
	index <= 0;
`else /* MARS_COMPAT */
	sr <= 0;
	cause <= 0;
	epc_i <= 0;
	entryhi <= 0;
	entrylo0 <= 0;
	entrylo1 <= 0;
	index <= 0;
`endif /* MARS_COMPAT */
end

always @(posedge clk) begin
	if (rst == 1'b1) begin
`ifdef MARS_COMPAT
		sr <= 32'h0000ff11;
		cause <= 0;
		epc_i <= 0;
		entryhi <= 0;
		entrylo0 <= 0;
		entrylo1 <= 0;
		index <= 0;
`else
		sr <= 0;
		cause <= 0;
		epc_i <= 0;
		entryhi <= 0;
		entrylo0 <= 0;
		entrylo1 <= 0;
		index <= 0;
`endif
	end else begin

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

			case (op)
				`CP0_MTC0: begin
					case (addr)
`ifdef MARS_COMPAT
						5'd0: index <= write_data;
						5'd2: entrylo0 <= write_data;
						5'd3: entrylo1 <= write_data;
						5'd10: entryhi <= write_data;
						5'd12: sr <= write_data;
						5'd13: cause <= write_data;
						5'd14: epc_i <= write_data;
`else /* MARS_COMPAT */

						5'd0: index <= {
							write_data[31], /* p */
							{(32 - 1 - `TLB_ADDR_WIDTH){1'b0}}, 
							write_data[`TLB_ADDR_WIDTH - 1:0]
						};

						5'd2: entrylo0 <= {
							5'b0, 
							write_data[25:6], /* pfn */
							3'b0, /* c */
							write_data[2], /* d */
							write_data[1], /* v */
							write_data[0] /* g */
						};

						5'd3: entrylo1 <= {
							5'b0, 
							write_data[25:6], /* pfn */
							3'b0, /* c */
							write_data[2], /* d */
							write_data[1], /* v */
							write_data[0] /* g */
						};

						5'd10: entryhi <= {
							6'b0, 
							write_data[26:8], /* vpn */
							write_data[7:0] /* asid */
						};

						5'd12: {
							`allow_hwirq, 
							`exl, 
							`g_allow_hwirq
						} <= {
							write_data[15:10], 
							write_data[1], 
							write_data[0]
						};

						/* NOTE: for compliance with cscore */
						/* 5'd13: {
					  	 * 	`in_bds_i, 
						 * 	`hwirq_i, 
						 * 	`exc_i
						 * } <= {
						 * 	write_data[31], 
						 * 	write_data[15:10], 
						 * 	write_data[6:2]
						 * }; 
					  	 */

						5'd14: epc_i <= write_data;

`endif /* MARS_COMPAT */
						/* default omitted */
					endcase
				end

				`CP0_EXIT_ISR: begin
					`exl <= 1'b0;
				end

				`CP0_TLBR: begin
					entryhi <= {
						5'b0, 
						mmu_entryhi[26:8], /* vpn */
						mmu_entryhi[7:0] /* asid */
					};

					entrylo0 <= {
						6'b0, 
						mmu_entrylo0[25:6], /* pfn */
						3'b0, /* c */
						mmu_entrylo0[2], /* d */
						mmu_entrylo0[1], /* v */
						(mmu_entrylo0[0] & mmu_entrylo1[0]) /* g */
					};

					entrylo1 <= {
						6'b0, 
						mmu_entrylo1[25:6], /* pfn */
						3'b0, /* c */
						mmu_entrylo1[2], /* d */
						mmu_entrylo1[1], /* v */
						(mmu_entrylo0[0] & mmu_entrylo1[0]) /* g */
					};
				end

				`CP0_TLBP: begin
					if (mmu_hit_cp0 == 1'b1) begin
						index[31] <= 1'b0; /* p */
						index[`TLB_ADDR_WIDTH - 1:0] <= mmu_hit_cp0_index; /* index */
					end else begin
						index[31] <= 1'b1; /* p */
					end				
				end
			endcase
		end

		/* MARS doesn't even update it's hardware IRQ related bits */
`ifndef MARS_COMPAT
		if (~(have2handle == 1'b0 && write_valid == 1'b1 && addr == 5'd13)) begin
			`hwirq_i <= hwirq;
		end
`endif /* MARS_COMPAT */
	end
end

endmodule

