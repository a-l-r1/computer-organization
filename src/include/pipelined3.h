`ifndef PIPELINED_H
`define PIPELINED_H

/* Macro definitions */

/* No, can't use `define dkind(x) (dkind_result == x). ISE would crash.
* Salute to ISE. */

`define is(x, y) ((x) == (y))

`define drs `RS(d_instr)
`define drt `RT(d_instr)
`define drd `RD(d_instr)

`define fwable(old, new) (((old) == (new)) && ((old) != 0))

`define inf 3'd7

`define cp0_epc 14

`define orig 4'd0
`define E2D_rf 4'd1
`define E2D_npc 4'd2
`define M2D_npc 4'd3
`define M2D_alu 4'd4
`define W2D_rf 4'd5
`define M2D_md 4'd6
`define E2D_md 4'd7
`define M2D_cp0 4'd8

`define M2E_npc 4'd1
`define M2E_alu 4'd2
`define W2E_rf 4'd3
`define M2E_md 4'd4
`define M2E_cp0 4'd5

`define W2M_rf 4'd1

`define EPC_D2M_rf 4'd1
`define EPC_E2M_rf 4'd2
`define EPC_M2M_rf 4'd3

`endif

