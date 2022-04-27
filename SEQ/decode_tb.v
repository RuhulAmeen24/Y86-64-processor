module  decode_tb;
    reg Clk;
    reg [63:0] PC;
    wire [3:0] icode, ifun, rA, rB, srcA, srcB, dstE, dstM;
    wire [63:0] valC, valP, valA, valB, valE, valM, dat_dest, new_PC;
    wire instr_valid, cnd, ZF,SF,OF;
    reg [959:0] regis;
    reg [63:0] registers[0:14];
    reg [63:0] data[0:1023];
    wire [959:0] regis_n;
    initial begin
        $readmemb("register.txt",registers);
        regis={registers[14],registers[13],registers[12],registers[11],registers[10],registers[9],registers[8],registers[7],registers[6],registers[5],registers[4],registers[3],registers[2],registers[1],registers[0]};
        //regis_n=regis;
    end
    always @(*) begin
        regis={registers[14],registers[13],registers[12],registers[11],registers[10],registers[9],registers[8],registers[7],registers[6],registers[5],registers[4],registers[3],registers[2],registers[1],registers[0]};
    end
    always @(negedge Clk) 
    begin
        if (dstM<15) begin
            registers[dstM]=valM;
        end
        if (dstE<15) begin
            registers[dstE]=valE;
        end

        
        //regis=regis_n;
        // regis=regis_n;
        //$display("%d",regis[127:64]);
    end

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
        .regis(regis),
        .valP(valP),
        .srcA(srcA),
        .srcB(srcB),
        .dstE(dstE),
        .dstM(dstM),
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

    writeback writeback1(
        .Clk(Clk),
        .icode(icode),
        .ifun(ifun),
        .rA(rA),
        .rB(rB),
        .valE(valE),
        .valM(valM),
        .regis(regis),
        .regis_n(regis_n)
    );

    PC_update PC_update1(
        .Clk(Clk),
        .icode(icode),
        .cnd(cnd),
        .valC(valC),
        .valP(valP),
        .valM(valM),
        .new_PC(new_PC)
    );

    initial begin
        PC=0; Clk=0;
        $monitor($time,"icode=%b,ifun=%b,rA=%b,rB=%b,valA=%d,valB=%d, valE=%d, valP=%d",icode, ifun, rA, rB,valA, valB, valE, valP);
        #10  PC=new_PC; Clk=1;
        $monitor($time,"icode=%b,ifun=%b,rA=%b,rB=%b,valA=%d,valB=%d, valE=%d, valP=%d",icode, ifun, rA, rB,valA, valB, valE, valP);
        #10  PC=new_PC; Clk=0;
        $monitor($time,"icode=%b,ifun=%b,rA=%b,rB=%b,valA=%d,valB=%d, valE=%d, valP=%d",icode, ifun, rA, rB,valA, valB, valE, valP);
        #10  PC=new_PC; Clk=1;
        $monitor($time,"icode=%b,ifun=%b,rA=%b,rB=%b,valA=%d,valB=%d, valE=%d, valP=%d",icode, ifun, rA, rB,valA, valB, valE, valP);
        #10  PC=new_PC; Clk=0;
        $monitor($time,"icode=%b,ifun=%b,rA=%b,rB=%b,valA=%d,valB=%d, valE=%d, valP=%d",icode, ifun, rA, rB,valA, valB, valE, valP);
        #10  PC=new_PC; Clk=1;
        $monitor($time,"icode=%b,ifun=%b,rA=%b,rB=%b,valA=%d,valB=%d, valE=%d, valP=%d",icode, ifun, rA, rB,valA, valB, valE, valP);
        #10  PC=new_PC; Clk=0;
        $monitor($time,"icode=%b,ifun=%b,rA=%b,rB=%b,valA=%d,valB=%d, valE=%d, valP=%d",icode, ifun, rA, rB,valA, valB, valE, valP);
        #10  PC=new_PC; Clk=1;
        $monitor($time,"icode=%b,ifun=%b,rA=%b,rB=%b,valA=%d,valB=%d, valE=%d, valP=%d",icode, ifun, rA, rB,valA, valB, valE, valP);
        #10  PC=new_PC; Clk=0;
        #10 $finish;
    end
endmodule