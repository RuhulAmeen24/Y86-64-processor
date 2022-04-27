`include "ALU/alu/alu.v"

module execute (
    input Clk,
    input [3:0] icode,
    input [3:0] ifun,
    input [63:0] valA,
    input [63:0] valB,
    input [63:0] valC,
    output reg ZF,
    output reg SF,
    output reg OF,
    output reg cnd,
    output reg [63:0] valE
);

always @(*) begin

    if (icode==4'b0110 && Clk==1) begin
        ZF=(out==0);
        SF=(out<0);
        OF=(A<0==B<0)&&(out<0!=A<0);
    end
end

initial begin
    ZF=0;
    SF=0;
    OF=0;
    cnd=0;
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
    if (Clk==1) begin
        case (icode)
            4'b0010:begin
                case(ifun)
                    4'b0000:begin//rrmovq
                        cnd=1;
                    end
                    4'b0001:begin//cmovle
                        if((SF^OF)|ZF)
                        begin
                            cnd=1;
                        end
                    end
                    4'b0010:begin//cmovl
                        if ((SF^OF)) begin
                            cnd=1;
                        end
                    end
                    4'b0011:begin//cmove
                        if (ZF) begin
                            cnd=1;
                        end
                    end
                    4'b0100:begin//cmovne
                        if (~ZF) begin
                            cnd=1;
                        end
                    end
                    4'b0101:begin//cmovge
                        if ((~(SF^OF))) begin
                            cnd=1;
                        end
                    end
                    4'b0110:begin//cmovg
                        if ((~(SF^OF))&(~ZF)) begin
                            cnd=1;
                        end
                    end
                endcase
                valE=valA+valB;
            end
            4'b0011:begin//irmovq
                valE=valC+valB;
            end
            4'b0100:begin//rmmovq
                valE=valC+valB;
            end
            4'b0101:begin//mrmovq
                valE=valC+valB;
            end
            4'b0110:begin

                case (ifun)
                    4'b0000:begin//addq
                        A=valA;
                        B=valB;
                        control_input=0;

                    end
                    4'b0001:begin//subq
                        A=valA;
                        B=valB;
                        control_input=1;
                    end
                    4'b0010:begin//andq
                        A=valA;
                        B=valB;
                        control_input=2;
                    end
                    4'b0011:begin//xorq
                        A=valA;
                        B=valB;
                        control_input=3;
                    end
                endcase
                assign out_last=out;
                valE=out_last;
            end
            4'b0111:begin
                case(ifun)
                    4'b0000:begin//jmp
                        cnd=1;
                    end
                    4'b0001:begin//jle
                        if((SF^OF)|ZF)
                        begin
                            cnd=1;
                        end
                    end
                    4'b0010:begin//jl
                        if ((SF^OF)) begin
                            cnd=1;
                        end
                    end
                    4'b0011:begin//je
                        if (ZF) begin
                            cnd=1;
                        end
                    end
                    4'b0100:begin//jne
                        if (~ZF) begin
                            cnd=1;
                        end
                    end
                    4'b0101:begin//jge
                        if ((~(SF^OF))) begin
                            cnd=1;
                        end
                    end
                    4'b0110:begin//jg
                        if ((~(SF^OF))&(~ZF)) begin
                            cnd=1;
                        end
                    end
                endcase
            end
            4'b1000:begin//call
                valE=valB+(-64'd8);
            end
            4'b1001:begin//ret
                valE=valB+64'd8;
            end
            4'b1010:begin//pushq
                valE=valB+(-64'd8);
            end
            4'b1011:begin//popq
                valE=valB+64'd8;
            end

        endcase
    end

end

endmodule