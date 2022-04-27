module PC_update (
    input Clk,
    input [3:0] icode,
    input cnd,
    input [63:0] valC,
    input [63:0] valP,
    input [63:0] valM,
    output reg [63:0] new_PC
);

always @(*) begin
    if(cnd==1 && icode==7)
    begin
        new_PC=valC;
    end
    else if(icode==8)
    begin
        new_PC=valC;
    end
    else if(icode==9)
    begin
        new_PC=valM;
    end
    else
    begin
        new_PC=valP;
    end
end
    
endmodule