module nixie_decoder(
	input [3:0] data, 
	output [7:0] out
)

assign out = 
	(data == 4'h0) ? 8'b10000001 : 
	(data == 4'h1) ? 8'b11001111 : 
	(data == 4'h2) ? 8'b10010010 : 
	(data == 4'h3) ? 8'b10000110 : 
	(data == 4'h4) ? 8'b11001100 : 
	(data == 4'h5) ? 8'b10100100 : 
	(data == 4'h6) ? 8'b10100000 : 
	(data == 4'h7) ? 8'b10001111 : 
	(data == 4'h8) ? 8'b10000000 : 
	(data == 4'h9) ? 8'b10000100 : 
	(data == 4'ha) ? 8'b10001000 : 
	(data == 4'hb) ? 8'b11100000 : 
	(data == 4'hc) ? 8'b10110001 : 
	(data == 4'hd) ? 8'b11000010 : 
	(data == 4'he) ? 8'b10110000 : 
	(data == 4'hf) ? 8'b10111000 : 
	8'b11111111;

endmodule

