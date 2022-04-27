`timescale 1ns / 1ps

module xor64bit(
    input signed [63:0] A,
    input signed [63:0] B,
    output signed [63:0] out
);

genvar i;

generate for (i = 0; i < 64; i=i+1)
begin
    xor XOR1 (out[i], A[i], B[i]);
end
endgenerate

endmodule
