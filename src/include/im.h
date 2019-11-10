`ifndef IM_H
`define IM_H

`define IM_ENABLED 1'b1
`define IM_DISABLED 1'b0

/* IM_SIZE == 2^(IM_ADDR_WIDTH - 2) */

`define IM_ADDR_WIDTH 14
`define IM_SIZE 4096

`define IM_CODE_FILENAME "code.txt"

`define IM_START_ADDRESS 32'h00003000

`endif

