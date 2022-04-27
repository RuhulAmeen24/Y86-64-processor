`timescale 1ns / 1ps

`include "ALU/add/add.v"

module sub64bit(
    input signed [63:0] A,
    input signed [63:0] B,
    output signed [63:0] ans,
    output overflow
);

wire signed [63:0] B_comp; // 1's complement of B

genvar i;

generate for (i = 0; i < 64; i=i+1)
begin
    not NOT1 (B_comp[i], B[i]);
end
endgenerate

wire [63:0] B_2comp; // 2's complement of B
add64bit ADD1 (B_comp, 64'b1, B_2comp, c);

add64bit ADD2 (A, B_2comp, ans, overflow);


endmodule
