`timescale 1ns / 1ps

`include "fetch.v"
`include "decode.v"
`include "execute.v"
`include "memory.v"
`include "writeback.v"
`include "F_pipe.v"
`include "D_pipe.v"
`include "E_pipe.v"
`include "M_pipe.v"
`include "W_pipe.v"

module pipelined_processor;

reg clk;
/* reg [63:0] f_pc; */
reg [63:0] PC;

wire [63:0] f_pc;

reg [2:0] stat; // check

wire [63:0] F_predPC;
wire [63:0] f_predPC;

wire [3:0] f_icode;
wire [3:0] D_icode;
wire [3:0] d_icode;
wire [3:0] E_icode;
wire [3:0] e_icode;
wire [3:0] M_icode;
wire [3:0] m_icode;
wire [3:0] W_icode;

wire [3:0] f_ifun;
wire [3:0] D_ifun;
wire [3:0] d_ifun;
wire [3:0] E_ifun;
wire [3:0] e_ifun;
wire [3:0] M_ifun;
wire [3:0] m_ifun;
wire [3:0] W_ifun;

wire [2:0] f_stat;
wire [2:0] D_stat;
wire [2:0] d_stat;
wire [2:0] E_stat;
wire [2:0] e_stat;
wire [2:0] M_stat;
wire [2:0] m_stat;
wire [2:0] W_stat;

wire [3:0] f_rA;
wire [3:0] D_rA;
/* wire [3:0] d_rA; */

wire [3:0] f_rB;
wire [3:0] D_rB;

wire [63:0] f_valC;
wire [63:0] D_valC;
wire [63:0] d_valC;
wire [63:0] E_valC;
/* wire [63:0] e_valC; */

wire [63:0] f_valP;
wire [63:0] D_valP;
/* wire [63:0] d_valP; */

wire [63:0] d_valA;
wire [63:0] E_valA;
wire [63:0] e_valA;
wire [63:0] M_valA;

wire [63:0] d_valB;
wire [63:0] E_valB;

wire [3:0] d_dstE;
wire [3:0] E_dstE;
wire [3:0] e_dstE;
wire [3:0] M_dstE;
wire [3:0] m_dstE;
wire [3:0] W_dstE;

wire [3:0] d_dstM;
wire [3:0] E_dstM;
wire [3:0] e_dstM;
wire [3:0] M_dstM;
wire [3:0] m_dstM;
wire [3:0] W_dstM;

wire [3:0] d_srcA;
wire [3:0] E_srcA;

wire [3:0] d_srcB;
wire [3:0] E_srcB;

wire e_Cnd;
wire M_Cnd;

wire [63:0] e_valE;
wire [63:0] M_valE;
wire [63:0] m_valE;
wire [63:0] W_valE;

wire [63:0] m_valM;
wire [63:0] W_valM;

wire [959:0] regis;

wire SF;
wire ZF;
wire OF;

F_pipe F_pipe1 (
    .clk(clk),
    .f_predPC(f_predPC),

    .F_predPC(F_predPC)
);

fetch fetch1 (
    .clk(clk),
    /* .f_pc(f_pc), */
    .PC(PC),

    .f_icode(f_icode),
    .f_ifun(f_ifun),
    .f_rA(f_rA),
    .f_rB(f_rB),
    .f_valC(f_valC),
    .f_valP(f_valP),
    .f_instr_valid(f_instr_valid),
    .f_hlt(f_hlt)
);

select_PC select_PC1 (
    .clk(clk),
    .M_icode(M_icode),
    .M_Cnd(M_Cnd),
    .M_valA(M_valA),
    .W_icode(W_icode),
    .W_valM(W_valM),
    .F_predPC(F_predPC),

    .f_pc(f_pc)
);

predict_PC predict_PC1 (
    .clk(clk),
    .f_icode(f_icode),
    .f_valC(f_valC),
    .f_valP(f_valP),

    .f_predPC(f_predPC)
);

D_pipe D_pipe1 (
    .clk(clk),
    .f_stat(f_stat),
    .f_icode(f_icode),
    .f_ifun(f_ifun),
    .f_rA(f_rA),
    .f_rB(f_rB),
    .f_valC(f_valC),
    .f_valP(f_valP),

    .D_stat(D_stat),
    .D_icode(D_icode),
    .D_ifun(D_ifun),
    .D_rA(D_rA),
    .D_rB(D_rB),
    .D_valC(D_valC),
    .D_valP(D_valP)
);

decode decode1 (
    .clk(clk),
    .D_icode(D_icode),
    .D_ifun(D_ifun),
    .D_rA(D_rA),
    .D_rB(D_rB),
    .D_valP(D_valP),

    .d_srcA(d_srcA),
    .d_srcB(d_srcB),
    .d_dstE(d_dstE),
    .d_dstM(d_dstM),

    .d_valA(d_valA),
    .d_valB(d_valB),
    .regis(regis)
);

E_pipe E_pipe1 (
    .clk(clk),
    .d_stat(d_stat),
    .d_icode(d_icode),
    .d_ifun(d_ifun),
    .d_valC(d_valC),
    .d_valA(d_valA),
    .d_valB(d_valB),
    .d_dstE(d_dstE),
    .d_dstM(d_dstM),
    .d_srcA(d_srcA),
    .d_srcB(d_srcB),

    .E_stat(E_stat),
    .E_icode(E_icode),
    .E_ifun(E_ifun),
    .E_valC(E_valC),
    .E_valA(E_valA),
    .E_valB(E_valB),
    .E_dstE(E_dstE),
    .E_dstM(E_dstM),
    .E_srcA(E_srcA),
    .E_srcB(E_srcB)
);

execute execute1 (
    .clk(clk),
    .E_icode(E_icode),
    .E_ifun(E_ifun),
    .E_valA(E_valA),
    .E_valB(E_valB),
    .E_valC(E_valC),

    .ZF(ZF),
    .SF(SF),
    .OF(OF),
    .e_Cnd(e_Cnd),
    .e_valE(e_valE)
);

M_pipe M_pipe1 (
    .clk(clk),
    .e_stat(e_stat),
    .e_icode(e_icode),
    .e_Cnd(e_Cnd),
    .e_valE(e_valE),
    .e_valA(e_valA),
    .e_dstE(e_dstE),
    .e_dstM(e_dstM),

    .M_stat(M_stat),
    .M_icode(M_icode),
    .M_Cnd(M_Cnd),
    .M_valE(M_valE),
    .M_valA(M_valA),
    .M_dstE(M_dstE),
    .M_dstM(M_dstM)
);

memory memory1 (
    .clk(clk),
    .M_icode(M_icode),
    .M_valA(M_valA),
    .M_valE(M_valE),

    .m_valM(m_valM)
);

W_pipe W_pipe1 (
    .clk(clk),
    .m_stat(m_stat),
    .m_icode(m_icode),
    .m_valE(m_valE),
    .m_valM(m_valM),
    .m_dstE(m_dstE),
    .m_dstM(m_dstM),

    .W_stat(W_stat),
    .W_icode(W_icode),
    .W_valE(W_valE),
    .W_valM(W_valM),
    .W_dstE(W_dstE),
    .W_dstM(W_dstM)
);

writeback writeback1 (
    .clk(clk),
    .W_icode(W_icode),
    .W_ifun(W_ifun),
    .W_valE(W_valE),
    .W_valM(W_valM),
    .W_dstE(W_dstE),
    .W_dstM(W_dstM),
    .regis(regis)
);

always #5 clk = ~clk;

initial
begin
    stat[0] = 1;
    stat[1] = 0;
    stat[2] = 0;

    clk = 0;
    PC = 64'd0;
end

always @ (*)
begin
    PC = f_pc;

    if (f_hlt)
    begin
        stat[2] = f_hlt;
        stat[1] = 1'b0;
        stat[0] = 1'b0;
    end
    else if(f_instr_valid==1'b0)
    begin
      stat[1]=f_instr_valid;
      stat[2]=1'b0;
      stat[0]=1'b0;
    end
    else
    begin
      stat[0]=1'b1;
      stat[1]=1'b0;
      stat[2]=1'b0;
    end
  end

  always@(*)
  begin
    if(stat[2]==1'b1)
    begin
      $finish;
    end
end

 initial
    //$monitor("clk=%d 0=%d 1=%d 2=%d 3=%d 4=%d zf=%d sf=%d of=%d",clk,reg_mem0,reg_mem1,reg_mem2,reg_mem3,reg_mem4,zf,sf,of);
    // $monitor("clk=%d halt=%d 0=%d 1=%d 2=%d 3=%d 4=%d",clk,stat[2],reg_mem0,reg_mem1,reg_mem2,reg_mem3,reg_mem4);
		// $monitor("clk=%d icode=%b ifun=%b rA=%b rB=%b valA=%d valB=%d valC=%d valE=%d valM=%d insval=%d memerr=%d cnd=%d halt=%d 0=%d 1=%d 2=%d 3=%d 4=%d 5=%d 6=%d 7=%d 8=%d 9=%d 10=%d 11=%d 12=%d 13=%d 14=%d datamem=%d\n",clk,icode,ifun,rA,rB,valA,valB,valC,valE,valM,instr_valid,imem_error,cnd,stat[2],reg_mem0,reg_mem1,reg_mem2,reg_mem3,reg_mem4,reg_mem5,reg_mem6,reg_mem7,reg_mem8,reg_mem9,reg_mem10,reg_mem11,reg_mem12,reg_mem13,reg_mem14,datamem);
		$monitor("clk=%d f=%d d=%d e=%d m=%d wb=%d",clk,f_icode,D_icode,E_icode,M_icode,W_icode);
endmodule
