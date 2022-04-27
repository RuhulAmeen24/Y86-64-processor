`timescale 1ns / 1ps

module alu64bit_tb;

reg [1:0] control_input;
reg signed [63:0] A;
reg signed [63:0] B;
wire signed [63:0] out;
wire overflow;

alu64bit ALU1 (
    .control_input(control_input),
    .A(A),
    .B(B),
    .out(out),
    .overflow(overflow)
);

initial
    begin
        $dumpfile("alu64bit.vcd");
        $dumpvars(0, alu64bit_tb);
        $monitor("control = %d, A = %d, B = %d, out = %d, overflow = %d\n", control_input, A, B, out, overflow);
        #5 control_input = 0;A = 9223372036854775807; B = 1;
        #5 control_input = 0;A = -9223372036854775808; B = -1;
        #5 control_input = 0;A = -78928; B = 9871486;
        #5 control_input = 1;A = -9223372036854775808; B = 1;
        #5 control_input = 1;A = 9223372036854775807; B = -1;
        #5 control_input = 1;A = 69; B = 420;
        #5 control_input = 2;A = 28746872; B=-823817;
        #5 control_input = 2;A = 4; B= 12;
        #5 control_input = 2;A = 714278; B=13211;
        #5 control_input = 3;A = 27365798; B= -12131445567;
        #5 control_input = 3;A = 3; B = -1;
        #5 control_input = 3;A = -3; B=874316;
        #5 $finish;
    end

endmodule
