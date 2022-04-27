module sub_tb;
  reg signed [63:0] A;
  reg signed [63:0] B;
  wire signed [63:0] ans;
  wire overflow;

  sub64bit SUB1(
    .A(A),
    .B(B),
    .ans(ans),
    .overflow(overflow)
  );

  initial
  begin
    $dumpfile("sub64bit.vcd");
    $dumpvars(0,sub_tb);
    $monitor($time, " a = %d b = %d ans = %d overflow = %d\n", A, B, ans, overflow);
    #5 A = -9223372036854775808; B = 1;
    #5 A = 9223372036854775807; B = -1;
    #5 A = 69; B = 420;
    #5 A = 43364756; B= -666;
    #5 A = -11892789183; B= 68753675;
    #5 $finish;
    end

endmodule
