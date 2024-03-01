module top (
    input clk,
    input [31:0] count,
    output reg [31:0] inc
);
    always @(posedge clk) begin
       inc <= count + 1;
    end

endmodule;

