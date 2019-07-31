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
end

`ROBOST_FUNCTION [3:0] get_datapath_type begin
	input [31:0] instr;

	reg [8:0] kind;
	kind = get_kind(instr);

	get_datapath_type = kind[8:5];
end

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
end

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
end

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
end

`ROBUST_FUNCTION can_fw_reg1 begin
	input [31:0] instr_new;
	input [31:0] instr_old;

	can_fw_reg1 = (get_read_reg1(instr_new) == get_write_reg(instr_old)) && (get_read_reg1(instr_new) != `REG_NULL)

	if (can_fw_reg1) begin
		`debug_print(("forwarding detected: 0x%08x -> 0x%08x, reg1 %0d", instr_old, instr_new, get_read_reg1(instr_new)));
	end
end

`ROBUST_FUNCTION can_fw_reg2 begin
	input [31:0] instr_new;
	input [31:0] instr_old;

	can_fw_reg2 = (get_read_reg2(instr_new) == get_write_reg(instr_old)) && (get_read_reg2(instr_new) != `REG_NULL)

	if (can_fw_reg2) begin
		`debug_print(("forwarding detected: 0x%08x -> 0x%08x, reg2 %0d", instr_old, instr_new, get_read_reg2(instr_new)));
	end
end

