`ifndef CP0_H
`define CP0_h

`define EXC_NONE 5'd0
`define EXC_INT 5'd0
`define EXC_MOD 5'd1
`define EXC_TLBL 5'd2
`define EXC_TLBS 5'd3
`define EXC_ADEL 5'd4
`define EXC_ADES 5'd5
`define EXC_RI 5'd10
`define EXC_OV 5'd12

`define CP0_PRID 32'h00000000

`define CP0_NONE 4'b0000
`define CP0_MTC0 4'b0001
`define CP0_EXIT_ISR 4'b0010
`define CP0_TLBR 4'b0011
`define CP0_TLBP 4'b0100

`undef MARS_COMPAT

`endif

