module  fetch_tb;
    reg Clk;
    reg [63:0] PC;
    wire [3:0] icode, ifun, rA, rB;
    wire [63:0] valC, valP;
    wire instr_valid;

    fetch fetch1(
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

    initial begin
        $monitor($time,"icode=%b,ifun=%b,rA=%b,rB=%b,valC=%d,valP=%d, instr_valid=%b",icode, ifun, rA, rB,valC, valP, instr_valid);
        #5;
        #5  PC=0;
        #5  PC=0;
        #5 $finish;
    end
endmodule