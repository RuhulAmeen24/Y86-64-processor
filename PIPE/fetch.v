module select_PC (
    input clk,
    input [3:0] M_icode,
    input M_Cnd,
    input [63:0] M_valA,
    input [3:0] W_icode,
    input [63:0] W_valM,
    input [63:0] F_predPC,

    output reg [63:0] f_pc
);



endmodule

///////////////////////////////////////

module fetch (
    input clk,
    /* input [63:0] f_pc, */
    input [63:0] PC,

    output reg [3:0] f_icode,
    output reg [3:0] f_ifun,
    output reg [3:0] f_rA,
    output reg [3:0] f_rB,
    output reg [63:0] f_valC,
    output reg [63:0] f_valP,
    output reg f_instr_valid,
    output reg f_hlt
);

reg [79:0] instr;
reg [7:0] instru[0:15];
reg imem_error;

initial begin
    $readmemb("instr.txt",instru);
    imem_error=0;
    if(PC>1023)
    begin
        imem_error=1;
    end
    instr={instru[PC + 2], instru[PC + 3], instru[PC + 4], instru[PC + 5], instru[PC + 6], instru[PC + 7], instru[PC + 8], instru[PC + 9], instru[PC + 1], instru[PC + 0]};
    
end



always @(*)
begin
    f_icode=instr[7:4];
    f_ifun=instr[3:0];
    f_valP=0;
    f_hlt = 1;
    f_instr_valid=1;
    case (f_icode)
        0:begin //halt
            f_valP = PC + 1;
            f_hlt = 1;
        end

        1: begin //nop
            f_valP = PC + 1;
        end

        2: begin //cmovXX
            f_valP=PC+2;
            f_rA=instr[15:12];
            f_rB=instr[11:8];
        end

        3: begin //irmovq
            f_valP=PC+10;
            f_rA=instr[15:12];
            f_rB=instr[11:8];
            f_valC=instr[79:16];
        end

        4: begin //rmmovq
            f_valP=PC+10;
            f_rA=instr[15:12];
            f_rB=instr[11:8];
            f_valC=instr[79:16];
        end

        5: begin //mrmovq
            f_valP=PC+10;
            f_rA=instr[15:12];
            f_rB=instr[11:8];
            f_valC=instr[79:16];
        end

        6: begin //OPq
            f_valP=PC+2;
            f_rA=instr[15:12];
            f_rB=instr[11:8];
        end

        7: begin //jXX
            f_valP=PC+9;
            f_valC=instr[71:8];
        end

        8: begin //call
            f_valP=PC+9;
            f_valC=instr[71:8];
        end

        9: begin //ret
            f_valP=PC+1;
        end

        10: begin //pushq
            f_valP=PC+2;
            f_rA=instr[15:12];
            f_rB=instr[11:8];
        end

        11: begin //popq
            f_valP=PC+2;
            f_rA=instr[15:12];
            f_rB=instr[11:8];
        end

        default: begin
            f_instr_valid = 0;
        end
    endcase

    if(f_instr_valid==0)
    begin
        f_valP=PC+1;
    end
end

endmodule



module predict_PC (
    input clk, // is this needed?
    input [3:0] f_icode,
    input [63:0] f_valC,
    input [63:0] f_valP,

    output reg [63:0] f_predPC
);

always @ (posedge clk) // not sure what comes in ()
begin
    if (f_icode == 0111 || f_icode == 1000)
    begin
        f_predPC = f_valC;
    end
    else if (f_icode == 1001)
    begin
        f_predPC = f_valP; // what??
        /* f_predPC = f_valP; // is this correct? */
    end
    else
    begin
        f_predPC = f_valP;
    end
end

endmodule
