`ifndef PIPELINED_H
`define PIPELINED_H

`define orig 0
`define E2D_rf 1
`define E2D_npc 2
`define M2D_npc 3
`define M2D_alu 4
`define W2D_rf 5

`define M2E_npc 1
`define M2E_alu 2
`define W2E_rf 3

`define W2M_rf 1

`define fwable(old, new) (((old) == (new)) && ((old) != 0))

`endif

