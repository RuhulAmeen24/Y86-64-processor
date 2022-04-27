`timescale 1ns / 1ps

module pipeline_control (
    input clk, // needed??
    input [3:0] D_icode,
    input [3:0] d_srcA,
    input [3:0] d_srcB,
    input [3:0] E_icode,
    input [3:0] E_dstM,
    input e_Cnd,
    input [3:0] M_icode,
    input [2:0] m_stat,
    input [2:0] W_stat,

    output reg F_stall,
    output reg D_stall,
    output reg D_bubble,
    output reg E_bubble,
    output reg set_cc, // no. of bits??
    output reg M_bubble,
    output reg W_stall
);

initial
begin
    F_stall = 0;
    D_stall = 0;
    D_bubble = 0;
    E_bubble = 0;
    M_bubble = 0;
    W_stall = 0;
end

always @ (posedge clk) // correct ??
begin
    // initial pipeline control logic
    F_stall = ((E_icode == 5 || E_icode == 11) && (E_dstM == d_srcA || E_dstM == d_srcB) || (D_icode == 9 || E_icode == 9 || M_icode == 9));
    D_stall = ((E_icode == 5 || E_icode == 11) && (E_dstM == d_srcA || E_dstM == d_srcB));
    D_bubble = ((E_icode == 7 && !e_Cnd) || (D_icode == 9 || E_icode == 9 || M_icode == 9));
    E_bubble = ((E_icode == 7 && !e_Cnd) || (E_icode == 5 || E_icode == 11) && (E_dstM == d_srcA || E_dstM == d_srcB));

    // improved pipeline control logic
    /* D_bubble = ((E_icode == 7 && !e_Cnd) || (D_icode == 9 || E_icode == 9 || M_icode == 9) && !((E_icode == 5 || E_icode == 11) && (E_dstM == d_srcA || E_dstM == d_srcB))); */
end

endmodule
