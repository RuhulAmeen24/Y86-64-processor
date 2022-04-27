module  memory_tb;
    reg Clk;
    reg [63:0] PC;
    wire [3:0] icode, ifun, rA, rB;
    wire [63:0] valC, valP, valA, valB, valE, valM;
    wire instr_valid, cnd, ZF,SF,OF;

    fetch fetch2(
        .Clk(Clk),
        .PC(PC),
        .icode(icode),
        .ifun(ifun),
        .rA(rA),
        .rB(rB),
        .valC(valC),
        .valP(valP),
        .instr_valid(instr_valid)
    );

    decode decode1(
        .Clk(Clk),
        .icode(icode),
        .ifun(ifun),
        .rA(rA),
        .rB(rB),
        .valA(valA),
        .valB(valB)
    );

    execute execute1(
        .Clk(Clk),
        .icode(icode),
        .ifun(ifun),
        .valA(valA),
        .valB(valB),
        .valC(valC),
        .ZF(ZF),
        .SF(SF),
        .OF(OF),
        .cnd(cnd),
        .valE(valE)
    );

    memory memory1(
        .Clk(Clk),
        .icode(icode),
        .valA(valA),
        .valE(valE),
        .valP(valP),
        .valM(valM)
    );

    initial begin
        $monitor($time,"icode=%b,ifun=%b,valA=%d,valB=%d,valC=%d,cnd=%b, valE=%d, valM=%d",icode, ifun,valA, valB, valC,cnd,valE,valM);
        #5  PC=0;
        Clk=1;

        #5  PC=0;
        #5  PC=0;
        #5  PC=0;
        #5 $finish;
    end
endmodule