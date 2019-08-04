`ifndef DM_H
`define DM_H

`define DM_WRITE_ENABLE 1'b1
`define DM_WRITE_ENABLED `DM_WRITE_ENABLE
`define DM_WRITE_DISABLE 1'b0
`define DM_WRITE_DISABLED `DM_WRITE_DISABLE

/* DM_SIZE == 2^(DM_ADDR_WIDTH - 2) */

`define DM_ADDR_WIDTH 12
`define DM_SIZE 1024

`define DM_OUTPUT_FORMAT "%d@%h: *%h <= %h"

`endif

