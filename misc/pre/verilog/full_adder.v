`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:42:01 09/07/2019 
// Design Name: 
// Module Name:    full_adder 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module full_adder(
    );


reg A, B, Cin;

wire Sum, Overflow;



initial begin

A = 0; B = 0; Cin = 0;

$monitor("%04dns monitor: A=%d, B=%d, Cin=%d, Sum=%d, Overflow=%d", $time, A, B, Cin, Sum, Overflow);

#1000 $finish;

end



always #50 Cin = Cin + 1;

always #100 A = A + 1;

always #200 B = B + 1;

assign {Overflow, Sum} = $unsigned(A) + $unsigned(B) + $unsigned(Cin);


endmodule
