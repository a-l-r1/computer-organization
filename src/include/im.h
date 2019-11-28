`ifndef IM_H
`define IM_H

`define IM_ENABLE 1'b1
`define IM_ENABLED `IM_ENABLE
`define IM_DISABLE 1'b0
`define IM_DISABLED `IM_DISABLE

/* IM_SIZE == 2^(IM_ADDR_WIDTH - 2) */

`define IM_ADDR_WIDTH 14
`define IM_SIZE 4096

`define IM_CODE_FILENAME "code.txt"
`define IM_ISR_CODE_FILENAME "code_handler.txt"

`define IM_START_ADDRESS 32'h00003000
`define IM_ISR_START_ADDRESS 32'h00004180

`define IM_ADDR_LB 32'h00003000
`define IM_ADDR_UB 32'h00004fff

`endif

