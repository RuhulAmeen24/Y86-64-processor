`timescale 1ns / 1ps

module add64bit(
    input signed [63:0] A,
    input signed [63:0] B,
    output signed [63:0] sum,
    output overflow
);

wire [63:0] carry;

genvar i;

generate for (i = 0; i < 64; i=i+1)
begin
if (i==0) begin
    halfadder add1 (A[i],B[i],sum[i],carry[i]);
end
if (i != 0) begin
    fulladder add1 (A[i],B[i],carry[i-1],sum[i],carry[i]);
end
end
endgenerate

xor XOR1 (overflow, carry[63], carry[62]);

endmodule


module halfadder(
  input a,
  input b,
  output sum,
  output carry
  );

  xor g2(sum,a,b);
  and g1(carry,a,b);

endmodule

module fulladder(
    input a,
    input b,
    input cin,
    output sum,
    output carry
);

  xor g1(s1,a,b);
  and g2(c1,a,b);
  xor g3(sum,cin,s1);
  and g4(c2,s1,cin);
  or g5(carry,c2,c1);

endmodule
