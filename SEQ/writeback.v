module writeback (
    input Clk,
    input [3:0] icode,
    input [3:0] ifun,
    input [3:0] rA,
    input [3:0] rB,
    input [63:0] valE,
    input [63:0] valM,
    input [959:0] regis,
    output reg [959:0] regis_n
);

reg [63:0] registers[0:14];
// always @(*) begin
//     $readmemb("register.txt",registers);
// end


always @(negedge Clk) begin
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
    case (icode)
        2: begin
            registers[rB]=valE;
        end 

        3: begin
            registers[rB]=valE;
        end 

        5: begin
            registers[rA]=valM;
        end

        6: begin
            registers[rB]=valE;
        end 

        8: begin
            registers[4]=valE;
        end

        9: begin
            registers[4]=valE;
        end

        10: begin
            registers[4]=valE;
        end

        11: begin
            registers[4]=valE;
            registers[rA]=valM;
        end
    endcase
    regis_n={registers[14],registers[13],registers[12],registers[11],registers[10],registers[9],registers[8],registers[7],registers[6],registers[5],registers[4],registers[3],registers[2],registers[1],registers[0]};
    $writememb("register_s.txt",registers);
end

endmodule