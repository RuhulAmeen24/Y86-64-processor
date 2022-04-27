module decode (
    input Clk,
    input [3:0] icode,
    input [3:0] ifun,
    input [3:0] rA,
    input [3:0] rB,
    input [959:0] regis,
    input [63:0] valP,
    output reg [3:0] srcA,
    output reg [3:0] srcB,
    output reg [3:0] dstE,
    output reg [3:0] dstM,
    output reg [63:0] valA,
    output reg [63:0] valB
);

reg [63:0] registers[0:14];

always @(posedge Clk) begin
    //$readmemb("register.txt",registers);
    registers[0]=regis[63:0];
    registers[1]=regis[127:64];
    registers[2]=regis[191:128];
    registers[3]=regis[255:192];
    registers[4]=regis[319:256];
    registers[5]=regis[383:320];
    registers[6]=regis[447:384];
    registers[7]=regis[511:448];
    registers[8]=regis[575:512];
    registers[9]=regis[639:576];
    registers[10]=regis[703:640];
    registers[11]=regis[767:704];
    registers[12]=regis[831:768];
    registers[13]=regis[895:832];
    registers[14]=regis[959:896];
    valA=0;
    valB=0;
    srcA=15;
    srcB=15;
    dstE=15;
    dstM=15;

    case (icode)

        2: begin //cmovXX
            srcA=rA;
            dstE=rB;
            // valA=registers[rA];
            // valB=0;
        end

        3: begin //irmovq
            // valB=0;
            dstE=rB;
        end

        4: begin //rmmovq
            srcA=rA;
            srcB=rB;

            // valA=registers[rA];
            // valB=registers[rB];
        end

        5: begin //mrmovq
            srcB=rB;
            dstM=rA;
            // valB=registers[rB];
        end

        6: begin //OPq
            srcA=rA;
            srcB=rB;
            dstE=rB;
            // valA=registers[ rA];
            // valB=registers[rB];
        end

        8: begin //call
            srcB=4;
            dstE=4;
            // valB=registers[4];
        end

        9: begin //ret
            srcA=4;
            srcB=4;
            dstE=4;
            // valA=registers[4];
            // valB=registers[4];
        end

        10: begin //pushq
            srcA=rA;
            srcB=4;
            dstE=4;
            // valA=registers[ rA];
            // valB=registers[4];
        end

        11: begin //popq
            srcA=4;
            srcB=4;
            dstE=4;
            dstM=rA;
            // valA=registers[4];
            // valB=registers[4];
        end

    endcase
    if(srcA<15)
    begin
        valA=registers[srcA];
    end

    if (srcB<15) begin
        valB=registers[srcB];
    end

    if (icode == 8)
    begin
        valA = valP;
    end
end


    
endmodule