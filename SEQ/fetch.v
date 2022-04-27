module fetch (
    input Clk,
    input [63:0] PC,
    output reg [3:0] icode,
    output reg [3:0] ifun,
    output reg [3:0] rA,
    output reg [3:0] rB,
    output reg [63:0] valC,
    output reg [63:0] valP,
    output reg instr_valid
);

reg [79:0] instr;
reg [7:0] instru[0:15];

initial begin
    $readmemb("instr.txt",instru);
    instr={instru[2],instru[3],instru[4],instru[5],instru[6],instru[7],instru[8],instru[9],instru[1],instru[0]};
end



always @(*) 
begin
    icode=instr[7:4];
    ifun=instr[3:0];
    valP=0;
    instr_valid=0;
    case (icode)
        0:begin //halt
            case (ifun)
                0: begin
                    instr_valid=1;
                    valP=PC+1;
                end
            endcase
        end

        1: begin //nop
            case(ifun)
                0: begin
                    instr_valid=1;
                    valP=PC+1;
                end 
            endcase
        end

        2: begin //cmovXX
            valP=PC+2;
            rA=instr[15:12];
            rB=instr[11:8];
            if(ifun < 6 && ifun >=0)
            begin
                instr_valid=1;
            end
        end

        3: begin //irmovq
            case(ifun)
                0: begin
                    instr_valid=1;
                    valP=PC+10;
                    rA=instr[15:12];
                    rB=instr[11:8];
                    valC=instr[79:16];
                end 
            endcase
        end

        4: begin //rmmovq
            case(ifun)
                0: begin
                    instr_valid=1;
                    valP=PC+10;
                    rA=instr[15:12];
                    rB=instr[11:8];
                    valC=instr[79:16];
                end 
            endcase
        end

        5: begin //mrmovq
            case(ifun)
                0: begin
                    instr_valid=1;
                    valP=PC+10;
                    rA=instr[15:12];
                    rB=instr[11:8];
                    valC=instr[79:16];
                end 
            endcase
        end   

        6: begin //OPq
            valP=PC+2;
            rA=instr[15:12];
            rB=instr[11:8];
            if(ifun < 6 && ifun >=0)
            begin
                instr_valid=1;
            end
        end    

        7: begin //jXX
            valP=PC+9;
            valC=instr[71:8];
            if(ifun < 6 && ifun >=0)
            begin
                instr_valid=1;
            end
        end

        8: begin //call
            case(ifun)
                0: begin
                    instr_valid=1;
                    valP=PC+9;
                    valC=instr[71:8];
                end 
            endcase
        end

        9: begin //ret
            case(ifun)
                0: begin
                    instr_valid=1;
                    valP=PC+1;
                end 
            endcase
        end

        10: begin //pushq
            case(ifun)
                0: begin
                    instr_valid=1;
                    valP=PC+2;
                    rA=instr[15:12];
                    rB=instr[11:8];
                end 
            endcase
        end   

        11: begin //popq
            case(ifun)
                0: begin
                    instr_valid=1;
                    valP=PC+2;
                    rA=instr[15:12];
                    rB=instr[11:8];
                end 
            endcase
        end   
    endcase
    if(instr_valid==0)
    begin
        valP=PC+1;
    end
end




endmodule