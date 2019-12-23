`include "pipelined3.h"
`include "instr-id.h"

`include "npc.h"
`include "cp0.h"

module handler(
	input [9:0] dkind, 
	input [9:0] ekind, 
	input [9:0] mkind, 
	input [9:0] wkind, 

	input [4:0] d_exc, 
	input [4:0] e_exc, 
	input [4:0] m_exc, 
	input [4:0] m_exc_final, 

	input rst, 
	input have2handle, 
	input stall, 

	output cw_d_pff_rst, 
	/* cw_e_pff_rst omitted because of need for stall management */
	output cw_m_pff_rst, 
	output cw_w_pff_rst, 

	input [3:0] cw_f_npc_jump_mode_orig, 
	output [3:0] cw_f_npc_jump_mode, 

	input cw_f_pc_enable_orig, 
	output cw_f_pc_enable, 

	input cw_e_pff_rst_orig, 
	output cw_e_pff_rst, 

	output cw_e_md_restore, 
	output cw_e_md_stop, 

	output cw_m_dm_stop, 

	input [3:0] cw_m_cp0_op_orig, 
	output [3:0] cw_m_cp0_op
);

wire [4:0] ddptype;
wire [4:0] edptype;
wire [4:0] mdptype;
wire [4:0] wdptype;

assign ddptype = dkind[9:5];
assign edptype = ekind[9:5];
assign mdptype = mkind[9:5];
assign wdptype = wkind[9:5];

/* Pipeline resetting */

/* Unconditionally reset level D pipeline registers when stalling isn't
 * needed. This effectively blocks execution of the possible instruction
 * following eret. */
assign cw_d_pff_rst = 
	(rst == 1'b1) || 
	(have2handle == 1'b1) || 
	(ddptype == `JUMP_C0 && stall == 1'b0);

/* cw_e_pff_rst omitted */

assign cw_m_pff_rst = 
	(rst == 1'b1) || 
	(have2handle == 1'b1);

assign cw_w_pff_rst = 
	(rst == 1'b1) || 
	(have2handle == 1'b1);

/* Control signal hooking */

/* Force enable pc to help writing NPC_ISR into it. */
assign cw_f_pc_enable = 
	(have2handle == 1'b1) || 
	(cw_f_pc_enable_orig == 1'b1);

assign cw_f_npc_jump_mode = 
	(have2handle == 1'b1) ? `NPC_ISR : 
	cw_f_npc_jump_mode_orig;

assign cw_e_pff_rst = 
	(rst == 1'b1) || 
	(have2handle == 1'b1) || 
	(cw_e_pff_rst_orig == 1'b1);

/* Restore old values of d_h and / or d_l. */
assign cw_e_md_restore = 
	(have2handle == 1'b1) && 
	(mdptype == `STORE_M);

/* Stop commiting new d_h and / or d_l to md. */
assign cw_e_md_stop = 
	(have2handle == 1'b1) && 
	(edptype == `CAL_M || mdptype == `CAL_M || edptype == `STORE_M);

/* Stop commiting to dm and bridge when having to handle interrupts. */
assign cw_m_dm_stop = (have2handle == 1'b1);

/* Stop commiting to cp0 when having to handle interrupts. */
assign cw_m_cp0_op = 
	(have2handle == 1'b1) ? `CP0_NONE : 
	cw_m_cp0_op_orig;

endmodule

