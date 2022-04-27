module and64bit_tb;

reg signed [63:0] A, B;
wire signed [63:0] out;

and64bit AND64 (
    .A(A),
    .B(B),
    .out(out)
);

initial
begin
    $dumpfile ("and64bit.vcd");
    $dumpvars (0, and64bit_tb);
    $monitor($time, " A = %d, B = %d, Out = %d\n", A, B, out);
    #5 A = -9223372036854775808; B = 1;
    #5 A = 9223372036854775807; B = -1;
    #5 A = 28746872; B=-823817;
    #5 A = 4; B= 12;
    #5 A = 714278; B=13211;
    #5 $finish;
end

endmodule
