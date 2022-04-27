`timescale 1ns / 1ps

module W_pipe (
    input clk,
    input [2:0] m_stat,
    input [3:0] m_icode,
    input [63:0] m_valE,
    input [63:0] m_valM,
    input [3:0] m_dstE,
    input [3:0] m_dstM,
    input W_stall,

    output reg [2:0] W_stat,
    output reg [3:0] W_icode,
    output reg [63:0] W_valE,
    output reg [63:0] W_valM,
    output reg [3:0] W_dstE,
    output reg [3:0] W_dstM
);

always @ (posedge clk)
begin
    if (W_stall == 0)
    begin
        W_stat <= m_stat;
        W_icode <= m_icode;
        W_valE <= m_valE;
        W_valM <= m_valM;
        W_dstE <= m_dstE;
        W_dstM <= m_dstM;
    end
end

endmodule
