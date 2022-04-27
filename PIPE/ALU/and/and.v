`timescale 1ns / 1ps

module and64bit(
    input signed [63:0] A,
    input signed [63:0] B,
    output signed [63:0] out
);

genvar i;

generate for (i = 0; i < 64; i = i + 1)
begin
    and AND1 (out[i], A[i], B[i]);
end
endgenerate

endmodule
