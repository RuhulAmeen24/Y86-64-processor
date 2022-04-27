`include "ALU/alu/alu.v"

module execute (
    input clk,
    input [3:0] E_icode,
    input [3:0] E_ifun,
    input [63:0] E_valA,
    input [63:0] E_valB,
    input [63:0] E_valC,

    output reg ZF,
    output reg SF,
    output reg OF,
    output reg e_Cnd,
    output reg [63:0] e_valE
);

always @(*) begin

    if (E_icode==4'b0110 && clk==1) begin
        ZF=(out==0);
        SF=(out<0);
        OF=(A<0==B<0)&&(out<0!=A<0);
    end
end

initial begin
    ZF=0;
    SF=0;
    OF=0; 
    e_Cnd=0;
end



reg [1:0] control_input;
reg signed [63:0] A;
reg signed [63:0] B;
wire signed [63:0] out;
wire overfow;
reg signed [63:0] out_last;
alu64bit ALU1(
    control_input,
    A,
    B,
    out,
    overflow
);


initial begin
    control_input=0;
    A=64'd0;
    B=64'd0;
end

always @(*)
begin
    if (clk==1) begin
        case (E_icode)
            4'b0010:begin
                case(E_ifun)
                    4'b0000:begin//rrmovq
                        e_Cnd=1;
                    end
                    4'b0001:begin//cmovle
                        if((SF^OF)|ZF)
                        begin
                            e_Cnd=1;
                        end
                    end
                    4'b0010:begin//cmovl
                        if ((SF^OF)) begin
                            e_Cnd=1;
                        end
                    end
                    4'b0011:begin//cmove
                        if (ZF) begin
                            e_Cnd=1;
                        end
                    end
                    4'b0100:begin//cmovne
                        if (~ZF) begin
                            e_Cnd=1;
                        end
                    end
                    4'b0101:begin//cmovge
                        if ((~(SF^OF))) begin
                            e_Cnd=1;
                        end
                    end
                    4'b0110:begin//cmovg
                        if ((~(SF^OF))&(~ZF)) begin
                            e_Cnd=1;
                        end
                    end
                endcase
                /* e_valE=E_valA+E_valB; */
                A = E_valA;
                B = E_valB;
                control_input = 0;
            end
            4'b0011:begin//irmovq
                /* e_valE=E_valC+E_valB; */
                A = E_valC;
                B = E_valB;
                control_input = 0;
            end
            4'b0100:begin//rmmovq
                /* e_valE=E_valC+E_valB; */
                A = E_valC;
                B = E_valB;
                control_input = 0;
            end
            4'b0101:begin//mrmovq
                /* e_valE=E_valC+E_valB; */
                A = E_valC;
                B = E_valB;
                control_input = 0;
            end
            4'b0110:begin

                case (E_ifun)
                    4'b0000:begin//addq
                        A=E_valA;
                        B=E_valB;
                        control_input=0;

                    end
                    4'b0001:begin//subq
                        A=E_valA;
                        B=E_valB;
                        control_input=1;
                    end
                    4'b0010:begin//andq
                        A=E_valA;
                        B=E_valB;
                        control_input=2;
                    end
                    4'b0011:begin//xorq
                        A=E_valA;
                        B=E_valB;
                        control_input=3;
                    end
                endcase
                assign out_last=out;
                e_valE=out_last;
            end
            4'b0111:begin
                case(E_ifun)
                    4'b0000:begin//jmp
                        e_Cnd=1;
                    end
                    4'b0001:begin//jle
                        if((SF^OF)|ZF)
                        begin
                            e_Cnd=1;
                        end
                    end
                    4'b0010:begin//jl
                        if ((SF^OF)) begin
                            e_Cnd=1;
                        end
                    end
                    4'b0011:begin//je
                        if (ZF) begin
                            e_Cnd=1;
                        end
                    end
                    4'b0100:begin//jne
                        if (~ZF) begin
                            e_Cnd=1;
                        end
                    end
                    4'b0101:begin//jge
                        if ((~(SF^OF))) begin
                            e_Cnd=1;
                        end
                    end
                    4'b0110:begin//jg
                        if ((~(SF^OF))&(~ZF)) begin
                            e_Cnd=1;
                        end
                    end
                endcase
            end
            4'b1000:begin//call
                e_valE=E_valB+(-64'd8);
            end
            4'b1001:begin//ret
                e_valE=E_valB+64'd8;
            end
            4'b1010:begin//pushq
                e_valE=E_valB+(-64'd8);
            end
            4'b1011:begin//popq
                e_valE=E_valB+64'd8;
            end

        endcase
    end

end

endmodule
