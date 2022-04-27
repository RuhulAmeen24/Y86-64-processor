`timescale 1ns / 1ps

module F_pipe (
    input clk,
    input [63:0] f_predPC,
    input F_stall,

    output reg [63:0] F_predPC
);

always @ (posedge clk)
begin
    if (F_stall == 0)
    begin
        F_predPC <= f_predPC;
    end
end

endmodule
