module top (
    input clk,
    input [31:0] in,
    output sign_out,
    output int_out, // only one bit needed due to specs
    output [22:0] frac_out
);

fp_to_fixed fp_converter (
    .clk(clk),
    .fp_i(in),
    .sign_o(sign_out),
    .fractional_o(frac_out),
    .integer_o(int_out)
);

endmodule;

