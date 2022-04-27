`timescale 1ns / 1ps

module fwd_sel_A (
    input clk, // needed ??
    input [63:0] d_rvalA, // from register file
    input [63:0] e_valE,
    input [63:0] M_valE,
    input [63:0] m_valM,
    input [63:0] W_valM,
    input [63:0] W_valE,

    output [63:0] d_valA
);

always @ (posedge clk) // correct ??
begin
    // forward valE from execute
    if (d_srcA == e_dstE)
    begin
        d_valA = e_valE;
    end

    // forward valM from memory
    else if (d_srcA == M_dstM)
    begin
        d_valA = m_valM;
    end

    // forward valE from memory
    else if (d_srcA == M_dstE)
    begin
        d_valA = M_valE;
    end

    // forward valM from writeback
    else if (d_srcA == W_dstM)
    begin
        d_valA = W_valM;
    end

    // forward valE from writeback
    else if (d_srcA == W_dstE)
    begin
        d_valA = W_valE;
    end

    // else, use the value read from register
    else
    begin
        d_valA = d_rvalA;
    end
end

endmodule

/////////////////////////////////////////////////////

module fwd_sel_B (
    input clk, // needed ??
    input [63:0] d_rvalB, // from register file
    input [63:0] e_valE,
    input [63:0] M_valE,
    input [63:0] m_valM,
    input [63:0] W_valM,
    input [63:0] W_valE,

    output [63:0] d_valB
);

always @ (posedge clk) // correct ??
begin
    // forward valE from execute
    if (d_srcB == e_dstE)
    begin
        d_valB = e_valE;
    end

    // forward valM from memory
    else if (d_srcB == M_dstM)
    begin
        d_valB = m_valM;
    end

    // forward valE from memory
    else if (d_srcB == M_dstE)
    begin
        d_valB = M_valE;
    end

    // forward valM from writeback
    else if (d_srcB == W_dstM)
    begin
        d_valB = W_valM;
    end

    // forward valE from writeback
    else if (d_srcB == W_dstE)
    begin
        d_valB = W_valE;
    end

    // else, use the value read from register
    else
    begin
        d_valB = d_rvalB;
    end
end

endmodule
