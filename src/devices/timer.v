`include "timer.h"

`define PART_NAME "timer"

`include "debug/debug.h"

module timer(
	input clk, 
	input rst, 
	input [31:0] addr, 
	input write_enable, 
	input [31:0] write_data, 
	output [31:0] read_result, 
	output irq
);

parameter BASE = 32'h00007f00;

reg [31:0] preset, count;
reg allow_irq, mode, enable, irq_reg;

wire [31:0] ctrl;
assign ctrl = {28'b0, allow_irq, 1'b0, mode, enable};

assign irq = irq_reg;

wire [31:0] real_addr;
assign real_addr = $unsigned(addr) - $unsigned(BASE);

wire write_valid;
assign write_valid = (write_enable == 1'b1) && (real_addr == 0 || real_addr == 4); 

reg [2:0] state;

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
	end else begin
		if (write_valid == 1'b1) begin
			case (real_addr)
				32'd0: {allow_irq, mode, enable} <= {write_data[3], write_data[1], write_data[0]};
				32'd4: preset <= write_data;
				/* default omitted */
			endcase
		end else begin
			case (state)
				`TIMER_IDLE: begin
					if (enable == 1'b1) begin
						irq_reg <= 1'b0;
						state <= `TIMER_LOAD;
					end else begin
						if (allow_irq == 1'b0) begin
							irq_reg <= 1'b0;
						end
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
						if ($unsigned(count) > $unsigned(1)) begin
							count <= $unsigned(count) - $unsigned(1);
						end else begin
							if ($unsigned(count) == $unsigned(1)) begin
								count <= $unsigned(count) - $unsigned(1);
								state <= `TIMER_INT;
								if (allow_irq == 1'b1) begin
									irq_reg <= 1'b1;
								end
							end
						end
					end
				end
				`TIMER_INT: begin
					state <= `TIMER_IDLE;
					if (mode == 1'b0) begin
						enable <= 1'b0;
						if (allow_irq == 1'b0) begin
							irq_reg <= 1'b0;
						end
					end else begin
						if (mode == 1'b1) begin
							irq_reg <= 1'b0;
						end
					end
				end
				/* default omitted */
			endcase
		end
	end
end

assign read_result = 
	(real_addr == 32'd0) ? {28'b0, allow_irq, 1'b0, mode, enable} : 
	(real_addr == 32'd4) ? preset : 
	(real_addr == 32'd8) ? count : 
	32'b0;

endmodule

