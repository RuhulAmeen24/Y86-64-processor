`timescale 1ns / 1ps

module M_pipe (
    input clk,
    input [2:0] e_stat,
    input [3:0] e_icode,
    input e_Cnd,
    input [63:0] e_valE,
    input [63:0] e_valA,
    input [3:0] e_dstE,
    input [3:0] e_dstM,
    input M_bubble,

    output reg [2:0] M_stat,
    output reg [3:0] M_icode,
    output reg M_Cnd,
    output reg [63:0] M_valE,
    output reg [63:0] M_valA,
    output reg [3:0] M_dstE,
    output reg [3:0] M_dstM
);

always @ (posedge clk)
begin
    if (M_bubble == 0)
    begin
        M_stat <= e_stat;
        M_icode <= e_icode;
        M_Cnd <= e_Cnd;
        M_valE <= e_valE;
        M_valA <= e_valA;
        M_dstE <= e_dstE;
        M_dstM <= e_dstM;
    end

    else
    begin
        M_stat <= e_stat;
        M_icode <= 4'b0001;
        M_Cnd <= e_Cnd;
        M_valE <= e_valE;
        M_valA <= e_valA;
        M_dstE <= e_dstE;
        M_dstM <= e_dstM;
    end
end

endmodule
