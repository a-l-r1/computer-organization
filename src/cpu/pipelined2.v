`include "pipelined2.h"

module cpu(
	input clk, 
	input reset
);

/* Wire definitions */

wire rst;
assign rst = reset;

/* Control */

wire cw_f_pc_enable, cw_d_pff_enable;
wire cw_m_dm_write_enable, cw_w_rf_write_enable;
wire cw_m_hilo;
wire [3:0] cw_f_npc_jump_mode;
wire [2:0] cw_d_ext_mode;
wire [4:0] cw_d_rf_read_addr1, cw_d_rf_read_addr2, cw_w_rf_write_addr;
wire [4:0] cw_e_alu_op;
wire [3:0] cw_e_md_op;
wire [2:0] cw_m_dm_mode;
wire [2:0] cw_w_m_regdata;
wire [2:0] cw_fm_d1, cw_fm_d2, cw_fm_e1, cw_fm_e2;
wire [2:0] cw_fm_m;

/* F */

wire [31:0] f_pc_curr_pc, f_npc_next_pc;
wire [31:0] f_im_result;

/* D */

wire [31:0] d_pc_curr_pc;
wire [31:0] d_retaddr;
wire [31:0] d_im_result;
wire [31:0] d_rf_read_result1, d_rf_read_result2;
wire [31:0] d_rf_read_result1_orig, d_rf_read_result2_orig;
wire [31:0] d_ext_result;
wire [1:0] d_cmp_cmp, d_cmp_sig_cmp;

/* E */

wire [31:0] e_pc_curr_pc;
wire [31:0] e_retaddr;
wire [31:0] e_im_result;
wire [31:0] e_ext_result;
wire [31:0] e_alu_result;
wire [31:0] e_rf_read_result1_orig, e_rf_read_result2_orig;
wire [31:0] e_rf_read_result1, e_rf_read_result2;
wire [31:0] e_alu_num2;
wire [31:0] e_md_hi, e_md_lo, e_md_out;

/* M */

wire [31:0] m_pc_curr_pc;
wire [31:0] m_retaddr;
wire [31:0] m_alu_result;
wire [31:0] m_md_out;
wire [31:0] m_rf_read_result2;
wire [31:0] m_dm_write_data;
wire [31:0] m_dm_read_result;

/* W */

wire [31:0] w_pc_curr_pc;
wire [31:0] w_retaddr;
wire [31:0] w_alu_result;
wire [31:0] w_md_out;
wire [31:0] w_dm_read_result;
wire [31:0] w_rf_write_data;

/* Control */

control control(
	.clk(clk), 
	.d_instr(d_im_result), 
	.rf_read_result2(d_rf_read_result2), 
	.e_md_busy(e_md_busy), 
	.cw_f_pc_enable(cw_f_pc_enable), 
	.cw_f_npc_jump_mode(cw_f_npc_jump_mode), 
	.cw_d_pff_enable(cw_d_pff_enable), 
	.cw_e_pff_rst(cw_e_pff_rst), 
	.cw_d_ext_mode(cw_d_ext_mode), 
	.cw_d_rf_read_addr1(cw_d_rf_read_addr1), 
	.cw_d_rf_read_addr2(cw_d_rf_read_addr2), 
	.cw_e_m_alusrc(cw_e_m_alusrc), 
	.cw_e_alu_op(cw_e_alu_op), 
	.cw_e_md_op(cw_e_md_op), 
	.cw_m_hilo(cw_m_hilo), 
	.cw_m_dm_write_enable(cw_m_dm_write_enable), 
	.cw_m_dm_mode(cw_m_dm_mode), 
	.cw_w_rf_write_enable(cw_w_rf_write_enable), 
	.cw_w_m_regdata(cw_w_m_regdata), 
	.cw_w_rf_write_addr(cw_w_rf_write_addr), 
	.cw_fm_d1(cw_fm_d1), 
	.cw_fm_d2(cw_fm_d2), 
	.cw_fm_e1(cw_fm_e1), 
	.cw_fm_e2(cw_fm_e2), 
	.cw_fm_m(cw_fm_m)
);

/* F */

npc npc(
	.curr_pc(f_pc_curr_pc), 
	.jump_mode(cw_f_npc_jump_mode), 
	.cmp_result(d_cmp_cmp), 
	.cmp_sig_result(d_cmp_sig_cmp), 
	.num(d_im_result[15:0]), 
	.jnum(d_im_result[25:0]), 
	.reg_(d_rf_read_result1), 
	.next_pc(f_npc_next_pc)
);

pc pc(
	.clk(clk), 
	.next_pc(f_npc_next_pc), 
	.enable(cw_f_pc_enable), 
	.curr_pc(f_pc_curr_pc)
);

im im(
	.addr(f_pc_curr_pc), 
	/* im is always enabled */
	.enable(1'b1), 
	.result(f_im_result)
);

/* D */

pff #(.BIT_WIDTH(32)) d_pc(
	.clk(clk), 
	.enable(cw_d_pff_enable), 
	.rst(1'b0), 
	.i(f_pc_curr_pc), 
	.o(d_pc_curr_pc)
);

assign d_retaddr = $unsigned(d_pc_curr_pc) + $unsigned(8);

pff #(.BIT_WIDTH(32)) d_im(
	.clk(clk), 
	.enable(cw_d_pff_enable), 
	.rst(1'b0), 
	.i(f_im_result), 
	.o(d_im_result)
);

rf rf(
	.clk(clk), 
	.rst(rst), 
	/* display the corresponding pc of the instruction in level D */
	.curr_pc(w_pc_curr_pc), 
	.read_addr1(cw_d_rf_read_addr1), 
	.read_addr2(cw_d_rf_read_addr2), 
	.write_addr(cw_w_rf_write_addr), 
	.write_data(w_rf_write_data), 
	.write_enable(cw_w_rf_write_enable), 
	.read_result1(d_rf_read_result1_orig), 
	.read_result2(d_rf_read_result2_orig)
);

ext ext(
	.mode(cw_d_ext_mode), 
	.num(d_im_result[15:0]), 
	.result(d_ext_result)
);

assign d_rf_read_result1 = 
	(cw_fm_d1 == `orig) ? d_rf_read_result1_orig : 
	(cw_fm_d1 == `E2D_rf) ? e_rf_read_result1 : 
	(cw_fm_d1 == `E2D_npc) ? e_retaddr : 
	(cw_fm_d1 == `E2D_md) ? e_md_out : 
	(cw_fm_d1 == `M2D_npc) ? m_retaddr : 
	(cw_fm_d1 == `M2D_alu) ? m_alu_result : 
	(cw_fm_d1 == `M2D_md) ? m_md_out : 
	(cw_fm_d1 == `W2D_rf) ? w_rf_write_data : 
	d_rf_read_result1_orig;

/* Edit d_rf_read_result1 instead */

assign d_rf_read_result2 = 
	(cw_fm_d2 == `orig) ? d_rf_read_result2_orig : 
	(cw_fm_d2 == `E2D_rf) ? e_rf_read_result1 : 
	(cw_fm_d2 == `E2D_npc) ? e_retaddr : 
	(cw_fm_d2 == `E2D_md) ? e_md_out : 
	(cw_fm_d2 == `M2D_npc) ? m_retaddr : 
	(cw_fm_d2 == `M2D_alu) ? m_alu_result : 
	(cw_fm_d2 == `M2D_md) ? m_md_out : 
	(cw_fm_d2 == `W2D_rf) ? w_rf_write_data : 
	d_rf_read_result2_orig;

cmp cmp(
	.reg1(d_rf_read_result1), 
	.reg2(d_rf_read_result2), 
	.cmp(d_cmp_cmp), 
	.sig_cmp(d_cmp_sig_cmp), 
	/* unused */
	.reg2_sig_cmp()
);

/* E */

pff #(.BIT_WIDTH(32)) e_pc(
	.clk(clk), 
	.enable(1'b1), 
	.rst(cw_e_pff_rst), 
	.i(d_pc_curr_pc), 
	.o(e_pc_curr_pc)
);

assign e_retaddr = $unsigned(e_pc_curr_pc) + $unsigned(8);

pff #(.BIT_WIDTH(32)) e_im(
	.clk(clk), 
	.enable(1'b1), 
	.rst(cw_e_pff_rst), 
	.i(d_im_result), 
	.o(e_im_result)
);

pff #(.BIT_WIDTH(32)) e_ext(
	.clk(clk), 
	.enable(1'b1), 
	.rst(cw_e_pff_rst), 
	.i(d_ext_result), 
	.o(e_ext_result)
);

pff #(.BIT_WIDTH(32)) e_reg1(
	.clk(clk), 
	.enable(1'b1), 
	.rst(cw_e_pff_rst), 
	.i(d_rf_read_result1), 
	.o(e_rf_read_result1_orig)
);

pff #(.BIT_WIDTH(32)) e_reg2(
	.clk(clk), 
	.enable(1'b1), 
	.rst(cw_e_pff_rst), 
	.i(d_rf_read_result2), 
	.o(e_rf_read_result2_orig)
);

assign e_rf_read_result1 = 
	(cw_fm_e1 == `orig) ? e_rf_read_result1_orig : 
	(cw_fm_e1 == `M2E_npc) ? m_retaddr : 
	(cw_fm_e1 == `M2E_alu) ? m_alu_result : 
	(cw_fm_e1 == `M2E_md) ? m_md_out : 
	(cw_fm_e1 == `W2E_rf) ? w_rf_write_data : 
	e_rf_read_result1_orig;

/* Edit e_rf_read_result1 instead */

assign e_rf_read_result2 = 
	(cw_fm_e2 == `orig) ? e_rf_read_result2_orig : 
	(cw_fm_e2 == `M2E_npc) ? m_retaddr : 
	(cw_fm_e2 == `M2E_alu) ? m_alu_result : 
	(cw_fm_e2 == `M2E_md) ? m_md_out : 
	(cw_fm_e2 == `W2E_rf) ? w_rf_write_data : 
	e_rf_read_result2_orig;

assign e_alu_num2 = 
	(cw_e_m_alusrc == 1'b0) ? e_rf_read_result2 : 
	(cw_e_m_alusrc == 1'b1) ? e_ext_result : 
	e_rf_read_result2;

alu alu(
	.num1(e_rf_read_result1), 
	.num2(e_alu_num2), 
	.op(cw_e_alu_op), 
	.shamt(e_im_result[10:6]), 
	.result(e_alu_result), 
	/* unused */
	.cmp_result(), 
	/* unused */
	.sig_cmp_result(), 
	/* unused */
	.overflow(), 
	/* unused */
	.op_invalid()
);

md md(
	.clk(clk), 
	.dh(e_rf_read_result1), 
	.dl(e_rf_read_result2), 
	.op(cw_e_md_op), 
	.busy(e_md_busy), 
	/* unused */
	.invalid(), 
	.hi(e_md_hi), 
	.lo(e_md_lo)
);

assign e_md_out = 
	(cw_m_hilo == 1'b0) ? e_md_hi : 
	e_md_lo;

/* M */

pff #(.BIT_WIDTH(32)) m_pc(
	.clk(clk), 
	.enable(1'b1), 
	.rst(1'b0), 
	.i(e_pc_curr_pc), 
	.o(m_pc_curr_pc)
);

assign m_retaddr = $unsigned(m_pc_curr_pc) + $unsigned(8);

pff #(.BIT_WIDTH(32)) m_alu(
	.clk(clk), 
	.enable(1'b1), 
	.rst(1'b0), 
	.i(e_alu_result), 
	.o(m_alu_result)
);

pff #(.BIT_WIDTH(32)) m_md(
	.clk(clk), 
	.enable(1'b1), 
	.rst(1'b0), 
	.i(e_md_out), 
	.o(m_md_out)
);

pff #(.BIT_WIDTH(32)) m_reg2(
	.clk(clk), 
	.enable(1'b1), 
	.rst(1'b0), 
	.i(e_rf_read_result2), 
	.o(m_rf_read_result2)
);

assign m_dm_write_data = 
	(cw_fm_m == `orig) ? m_rf_read_result2 : 
	(cw_fm_m == `W2M_rf) ? w_rf_write_data : 
	m_rf_read_result2;

dm dm(
	.clk(clk), 
	.rst(rst), 
	.curr_pc(m_pc_curr_pc), 
	.read_addr(m_alu_result), 
	.write_addr(m_alu_result), 
	.write_data(m_dm_write_data), 
	.write_enable(cw_m_dm_write_enable), 
	.mode(cw_m_dm_mode), 
	.read_result(m_dm_read_result), 
	/* unused */
	.invalid()
);

/* W */

pff #(.BIT_WIDTH(32)) w_pc(
	.clk(clk), 
	.enable(1'b1), 
	.rst(1'b0), 
	.i(m_pc_curr_pc), 
	.o(w_pc_curr_pc)
);

assign w_retaddr = $unsigned(w_pc_curr_pc) + $unsigned(8);

pff #(.BIT_WIDTH(32)) w_alu(
	.clk(clk), 
	.enable(1'b1), 
	.rst(1'b0), 
	.i(m_alu_result), 
	.o(w_alu_result)
);

pff #(.BIT_WIDTH(32)) w_md(
	.clk(clk), 
	.enable(1'b1), 
	.rst(1'b0), 
	.i(m_md_out), 
	.o(w_md_out)
);

pff #(.BIT_WIDTH(32)) w_dm(
	.clk(clk), 
	.enable(1'b1), 
	.rst(1'b0), 
	.i(m_dm_read_result), 
	.o(w_dm_read_result)
);

assign w_rf_write_data = 
	(cw_w_m_regdata == 3'd0) ? 32'h0 : 
	(cw_w_m_regdata == 3'd1) ? w_alu_result : 
	(cw_w_m_regdata == 3'd2) ? w_dm_read_result : 
	(cw_w_m_regdata == 3'd3) ? w_retaddr : 
	(cw_w_m_regdata == 3'd4) ? w_md_out : 
	32'h0;

endmodule

