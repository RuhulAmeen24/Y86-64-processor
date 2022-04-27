module add64bit_tb;

reg signed [63:0] A, B;
wire signed [63:0] sum, carry;
wire overflow;

add64bit ADD64 (
    .A(A),
    .B(B),
    .sum(sum),
    .overflow(overflow)
);

initial
begin
    $dumpfile ("add64bit.vcd");
    $dumpvars (0, add64bit_tb);
    $monitor($time, " A = %d, B = %d, sum = %d, overflow = %d\n", A, B, sum, overflow);
    #5 A = 620; B = -34;
    #5 A = 0; B = -1;
    #5 A = 9223372036854775807; B = 1;
    #5 A = -9223372036854775808; B = -1;
    #5 A = -78928; B = 9871486;
    #5 $finish;
end

endmodule

