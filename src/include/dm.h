`ifndef DM_H
`define DM_H

`define DM_WRITE_ENABLE 1'b1
`define DM_WRITE_ENABLED `DM_WRITE_ENABLE
`define DM_WRITE_DISABLE 1'b0
`define DM_WRITE_DISABLED `DM_WRITE_DISABLE

`define DM_NONE 3'b000
`define DM_W 3'b001
`define DM_H 3'b011
`define DM_HU 3'b010
`define DM_B 3'b101
`define DM_BU 3'b110

`define DM_ADDR_WIDTH 14
/* The extra 1048 words makes construction of new_word happy (no Xs). */
`define DM_SIZE 4096

`define DM_OUTPUT_FORMAT "%d@%h: *%h <= %h"

`define DM_ADDR_UB 32'h00002fff 
`define DM_ADDR_LB 32'h00000000

`endif

