module top #(
    parameter WORD_LENGTH = 21,
    parameter N_ITERATIONS = 17
)(
    input clk,
    input rst,
    input [31:0] in,
    output [31:0] out
);

// connections
wire signed [WORD_LENGTH-1:0] cordic_i;
wire signed [WORD_LENGTH-1:0] cordic_o;

fp_to_fixed floating_to_fixed (
    .in(in),
    .out(cordic_i)
);

cordic_top cordic_block (
    .clk(clk),
    .rst(rst),
    .in(cordic_i),
    .out(cordic_o)
);

fixed_to_fp fixed_to_floating (
    .in(cordic_o),
    .out(out)
);

endmodule;
