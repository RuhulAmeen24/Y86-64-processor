module writeback (
    input clk,
    input [3:0] W_icode,
    input [3:0] W_ifun,
    input [63:0] W_valE,
    input [63:0] W_valM,
    input [3:0] W_dstE,
    input [3:0] W_dstM,
    input [959:0] regis
);

reg [63:0] registers[0:14];
// always @(*) begin
//     $readmemb("register.txt",registers);
// end


always @(negedge clk) begin
    registers[14]=regis[63:0];
    registers[13]=regis[127:64];
    registers[12]=regis[191:128];
    registers[11]=regis[255:192];
    registers[10]=regis[319:256];
    registers[9]=regis[383:320];
    registers[8]=regis[447:384];
    registers[7]=regis[511:448];
    registers[6]=regis[575:512];
    registers[5]=regis[639:576];
    registers[4]=regis[703:640];
    registers[3]=regis[767:704];
    registers[2]=regis[831:768];
    registers[1]=regis[895:832];
    registers[0]=regis[959:896];
    if (W_dstE<15) begin
        registers[W_dstE]=W_valE;
    end
    if (W_dstM<15) begin
        registers[W_dstM]=W_valM;
    end
    $writememb("register_s.txt",registers);
end

endmodule
