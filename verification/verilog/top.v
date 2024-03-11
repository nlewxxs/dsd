module top (
    input clk,
    input rst,
    input [31:0] in,
    output [31:0] out
);

// connections
wire in_sign;
wire in_int;
wire [18:0] in_frac;

wire out_sign;
wire out_int;
wire [18:0] out_frac;

fp_to_fixed floating_to_fixed (
    .fp_i(in),
    .sign_o(in_sign),
    .integer_o(in_int),
    .fractional_o(in_frac)
);

cordic cordic_block (
    .clk(clk),
    .rst(rst),
    .sign_i(in_sign),
    .sign_o(out_sign),
    .integer_i(in_int),
    .integer_o(out_int),
    .fractional_i(in_frac),
    .fractional_o(out_frac)
);

fixed_to_fp fixed_to_floating (
    .sign_i(out_sign),
    .integer_i(out_int),
    .fractional_i(out_frac),
    .fp_o(out)
);

endmodule;
