module xor64bit_tb;

reg signed [63:0] A, B;
wire signed [63:0] out;

xor64bit XOR64 (
    .A(A),
    .B(B),
    .out(out)
);

initial
begin
    $dumpfile ("xor64bit.vcd");
    $dumpvars (0, xor64bit_tb);
    $monitor($time, " A = %d, B = %d, Out = %d\n", A, B, out);
    #5 A = 9223372036854775807; B = 1;
    #5 A = -9223372036854775808; B = -1;
    #5 A = 27365798; B= -12131445567;
    #5 A = 3; B = -1;
    #5 A = -3; B=0;
    #5 $finish;
end

endmodule
