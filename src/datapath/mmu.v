`include "mmu.h"

module tlb_hit_checker(
	input [31:0] vaddr, 
	input mem_write_enable, 
	input [31:0] cp0_entryhi, 
	input [31:0] entryhi, 
	input [31:0] entrylo1, 
	input [31:0] entrylo0, 
	output is_hit
);

assign is_hit = (
	/* virtual page hit: page indexes match and access permissions match */
	(vaddr[31:13] == entryhi[26:8]) && /* vaddr */
	(
		(entryhi[7:0] == cp0_entryhi[7:0]) || /* asid */
		/* TODO: Is this correct? */
		(vaddr[12] == 1'b0 && entrylo0[0] == 1'b1) || /* g */
		(vaddr[12] == 1'b1 && entrylo1[0] == 1'b1)
	) && 
	/* physical page hit: valid bit enable and r/w permissions match */
	(
		(vaddr[12] == 1'b0 && entrylo0[1] == 1'b1) || /* v */
		(vaddr[12] == 1'b1 && entrylo1[1] == 1'b1)
	) && 
	(
		((mem_write_enable) == 1'b0) || 
		((mem_write_enable) == 1'b1 && vaddr[12] == 1'b0 && entrylo0[2] == 1'b1) || /* d */
		((mem_write_enable) == 1'b1 && vaddr[12] == 1'b1 && entrylo1[2] == 1'b1)
	)
);

endmodule

module paddr_translator(
	input [31:0] vaddr, 
	input [31:0] entryhi, 
	input [31:0] entrylo1, 
	input [31:0] entrylo0, 
	output [31:0] paddr
);

assign paddr = {
	(vaddr[12] == 1'b0) ? entrylo0[25:6] : /* pfn */
	(vaddr[12] == 1'b1) ? entrylo1[25:6] : 
	20'b0, 
	vaddr[11:0]
};

endmodule

module tlb_hit_cp0_checker(
	input [31:0] cp0_entryhi, 
	input [31:0] entryhi, 
	output is_hit_cp0
);

assign is_hit_cp0 = (
	(cp0_entryhi[26:8] == entryhi[26:8]) && /* vpn */ 
	(cp0_entryhi[7:0] == entryhi[7:0]) /* asid */
);

endmodule

module mmu(
	input clk, 
	input rst, 

	input [31:0] im_vaddr, 
	input [31:0] dm_vaddr, 
	input im_write_enable, 
	input dm_write_enable, 
	output [31:0] im_paddr, 
	output [31:0] dm_paddr, 
	output mmu_hit_im, 
	output mmu_hit_dm, 

	input write_enable, 
	input [`TLB_ADDR_WIDTH - 1:0] cp0_tlb_index, 
	input [31:0] cp0_entryhi, 
	input [31:0] cp0_entrylo0, 
	input [31:0] cp0_entrylo1, 
	output [31:0] mmu_entryhi, 
	output [31:0] mmu_entrylo0, 
	output [31:0] mmu_entrylo1, 

	output mmu_hit_cp0, 
	output [`TLB_ADDR_WIDTH - 1:0] mmu_hit_cp0_index
);

reg [31:0] entryhi [`TLB_COUNT - 1:0];
reg [31:0] entrylo0 [`TLB_COUNT - 1:0];
reg [31:0] entrylo1 [`TLB_COUNT - 1:0];

wire [31:0] im_paddr0, im_paddr1, im_paddr2, im_paddr3;
wire is_hit_im0, is_hit_im1, is_hit_im2, is_hit_im3;

wire [31:0] dm_paddr0, dm_paddr1, dm_paddr2, dm_paddr3;
wire is_hit_dm0, is_hit_dm1, is_hit_dm2, is_hit_dm3;

wire is_hit_cp0_0, is_hit_cp0_1, is_hit_cp0_2, is_hit_cp0_3;

integer i;

initial begin
	for (i = 0; i < `TLB_COUNT; i = i + 1) begin
		entryhi[i] <= 0;
		entrylo0[i] <= 0;
		entrylo1[i] <= 0;
	end
end

always @(posedge clk) begin
	if (rst == 1'b1) begin
		for (i = 0; i < `TLB_COUNT; i = i + 1) begin
			entryhi[i] <= 0;
			entrylo0[i] <= 0;
			entrylo1[i] <= 0;
		end
	end else begin

		if (write_enable == 1'b1) begin
			entryhi[cp0_tlb_index] <= {
				5'b0, 
				cp0_entryhi[26:8], /* vpn */
				cp0_entryhi[7:0] /* asid */
			};

			entrylo0[cp0_tlb_index] <= {
				6'b0, 
				cp0_entrylo0[25:6], /* pfn */
				3'b0, 
				cp0_entrylo0[2], /* d */
				cp0_entrylo0[1], /* v */
				(cp0_entrylo0[0] & cp0_entrylo1[0]) /* g */
			};

			entrylo1[cp0_tlb_index] <= {
				6'b0, 
				cp0_entrylo1[25:6], /* pfn */
				3'b0, 
				cp0_entrylo1[2], /* d */
				cp0_entrylo1[1], /* v */
				(cp0_entrylo0[0] & cp0_entrylo1[0]) /* g */
			};
		end
	end
end

assign mmu_entryhi = entryhi[cp0_tlb_index];
assign mmu_entrylo0 = entrylo0[cp0_tlb_index];
assign mmu_entrylo1 = entrylo1[cp0_tlb_index];

/* NOTE: Modify dm_.* accordingly. */

tlb_hit_checker tlb_hit_checker_im0(
	.vaddr(im_vaddr), 
	.mem_write_enable(im_write_enable), 
	.cp0_entryhi(cp0_entryhi), 
	.entryhi(entryhi[0]), 
	.entrylo1(entrylo1[0]), 
	.entrylo0(entrylo0[0]), 
	.is_hit(is_hit_im0)
);

tlb_hit_checker tlb_hit_checker_im1(
	.vaddr(im_vaddr), 
	.mem_write_enable(im_write_enable), 
	.cp0_entryhi(cp0_entryhi), 
	.entryhi(entryhi[1]), 
	.entrylo1(entrylo1[1]), 
	.entrylo0(entrylo0[1]), 
	.is_hit(is_hit_im1)
);

tlb_hit_checker tlb_hit_checker_im2(
	.vaddr(im_vaddr), 
	.mem_write_enable(im_write_enable), 
	.cp0_entryhi(cp0_entryhi), 
	.entryhi(entryhi[2]), 
	.entrylo1(entrylo1[2]), 
	.entrylo0(entrylo0[2]), 
	.is_hit(is_hit_im2)
);

tlb_hit_checker tlb_hit_checker_im3(
	.vaddr(im_vaddr), 
	.mem_write_enable(im_write_enable), 
	.cp0_entryhi(cp0_entryhi), 
	.entryhi(entryhi[3]), 
	.entrylo1(entrylo1[3]), 
	.entrylo0(entrylo0[3]), 
	.is_hit(is_hit_im3)
);

tlb_hit_checker tlb_hit_checker_dm0(
	.vaddr(dm_vaddr), 
	.mem_write_enable(dm_write_enable), 
	.cp0_entryhi(cp0_entryhi), 
	.entryhi(entryhi[0]), 
	.entrylo1(entrylo1[0]), 
	.entrylo0(entrylo0[0]), 
	.is_hit(is_hit_dm0)
);

tlb_hit_checker tlb_hit_checker_dm1(
	.vaddr(dm_vaddr), 
	.mem_write_enable(dm_write_enable), 
	.cp0_entryhi(cp0_entryhi), 
	.entryhi(entryhi[1]), 
	.entrylo1(entrylo1[1]), 
	.entrylo0(entrylo0[1]), 
	.is_hit(is_hit_dm1)
);

tlb_hit_checker tlb_hit_checker_dm2(
	.vaddr(dm_vaddr), 
	.mem_write_enable(dm_write_enable), 
	.cp0_entryhi(cp0_entryhi), 
	.entryhi(entryhi[2]), 
	.entrylo1(entrylo1[2]), 
	.entrylo0(entrylo0[2]), 
	.is_hit(is_hit_dm2)
);

tlb_hit_checker tlb_hit_checker_dm3(
	.vaddr(dm_vaddr), 
	.mem_write_enable(dm_write_enable), 
	.cp0_entryhi(cp0_entryhi), 
	.entryhi(entryhi[3]), 
	.entrylo1(entrylo1[3]), 
	.entrylo0(entrylo0[3]), 
	.is_hit(is_hit_dm3)
);

paddr_translator paddr_translator_im0(
	.vaddr(im_vaddr), 
	.entryhi(entryhi[0]), 
	.entrylo1(entrylo1[0]), 
	.entrylo0(entrylo0[0]), 
	.paddr(im_paddr0)
);

paddr_translator paddr_translator_im1(
	.vaddr(im_vaddr), 
	.entryhi(entryhi[1]), 
	.entrylo1(entrylo1[1]), 
	.entrylo0(entrylo0[1]), 
	.paddr(im_paddr1)
);

paddr_translator paddr_translator_im2(
	.vaddr(im_vaddr), 
	.entryhi(entryhi[2]), 
	.entrylo1(entrylo1[2]), 
	.entrylo0(entrylo0[2]), 
	.paddr(im_paddr2)
);

paddr_translator paddr_translator_im3(
	.vaddr(im_vaddr), 
	.entryhi(entryhi[3]), 
	.entrylo1(entrylo1[3]), 
	.entrylo0(entrylo0[3]), 
	.paddr(im_paddr3)
);

paddr_translator paddr_translator_dm0(
	.vaddr(dm_vaddr), 
	.entryhi(entryhi[0]), 
	.entrylo1(entrylo1[0]), 
	.entrylo0(entrylo0[0]), 
	.paddr(dm_paddr0)
);

paddr_translator paddr_translator_dm1(
	.vaddr(dm_vaddr), 
	.entryhi(entryhi[1]), 
	.entrylo1(entrylo1[1]), 
	.entrylo0(entrylo0[1]), 
	.paddr(dm_paddr1)
);

paddr_translator paddr_translator_dm2(
	.vaddr(dm_vaddr), 
	.entryhi(entryhi[2]), 
	.entrylo1(entrylo1[2]), 
	.entrylo0(entrylo0[2]), 
	.paddr(dm_paddr2)
);

paddr_translator paddr_translator_dm3(
	.vaddr(dm_vaddr), 
	.entryhi(entryhi[3]), 
	.entrylo1(entrylo1[3]), 
	.entrylo0(entrylo0[3]), 
	.paddr(dm_paddr3)
);

assign {mmu_hit_im, im_paddr} = 
	(
		($unsigned(im_vaddr) >= $unsigned(`MMU_NOMMU_LB)) && 
		($unsigned(im_vaddr) <= $unsigned(`MMU_NOMMU_UB))
	) ? {1'b1, {16'b0, im_vaddr[15:0]}} : 
	/* autogenerated */
	(is_hit_im0 == 1'b1) ? {1'b1, im_paddr0} : 
	(is_hit_im1 == 1'b1) ? {1'b1, im_paddr1} : 
	(is_hit_im2 == 1'b1) ? {1'b1, im_paddr2} : 
	(is_hit_im3 == 1'b1) ? {1'b1, im_paddr3} : 
	/* TODO: TLB exceptions */
	{1'b0, 32'b0};

assign {mmu_hit_dm, dm_paddr} = 
	(
		($unsigned(dm_vaddr) >= $unsigned(`MMU_NOMMU_LB)) && 
		($unsigned(dm_vaddr) <= $unsigned(`MMU_NOMMU_UB))
	) ? {1'b1, {16'b0, dm_vaddr[15:0]}} : 
	/* autogenerated */
	(is_hit_dm0 == 1'b1) ? {1'b1, dm_paddr0} : 
	(is_hit_dm1 == 1'b1) ? {1'b1, dm_paddr1} : 
	(is_hit_dm2 == 1'b1) ? {1'b1, dm_paddr2} : 
	(is_hit_dm3 == 1'b1) ? {1'b1, dm_paddr3} : 
	/* TODO: TLB exceptions */
	{1'b0, 32'b0};

tlb_hit_cp0_checker tlb_hit_cp0_checker0(
	.cp0_entryhi(cp0_entryhi), 
	.entryhi(entryhi[0]), 
	.is_hit_cp0(is_hit_cp0_0)
);

tlb_hit_cp0_checker tlb_hit_cp0_checker1(
	.cp0_entryhi(cp0_entryhi), 
	.entryhi(entryhi[1]), 
	.is_hit_cp0(is_hit_cp0_1)
);

tlb_hit_cp0_checker tlb_hit_cp0_checker2(
	.cp0_entryhi(cp0_entryhi), 
	.entryhi(entryhi[2]), 
	.is_hit_cp0(is_hit_cp0_2)
);

tlb_hit_cp0_checker tlb_hit_cp0_checker3(
	.cp0_entryhi(cp0_entryhi), 
	.entryhi(entryhi[3]), 
	.is_hit_cp0(is_hit_cp0_3)
);

/* NOTE: Only the index matters when dealing with cp0. When cp0_entryhi
 * doesn't hit all the TLB entries, then mmu_hit_cp0_index is UNPREDICTABLE,
 * so it could be assigned an arbitrary value on that condition. */

assign {mmu_hit_cp0, mmu_hit_cp0_index} = 
	/* autogenerated */
	is_hit_cp0_0 ? {1'b1, `TLB_ADDR_WIDTH'd0} : 
	is_hit_cp0_1 ? {1'b1, `TLB_ADDR_WIDTH'd1} : 
	is_hit_cp0_2 ? {1'b1, `TLB_ADDR_WIDTH'd2} : 
	is_hit_cp0_3 ? {1'b1, `TLB_ADDR_WIDTH'd3} : 
	{1'b0, `TLB_ADDR_WIDTH'd3};

endmodule

