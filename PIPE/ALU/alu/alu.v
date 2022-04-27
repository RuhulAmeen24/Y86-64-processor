`timescale 1ns / 1ps

`include "ALU/sub/sub.v"
`include "ALU/and/and.v"
`include "ALU/xor/xor.v"

module alu64bit (
    input [1:0] control_input,
    input signed [63:0] A,
    input signed [63:0] B,
    output signed [63:0] out,
    output overflow
);
wire signed [63:0] out_1;
wire signed [63:0] out_2;
wire signed [63:0] out_3;
wire signed [63:0] out_4;
wire overflow_1;
wire overflow_2;
reg signed [63:0] out_last;
reg overflow_last;
add64bit ADD1 (A, B, out_1, overflow_1);
sub64bit SUB1 (A, B, out_2, overflow_2);
and64bit AND1 (A, B, out_3);
xor64bit XOR1 (A, B, out_4);
always @ (*)
begin
    case (control_input)
        0:begin
            out_last=out_1;
            overflow_last=overflow_1;
        end

        1:begin
            out_last=out_2;
            overflow_last=overflow_2;
        end

        2:begin
            out_last=out_3;
            overflow_last=0;
        end

        3:begin
            out_last=out_4;
            overflow_last=0;
        end
    endcase
end

assign out=out_last;
assign overflow=overflow_last;

endmodule
