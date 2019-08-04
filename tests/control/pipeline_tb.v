`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:30:47 08/03/2019
// Design Name:   control
// Module Name:   C:/cygwin64/home/A-l-r/co/src/tests/control/pipeline_tb.v
// Project Name:  cpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: control
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module pipeline_control_tb;

	// Inputs
	reg clk;
	reg [31:0] d_instr;
	reg [31:0] rf_read_result2;

	// Outputs
	wire cw_f_pc_enable;
	wire cw_d_pff_enable;
	wire [2:0] cw_f_npc_jump_mode;
	wire [2:0] cw_d_ext_mode;
	wire [4:0] cw_d_rf_read_addr1;
	wire [4:0] cw_d_rf_read_addr2;
	wire cw_e_m_alusrc;
	wire [4:0] cw_e_alu_op;
	wire cw_m_dm_write_enable;
	wire cw_w_rf_write_enable;
	wire [2:0] cw_w_m_regdata;
	wire [4:0] cw_w_rf_write_addr;
	wire [2:0] cw_fm_d1;
	wire [2:0] cw_fm_d2;
	wire [2:0] cw_fm_e1;
	wire [2:0] cw_fm_e2;
	wire [2:0] cw_fm_m;

	// Instantiate the Unit Under Test (UUT)
	control uut (
		.clk(clk), 
		.d_instr(d_instr), 
		.rf_read_result2(rf_read_result2), 
		.cw_f_pc_enable(cw_f_pc_enable), 
		.cw_d_pff_enable(cw_d_pff_enable), 
		.cw_f_npc_jump_mode(cw_f_npc_jump_mode), 
		.cw_d_ext_mode(cw_d_ext_mode), 
		.cw_d_rf_read_addr1(cw_d_rf_read_addr1), 
		.cw_d_rf_read_addr2(cw_d_rf_read_addr2), 
		.cw_e_m_alusrc(cw_e_m_alusrc), 
		.cw_e_alu_op(cw_e_alu_op), 
		.cw_m_dm_write_enable(cw_m_dm_write_enable), 
		.cw_w_rf_write_enable(cw_w_rf_write_enable), 
		.cw_w_m_regdata(cw_w_m_regdata), 
		.cw_w_rf_write_addr(cw_w_rf_write_addr), 
		.cw_fm_d1(cw_fm_d1), 
		.cw_fm_d2(cw_fm_d2), 
		.cw_fm_e1(cw_fm_e1), 
		.cw_fm_e2(cw_fm_e2), 
		.cw_fm_m(cw_fm_m)
	);
	
`define nop \
	#10; d_instr = 32'b0; rf_read_result2 = 32'b0
`define flush \
	`nop; `nop; `nop; `nop
`define i(x) d_instr = (x)
`define reg2(x) rf_read_result2 = (x)

`undef TEST_SINGLE
`define TEST_FW

	initial begin
		// Initialize Inputs
		clk = 0;
		d_instr = 0;
		rf_read_result2 = 0;
        
		// Add stimulus here
		
		/* initial nop */
		/* Make sure that instr change always happen before the posedge of clk */
		`i(32'b0); `reg2(32'b0);
		
`ifdef TEST_SINGLE
		/* Single instruction test */
		/* addu $1, $2, $3 */
		#10; `i(32'h00430821); `reg2(32'b0); `flush;
		/* subu $4, $5, $6 */
		#10; `i(32'h00a62023); `reg2(32'b0); `flush;
		/* lui $5, 0xffff */
		#10; `i(32'h3c05ffff); `reg2(32'b0); `flush;
		/* ori $6, 0x4242 */
		#10; `i(32'h34c64242); `reg2(32'b0); `flush;
		/* lw $1, 8($2) */
		#10; `i(32'h8c410008); `reg2(32'b0); `flush;
		/* sw $1, 16($2) */
		#10; `i(32'hac410010); `reg2(32'b0); `flush;
		/* beq $10, $10, -7 */
		#10; `i(32'h114afff9); `reg2(32'b0); `flush;
		/* movz $1, $2, $3 w/ reg2 == 32'b0 */
		#10; `i(32'h0043080a); `reg2(32'b0); `flush;
		/* movz $1, $2, $3 w/ reg2 == 32'b1 */
		#10; `i(32'h0043080a); `reg2(32'b1); `flush;
		/* j 0x4 */
		#10; `i(32'h08000004); `reg2(32'b0); `flush;
		/* jal 0x4 */
		#10; `i(32'h2c000004); `reg2(32'b0); `flush;
		/* jr $30 */
		#10; `i(32'h03c00008); `reg2(32'b0); `flush;
`endif
		
`ifdef TEST_FW
		/* Forwarding test */
		
		/* `E2D_rf, `M2E_alu and `M2D_alu */
		/* movz $1, $2, $3 */
		/* addu $0, $1, $1 */
		#10; `i(32'h0043080a); `reg2(32'b0);
		#10; `i(32'h00210021); `reg2(32'b1);
		`flush;
		
		/* `E2D_npc, `M2E_npc and `M2D_npc */
		/* jal 0x4 */
		/* addu $0, $31, $31 ; in delay slot */
		#10; `i(32'h2c000004); `reg2(32'b0);
		#10; `i(32'h03ff0021); `reg2(32'b1);
		`flush;
		
		/* `W2D_rf and `W2E_rf */
		/* jal 0x4 */
		/* nop */
		/* addu $0, $31, $31 ; pc won't increase since it's in testbench */
		#10; `i(32'h2c000004); `reg2(32'b0);
		#10; `i(32'h00000000); `reg2(32'b0);
		#10; `i(32'h03ff0021); `reg2(32'b1);
		`flush;
		
		/* `W2M_rf */
		/* addu $1, $2, $3 */
		/* sw $1, 16($2) */
		#10; `i(32'h00430821); `reg2(32'b1);
		#10; `i(32'hac410010); `reg2(32'b0);
		`flush;
`endif
		
		/* Flush the pipeline in the end */
		`flush;
	end

	always begin
		#5 clk = ~clk;
	end

endmodule
