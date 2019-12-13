`include "timer.h"

`define PART_NAME "timer"

/* NOTE: This code is considered correct under the 3 following assumptions: 
 * 1. Values of all registers have no Xs or Zs. 
 * 2. The state register always contains valid values (values correspond to
 * one and only one state). 
 * 3. No reads or writes to the 4th memory-mapped word (actually invalid) would happen. */

module timer(
	input clk, 
	input rst, 
	input [1:0] addr, 
	input write_enable, 
	input [31:0] write_data, 
	output [31:0] read_result, 
	output irq
);

reg [31:0] preset, count;
reg [1:0] mode;
reg allow_irq, enable, irq_reg;

reg [2:0] state;

wire [31:0] ctrl;
assign ctrl = {28'b0, allow_irq, mode, enable};

assign irq = irq_reg & allow_irq;

assign read_result = 
	(addr == 2'd0) ? ctrl : 
	(addr == 2'd1) ? preset : 
	(addr == 2'd2) ? count : 
	32'b0;

initial begin
	preset <= 0;
	count <= 0;
	allow_irq <= 0;
	mode <= 0;
	enable <= 0;
	state <= `TIMER_IDLE;
	irq_reg <= 0;
end

always @(posedge clk) begin
	if (rst == 1'b1) begin
		preset <= 0;
		count <= 0;
		allow_irq <= 0;
		mode <= 0;
		enable <= 0;
		state <= `TIMER_IDLE;
		irq_reg <= 0;
	end else begin

		if (write_enable == 1'b1) begin
			case (addr)
				2'd0: {allow_irq, mode, enable} <= {write_data[3], write_data[2:1], write_data[0]};
				2'd1: preset <= write_data;
				/* default omitted */
			endcase

		end else begin
			case (state)
				`TIMER_IDLE: begin
					if (enable == 1'b1) begin
						irq_reg <= 1'b0;
						state <= `TIMER_LOAD;
					end
				end

				`TIMER_LOAD: begin
					count <= preset;
					state <= `TIMER_CNT;
				end

				`TIMER_CNT: begin
					if (enable == 1'b0) begin
						state <= `TIMER_IDLE;
					end else begin
						/* NOTE: No $unsigned
						* wrappings since the 
						* example doesn't
						* have them. */
						if (count > 1) begin
							count <= count - 1;
						end else begin
							count <= 0;
							state <= `TIMER_INT;
							irq_reg <= 1'b1;
						end
					end
				end

				`TIMER_INT: begin
					state <= `TIMER_IDLE;
					if (mode == 2'b00) begin
						enable <= 1'b0;
					end else begin
						irq_reg <= 1'b0;
					end
				end

				/* default omitted */
			endcase
		end
	end
end

endmodule

