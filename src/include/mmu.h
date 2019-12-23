`ifndef MMU_H
`define MMU_H

/* TLB_COUNT == 2 ** TLB_ADDR_WIDTH */

`define TLB_ADDR_WIDTH 2
`define TLB_COUNT 4

`define MMU_NOMMU_LB 32'h80000000
`define MMU_NOMMU_UB 32'hbffffffc

`endif

