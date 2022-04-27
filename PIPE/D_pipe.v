`timescale 1ns / 1ps

module D_pipe (
    input clk,
    input [2:0] f_stat,
    input [3:0] f_icode,
    input [3:0] f_ifun,
    input [3:0] f_rA,
    input [3:0] f_rB,
    input [63:0] f_valC,
    input [63:0] f_valP,
    input D_stall,
    input D_bubble,

    output reg [2:0] D_stat,
    output reg [3:0] D_icode,
    output reg [3:0] D_ifun,
    output reg [3:0] D_rA,
    output reg [3:0] D_rB,
    output reg [63:0] D_valC,
    output reg [63:0] D_valP
);

always @ (posedge clk)
begin
    if (D_stall == 0)
    begin
        if (D_bubble == 0)
        begin
            D_stat <= f_stat;
            D_icode <= f_icode;
            D_ifun <= f_ifun;
            D_rA <= f_rA;
            D_rB <= f_rB;
            D_valC <= f_valC;
            D_valP <= f_valP;
        end

        else
            D_stat <= f_stat; // check
            D_icode <= 4'b0001;
            D_ifun <= 4'b0000;
            // The next values doesn't matter
            /* D_rA <= f_rA; */
            /* D_rB <= f_rB; */
            /* D_valC <= f_valC; */
            /* D_valP <= f_valP; */
        begin
        end
    end
end

endmodule
