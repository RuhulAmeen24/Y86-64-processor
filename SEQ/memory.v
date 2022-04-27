module memory (
    input Clk,
    input [3:0] icode,
    input [63:0] valA,
    input [63:0] valE,
    input [63:0] valP,
    output reg [63:0] valM,
    output reg [63:0] dat_dest
);

reg [63:0] data[0:1023];

initial begin
    $readmemb("data.txt",data);
    dat_dest=1024;
end

always @(*) begin
    case (icode)
        4: begin //rmmovq
            data[valE]=valA;
            dat_dest=valE;
        end

        5: begin
            valM=data[valE];
        end

        8: begin
            data[valE]=valP;
            dat_dest=valE;
        end

        9: begin
            valM=data[valA];
        end

        10: begin
            data[valE]=valA;
            dat_dest=valE;
        end

        11: begin
            valM=data[valA];
        end
    endcase
end
    
endmodule