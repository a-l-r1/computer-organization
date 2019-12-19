module nixie_decoder(
	input [3:0] data, 
	output [7:0] out
);

wire [7:0] digital_tube_raw;

assign digital_tube_raw = 
	(data == 4'h0) ? 8'b01111110 : 
	(data == 4'h1) ? 8'b00110000 : 
	(data == 4'h2) ? 8'b01101101 : 
	(data == 4'h3) ? 8'b01111001 : 
	(data == 4'h4) ? 8'b00110011 : 
	(data == 4'h5) ? 8'b01011011 : 
	(data == 4'h6) ? 8'b01011111 : 
	(data == 4'h7) ? 8'b01110000 : 
	(data == 4'h8) ? 8'b01111111 : 
	(data == 4'h9) ? 8'b01111011 : 
	(data == 4'ha) ? 8'b01111101 : 
	(data == 4'hb) ? 8'b00011111 : 
	(data == 4'hc) ? 8'b00001101 : 
	(data == 4'hd) ? 8'b00111101 : 
	(data == 4'he) ? 8'b01101111 : 
	(data == 4'hf) ? 8'b01000111 : 
	8'b00000000;

assign out = ~digital_tube_raw;

endmodule

