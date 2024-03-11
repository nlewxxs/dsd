module top (
    input [31:0] in,
    output sign_out,
    output int_out, // only one bit needed due to specs
    output [18:0] frac_out,
    output [31:0] fp_out
);

fp_to_fixed fp_converter (
    .fp_i(in),
    .sign_o(sign_out),
    .fractional_o(frac_out),
    .integer_o(int_out)
);

fixed_to_fp fixed_converter (
    .sign_i(sign_out),
    .integer_i(int_out),
    .fractional_i(frac_out),
    .fp_o(fp_out)
);

endmodule;

