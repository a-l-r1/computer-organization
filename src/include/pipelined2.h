`ifndef PIPELINED_H
`define PIPELINED_H

`define is(x, y) ((x) == (y))

`define drs `RS(d_instr)
`define drt `RT(d_instr)
`define drd `RD(d_instr)

`define fwable(old, new) (((old) == (new)) && ((old) != 0))

`define inf 3'd7
`define orig 0
`define E2D_rf 1
`define E2D_npc 2
`define M2D_npc 3
`define M2D_alu 4
`define W2D_rf 5
`define M2D_md 6
`define E2D_md 7

`define M2E_npc 1
`define M2E_alu 2
`define W2E_rf 3
`define M2E_md 4

`define W2M_rf 1

`endif

