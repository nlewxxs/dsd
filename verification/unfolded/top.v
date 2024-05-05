module top(
    input clk,
    input rst,
    input [31:0] in,
    output [31:0] out
);
    wire [31:0] x_div_2;
    wire [31:0] x_div_128;

    div_2 divide_2 (
        .in(in),
        .out(x_div_2)
    );

    div_128 divide_128 (
        .in(in),
        .out(x_div_128)
    );

    cordic_unrolled cordic_block (
        .clk(clk),
        .rst(rst),
        .in(in),
        .out(out)
    );









endmodule

