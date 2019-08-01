`include "instr-id.h"

`define PART_NAME "instr-id"

`include "debug/debug.h"

`ROBOST_FUNCTION [8:0] get_kind begin
	input [31:0] instr;
	
	case `GET_OP(instr) begin
		`OP_R : begin
			case `GET_FUNCT(instr) begin
				`FUNCT_ADDU: begin
					`IF_OR_UNKNOWN(`GET_SHAMT(instr) == `SHAMT_ZERO, `ADDU);
				end
				`FUNCT_SUBU: begin
					`IF_OR_UNKNOWN(`GET_SHAMT(instr) == `SHAMT_ZERO, `SUBU);
				end
				default: get_kind = `UNKNOWN;
			end
		end
		`OP_LUI: begin
			`IF_OR_UNKNOWN(`GET_RS(instr) == `REG_ZERO, `LUI);
		end
		`OP_ORI: get_kind = `ORI;
		`OP_LW: get_kind = `LW;
		`OP_SW: get_kind = `SW;
		`OP_BEQ: get_kind = `BEQ;
		`OP_NOP: begin
			/* TODO: hack */
			if (instr == 32'b0) begin
				get_kind = `NOP;
			end else begin
				get_kind = `UNKNOWN;
			end
		end
		default: get_kind = `UNKNOWN;
	end
endfunction

`ROBOST_FUNCTION [3:0] get_datapath_type begin
	input [31:0] instr;

	reg [8:0] kind;
	kind = get_kind(instr);

	get_datapath_type = kind[8:5];
endfunction

`ROBOST_FUNCTION [4:0] get_read_reg1 begin
	input [31:0] instr;

	reg [3:0] datapath_type;
	datapath_type = get_datapath_type(instr);

	case (datapath_type) begin
		`UNKNOWN: get_read_reg1 = `REG_NULL;
		`CAL_R: get_read_reg1 = `GET_RS(instr);
		`CAL_I: get_read_reg1 = `GET_RS(instr);
		`LOAD: get_read_reg1 = `GET_RS(instr);
		`STORE: get_read_reg1 = `GET_RS(instr);
		`BRANCH: get_read_reg1 = `GET_RS(instr);
		`NOP: get_read_reg1 = `REG_NULL;
	endcase
endfunction

`ROBOST_FUNCTION [4:0] get_read_reg2 begin
	input [31:0] instr;

	reg [3:0] datapath_type;
	datapath_type = get_datapath_type(instr);

	case (datapath_type) begin
		`UNKNOWN: get_read_reg2 = `REG_NULL;
		`CAL_R: get_read_reg2 = `GET_RT(instr);
		`CAL_I: get_read_reg2 = `REG_NULL;
		`LOAD: get_read_reg2 = `REG_NULL;
		`STORE: get_read_reg2 = `GET_RT(instr);
		`BRANCH: get_read_reg2 = `GET_RT(instr);
		`NOP: get_read_reg2 = `REG_NULL;
	endcase
endfunction

`ROBUST_FUNCTION [4:0] get_write_reg begin
	input [31:0] instr;

	reg [3:0] datapath_type;
	datapath_type = get_datapath_type(instr);

	case (datapath_type) begin
		`UNKNOWN: get_write_reg = `REG_NULL;
		`CAL_R: get_write_reg = `GET_RD(instr);
		`CAL_I: get_write_reg = `GET_RT(instr);
		`LOAD: get_write_reg = `GET_RT(instr);
		`STORE: get_write_reg = `REG_NULL;
		`BRANCH: get_write_reg = `REG_NULL;
		`NOP: get_write_reg = `REG_NULL;
	endcase
endfunction

`ROBUST_FUNCTION can_fw_reg1 begin
	input [31:0] instr_new;
	input [31:0] instr_old;

	can_fw_reg1 = (get_read_reg1(instr_new) == get_write_reg(instr_old)) && (get_read_reg1(instr_new) != `REG_NULL)

	if (can_fw_reg1) begin
		`debug_print(("forwarding detected: 0x%08x -> 0x%08x, reg1 %0d", instr_old, instr_new, get_read_reg1(instr_new)));
	end
endfunction

`ROBUST_FUNCTION can_fw_reg2 begin
	input [31:0] instr_new;
	input [31:0] instr_old;

	can_fw_reg2 = (get_read_reg2(instr_new) == get_write_reg(instr_old)) && (get_read_reg2(instr_new) != `REG_NULL)

	if (can_fw_reg2) begin
		`debug_print(("forwarding detected: 0x%08x -> 0x%08x, reg2 %0d", instr_old, instr_new, get_read_reg2(instr_new)));
	end
endfunction

`ROBOUST_FUNCTION get_d_ext_mode begin
	input [31:0] instr;
	reg [8:0] kind;
	reg [3:0] datapath_type;

	type = get_type
	datapath_type = get_datapath_type(instr);
	case (datapath_type) begin
		`CAL_R: get_ext_mode = `EXT_MODE_SIGNED;
		`CAL_I: begin
			case (kind) begin
				`LUI: get_ext_mode = `EXT_MODE_PAD;
				`ORI: get_ext_mode = `EXT_MODE_UNSIGNED;
				default: get_ext_mode = `EXT_MODE_SIGNED;
			endcase
		end
		`LOAD: get_ext_mode = `EXT_MODE_SIGNED;
		`STORE: get_ext_mode = `EXT_MODE_SIGNED;
		`BRANCH: get_ext_mode = `EXT_MODE_SIGNED;
		`NOP: get_ext_mode = `EXT_MODE_SIGNED;
		default: get_ext_mode = `EXT_MODE_SIGNED;
	endcase
endfunction

`ROBUST_FUNCTION get_e_m_alu_num2 begin
	input [31:0] curr_instr;
	reg [3:0] datapath_type;

	datapath_type = get_datapath_type(curr_instr);
	case (datapath_type) begin
		/* See doc/datapath/pipelined.md */
		`CAL_R: get_m_alu_num2 = 1'b0;
		`CAL_I: get_m_alu_num2 = 1'b1;
		`LOAD: get_m_alu_num2 = 1'b1;
		`STORE: get_m_alu_num2 = 1'b1;
		`BRANCH: get_m_alu_num2 = 1'b0;
		`NOP: get_m_alu_num2 = 1'b0;
		default: get_m_alu_num2 = 1'b0;
	endcase
endfunction

`ROBUST_FUNCTION get_e_alu_op begin
	input [31:0] instr;
	reg [8:0] kind;
	reg [3:0] datapath_type;

	case (datapath_type) begin
		`CAL_R: begin
			case (kind) begin
				`ADDU: get_alu_op = `ALU_ADD;
				`SUBU: get_alu_op = `ALU_SUB;
				default: get_alu_op = `ALU_OR;
			end
		end
		`CAL_I: begin
			case (kind) begin
				`LUI: get_alu_op = `ALU_OR;
				`ORI: get_alu_op = `ALU_OR;
				default: get_alu_op = `ALU_OR;
			end
		end
		`LOAD: get_alu_op = `ALU_ADD;
		`STORE: get_alu_op = `ALU_ADD;
		`BRANCH: get_alu_op = `ALU_OR;
		`NOP: get_alu_op = `ALU_OR;
		default: get_alu_op = `ALU_OR;
	endcase
endfunction

`ROBUST_FUNCTION get_m_dm_write_enable begin
	input [31:0] instr;
	reg [3:0] datapath_type;

	datapath_type = get_datapath_type(instr);
	case (datapath_type) begin
		`CAL_R: get_dm_write_enable = 1'b0;
		`CAL_I: get_dm_write_enable = 1'b0;
		`LOAD: get_dm_write_enable = 1'b0;
		`STORE: get_dm_write_enable = 1'b1;
		`BRANCH: get_dm_write_enable = 1'b0;
		`NOP: get_dm_write_enable = 1'b0;
		default: get_dm_write_enable = 1'b0;
	endcase
endfunction

`ROBUST_FUNCTION get_w_rf_write_enable begin
	input [31:0] instr;
	reg [3:0] datapath_type;

	case (datapath_type) begin
		`CAL_R: get_rf_write_enable = 1'b1;
		`CAL_I: get_rf_write_enable = 1'b1;
		`LOAD: get_rf_write_enable = 1'b0;
		`STORE: get_rf_write_enable = 1'b1;
		`BRANCH: get_rf_write_enable = 1'b0;
		`NOP: get_rf_write_enable = 1'b0;
		default: get_rf_write_enable = 1'b0;
	endcase
endfunction

`ROBUST_FUNCTION get_w_m_rf_write_data begin
	input [31:0] instr;
	reg [3:0] datapath_type;

	case (datapath_type) begin
		/* See doc/datapath/pipelined.md */
		`CAL_R: get_m_rf_write_data = 1'b0;
		`CAL_I: get_m_rf_write_data = 1'b0;
		`LOAD: get_m_rf_write_data = 1'b1;
		`STORE: get_m_rf_write_data = 1'b0;
		`BRANCH: get_m_rf_write_data = 1'b0;
		`NOP: get_m_rf_write_data = 1'b0;
		default: get_m_rf_write_data = 1'b0;
	endcase
endfunction

`ROBUST_FUNCTION get_fm_d1 begin
	input [31:0] d_instr;
	input [31:0] e_instr;
	input [31:0] m_instr;
	input [31:0] w_instr;

	if can_fw_reg1(d_instr, e_instr) begin
		get_fm_d1 = `FW_D_E;
	end else begin
		if can_fw_reg1(d_instr, m_instr) begin
			get_fm_d1 = `FW_D_M;
		end else begin
			if can_fw_reg1(d_instr, w_instr) begin
				get_fm_d1 = `FM_D_W;
			end else begin
				get_fm_d1 = `FM_D_NONE;
			end
		end
	end
endfunction

`ROBUST_FUNCTION get_fm_e1 begin
	input [31:0] e_instr;
	input [31:0] m_instr;
	input [31:0] w_instr;

	if can_fw_reg1(e_instr, m_instr) begin
		get_fm_e1 = `FW_E_M;
	end else begin
		if can_fw_reg2(e_instr, w_instr) begin
			get_fm_e1 = `FW_E_W;
		end else begin
			get_fm_e1 = `FW_E_NONE;
		end
	end
endfunction

/* Edit get_fm_[de]1 instead */
/* Do s/1/2/g, then s/32/31/g */

`ROBUST_FUNCTION get_fm_d2 begin
	input [31:0] d_instr;
	input [31:0] e_instr;
	input [31:0] m_instr;
	input [31:0] w_instr;

	if can_fw_reg2(d_instr, e_instr) begin
		get_fm_d2 = `FW_D_E;
	end else begin
		if can_fw_reg2(d_instr, m_instr) begin
			get_fm_d2 = `FW_D_M;
		end else begin
			if can_fw_reg2(d_instr, w_instr) begin
				get_fm_d2 = `FM_D_W;
			end else begin
				get_fm_d2 = `FM_D_NONE;
			end
		end
	end
endfunction

`ROBUST_FUNCTION get_fm_e2 begin
	input [31:0] e_instr;
	input [31:0] m_instr;
	input [31:0] w_instr;

	if can_fw_reg2(e_instr, m_instr) begin
		get_fm_e2 = `FW_E_M;
	end else begin
		if can_fw_reg2(e_instr, w_instr) begin
			get_fm_e2 = `FW_E_W;
		end else begin
			get_fm_e2 = `FW_E_NONE;
		end
	end
endfunction

`ROBUST_FUNCTION get_stall begin
	input [31:0] d_instr;
	input [31:0] e_instr;
	reg [3:0] d_datapath_type;
	reg [3:0] e_datapath_type;

	d_datapath_type = get_datapath_type(d_instr);
	e_datapath_type = get_datapath_type(e_instr);

	if (can_fw_reg1(d_instr, e_instr) || can_fw_reg2(d_instr, e_instr)) begin
		case (e_datapath_type) begin
			`LOAD: begin
				case (d_datapath_type) begin
					`CAL_R: get_stall = 1'b1;
					`CAL_I: get_stall = 1'b1;
					`LOAD: get_stall = 1'b1;
					`STORE: get_stall = 1'b1;
					`BRANCH: get_stall = 1'b1;
					`NOP: get_stall = 1'b0;
					default: get_stall = 1'b0;
				endcase
			end
			default: get_stall = 1'b0;
		endcase
	end
endfunction

module control(
	input clk, 
	input [31:0] curr_instr, 
	output cw_pc_enable, 
	output cw_d_pff_enable, 
	output [2:0] cw_d_ext_mode, 
	output [4:0] cw_d_rf_read_addr1, 
	output [4:0] cw_d_rf_read_addr2, 
	output cw_e_m_alu_num2, 
	output [4:0] cw_e_alu_op, 
	output cw_m_dm_write_enable, 
	output cw_w_rf_write_enable, 
	output cw_w_m_rf_write_data, 
	output [4:0] cw_w_rf_write_addr, 
	output [1:0] cw_fm_d1, 
	output [1:0] cw_fm_d2, 
	output [1:0] cw_fm_e1, 
	output [1:0] cw_fm_e2
)

reg [31:0] d_instr;
reg [31:0] e_instr;
reg [31:0] m_instr;
reg [31:0] w_instr;

wire stall;

initial begin
	d_instr = 32'b0;
	e_instr = 32'b0;
	m_instr = 32'b0;
	w_instr = 32'b0;
end

always @(posedge clk) begin
	if (stall == 1'b1) begin
		`debug_print(("stall detected"));
		d_instr <= 32'b0;
		e_instr <= d_instr;
		m_instr <= e_instr;
		w_instr <= m_instr;
	end else begin
		d_instr <= curr_instr;
		e_instr <= d_instr;
		m_instr <= e_instr;
		w_instr <= m_instr;
	end

	`debug_print(("instructions: D: 0x%08x, E: 0x%08x, M: 0x%08x, W: 0x%08x", d_instr, e_instr, m_instr, w_instr))
end

assign cw_d_ext_mode = get_d_ext_mode(d_instr);
assign cw_e_m_alu_num2 = get_e_m_alu_num2(e_instr);
assign cw_e_alu_op = get_e_alu_op(e_instr);
assign cw_m_dm_write_enable = get_m_dm_write_enable(m_instr);
assign cw_w_rf_write_enable = get_w_rf_write_enable(w_instr);
assign cw_w_m_rf_write_data = get_w_m_rf_write_data(w_instr);

assign cw_d_rf_read_addr1 = get_read_reg1(d_instr);
assign cw_d_rf_read_addr2 = get_read_reg2(d_instr);
assign cw_w_rf_write_addr = get_write_reg(w_instr);

assign fm_d1 = get_fm_d1(d_instr, e_instr, m_instr, w_instr);
assign fm_d2 = get_fm_d2(d_instr, e_instr, m_instr, w_instr);

assign fm_e1 = get_fm_e1(e_instr, m_instr, w_instr);
assign fm_e2 = get_fm_e2(e_instr, m_instr, w_instr);

assign stall = get_stall(d_instr, e_instr);

assign cw_pc_enable = ~stall;
assign cw_d_pff_enable = ~stall;

endmodule


