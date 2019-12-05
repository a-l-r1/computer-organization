`ifndef ALU_H
`define ALU_H

`define ALU_ADD 5'b00000
`define ALU_UNSIGNED_ADD `ALU_ADD
`define ALU_SUB 5'b00001
`define ALU_UNSIGNED_SUB `ALU_SUB
`define ALU_MOVZ 5'b00010
`define ALU_SLT 5'b00011
`define ALU_SLTU 5'b00100
`define ALU_ADDU 5'b00101
`define ALU_SUBU 5'b00110

`define ALU_AND 5'b10000
`define ALU_BITWISE_AND `ALU_AND
`define ALU_OR 5'b10001
`define ALU_BITWISE_OR `ALU_OR
`define ALU_NOT 5'b10010
`define ALU_BITWISE_NOT `ALU_NOT
`define ALU_XOR 5'b10011
`define ALU_BITWISE_XOR `ALU_XOR
`define ALU_NOR 5'b10100
`define ALU_SLL 5'b10101
`define ALU_SRL 5'b10110
`define ALU_SRA 5'b10111
`define ALU_SLLV 5'b11000
`define ALU_SRLV 5'b11001
`define ALU_SRAV 5'b11010

`define ALU_EQUAL 2'b00
`define ALU_EQUAL_TO `ALU_EQUAL
`define ALU_LARGER 2'b01
`define ALU_LARGER_THAN `ALU_LARGER
`define ALU_SMALLER 2'b10
`define ALU_SMALLER_THAN `ALU_SMALLER

`define ALU_OVERFLOW 1'b1
`define ALU_NOT_OVERFLOW 1'b0

`define ALU_INVALID_OP 1'b1
`define ALU_INVALID `ALU_INVALID_OP
`define ALU_VALID_OP 1'b0
`define ALU_VALID `ALU_VALID_OP

`endif

