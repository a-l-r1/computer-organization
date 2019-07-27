`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   09:33:35 07/27/2019
// Design Name:   control
// Module Name:   Z:/home/a-l-r/co/src/tests/control/single-cycle_tb.v
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

module single_cycle_tb;

	// Inputs
	reg [31:0] curr_instr;

	// Outputs
	wire cm_rf_write_addr;
	wire cm_rf_write_data;
	wire cm_alu_num2;
	wire [2:0] cw_npc_jump_mode;
	wire cw_pc_enable;
	wire cw_im_enable;
	wire cw_rf_write_enable;
	wire [4:0] cw_alu_op;
	wire [2:0] cw_ext_mode;
	wire cw_dm_write_enable;

	// Instantiate the Unit Under Test (UUT)
	control uut (
		.curr_instr(curr_instr), 
		.cm_rf_write_addr(cm_rf_write_addr), 
		.cm_rf_write_data(cm_rf_write_data), 
		.cm_alu_num2(cm_alu_num2), 
		.cw_npc_jump_mode(cw_npc_jump_mode), 
		.cw_pc_enable(cw_pc_enable), 
		.cw_im_enable(cw_im_enable), 
		.cw_rf_write_enable(cw_rf_write_enable), 
		.cw_alu_op(cw_alu_op), 
		.cw_ext_mode(cw_ext_mode), 
		.cw_dm_write_enable(cw_dm_write_enable)
	);

	initial begin
		// Initialize Inputs
		curr_instr = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		/* nop */
		#10;
		curr_instr = 32'h00000000;

		/* addu $1, $2, $3 */
		#10;
		curr_instr = 32'h00430821;
		
		/* subu $4, $5, $6 */
		#10;
		curr_instr = 32'h00a62023;
		
		/* lui $5, 0xffff */
		#10;
		curr_instr = 32'h3c05ffff;
		
		/* ori $6, 0x4242 */
		#10;
		curr_instr = 32'h34c64242;
		
		/* lw $1, 8($2) */
		#10;
		curr_instr = 32'h8c410008;
		
		/* sw $1, 16($2) */
		#10;
		curr_instr = 32'hac410010;
		
		/* beq $4, $4, -7 */
		#10;
		curr_instr = 32'h114afff9;
	end
      
endmodule

