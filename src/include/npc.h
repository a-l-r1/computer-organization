`ifndef NPC_H
`define NPC_H

`define NPC_JUMP_DISABLED 4'b0000
`define NPC_EQUAL 4'b0001
`define NPC_NOT_EQUAL 4'b0010

`define NPC_LARGER 4'b0011
`define NPC_SMALLER 4'b0100
`define NPC_LARGER_OR_EQUAL 4'b0101
`define NPC_SMALLER_OR_EQUAL 5'b0110

`define NPC_SIG_LARGER 4'b0111
`define NPC_SIG_SMALLER 4'b1000
`define NPC_SIG_LARGER_OR_EQUAL 4'b1001
`define NPC_SIG_SMALLER_OR_EQUAL 4'b1010

`define NPC_REG 4'b1111
`define NPC_J 4'b1110

`endif

