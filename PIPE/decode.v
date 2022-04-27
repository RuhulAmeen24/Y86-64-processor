module decode (
    input clk,
    input [3:0] D_icode,
    input [3:0] D_ifun,
    input [3:0] D_rA,
    input [3:0] D_rB,
    input [63:0] D_valP,

    output reg [3:0] d_srcA,
    output reg [3:0] d_srcB,
    output reg [3:0] d_dstE,
    output reg [3:0] d_dstM,

    output reg [63:0] d_valA,
    output reg [63:0] d_valB,
    output reg [959:0] regis
);

reg [63:0] registers[0:14];

always @(posedge clk) begin
    $readmemb("register.txt",registers);
    d_valA=0;
    d_valB=0;
    d_srcA=15;
    d_srcB=15;
    d_dstE=15;
    d_dstM=15;

    case (D_icode)

        2: begin //cmovXX
            d_srcA=D_rA;
            d_dstE=D_rB;
            // valA=registers[rA];
            // valB=0;
        end

        3: begin //irmovq
            // valB=0;
            d_dstE=D_rB;
        end

        4: begin //rmmovq
            d_srcA=D_rA;
            d_srcB=D_rB;

            // valA=registers[rA];
            // valB=registers[rB];
        end

        5: begin //mrmovq
            d_srcB=D_rB;
            d_dstM=D_rA;
            // valB=registers[D_rB];
        end

        6: begin //OPq
            d_srcA=D_rA;
            d_srcB=D_rB;
            d_dstE=D_rB;
            // valA=registers[D_ rA];
            // valB=registers[D_rB];
        end

        8: begin //call
            d_srcB=4;
            d_dstE=4;
            // valB=registers[4];
        end

        9: begin //ret
            d_srcA=4;
            d_srcB=4;
            d_dstE=4;
            // valA=registers[4];
            // valB=registers[4];
        end

        10: begin //pushq
            d_srcA=D_rA;
            d_srcB=4;
            d_dstE=4;
            // valA=registers[D_ rA];
            // valB=registers[4];
        end

        11: begin //popq
            d_srcA=4;
            d_srcB=4;
            d_dstE=4;
            d_dstM=D_rA;
            // valA=registers[4];
            // valB=registers[4];
        end

    endcase
    if(d_srcA<15)
    begin
        d_valA=registers[d_srcA];
    end

    if (d_srcB<15) begin
        d_valB=registers[d_srcB];
    end

    if (D_icode == 8)
    begin
        d_valA = D_valP;
    end
    regis={registers[0],registers[1],registers[2],registers[3],registers[4],registers[5],registers[6],registers[7],registers[8],registers[9],registers[10],registers[11],registers[12],registers[13],registers[14]};
end



endmodule
