module memory (
    input clk,
    input [3:0] M_icode,
    input [63:0] M_valA,
    input [63:0] M_valE,

    output reg [63:0] m_valM
);

reg [63:0] data[0:1023];
reg dmem_error=0;

initial begin
    $readmemb("data.txt",data);
end

always @(*) begin
    case (M_icode)
        4: begin //rmmovq
        if(M_valE>1023)
        begin
            dmem_error=1;
        end
        else
        begin
            data[M_valE]=M_valA;
        end

        end

        5: begin
        if(M_valE>1023)
        begin
            dmem_error=1;
        end
        else
        begin
            m_valM=data[M_valE];
        end
        end

        8: begin
        if(M_valE>1023)
        begin
            dmem_error=1;
        end
        else
        begin
            data[M_valE]=M_valA;
        end
        end

        9: begin
        if(M_valA>1023)
        begin
            dmem_error=1;
        end
        else
        begin
            m_valM=data[M_valA];
        end
        end

        10: begin
        if(M_valE>1023)
        begin
            dmem_error=1;
        end
        else
        begin
            data[M_valE]=M_valA;
        end
        end

        11: begin
        if(M_valA>1023)
        begin
            dmem_error=1;
        end
        else
        begin
            m_valM=data[M_valA];
        end
        end
    endcase
end

endmodule
