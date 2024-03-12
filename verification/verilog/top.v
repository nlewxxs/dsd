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
wire in_sign;
wire in_int;
wire [18:0] in_frac;

reg [WORD_LENGTH-1:0] cordic_in;
wire [WORD_LENGTH-1:0] cordic_out;

reg out_sign; // result sign
reg out_int;  // integer part of result
reg [WORD_LENGTH-3:0] out_fr; // fractional part of result

assign cordic_in = {in_sign, in_int, in_frac};
assign out_sign = cordic_out[WORD_LENGTH-1];
assign out_int = cordic_out[WORD_LENGTH-2];
assign out_fr = cordic_out[WORD_LENGTH-3:0];

fp_to_fixed floating_to_fixed (
    .fp_i(in),
    .sign_o(in_sign),
    .integer_o(in_int),
    .fractional_o(in_frac)
);

cordic_top cordic_block (
    .clk(clk),
    .rst(rst),
    .in(cordic_in),
    .out(cordic_out)
);

fixed_to_fp fixed_to_floating (
    .sign_i(out_sign),
    .integer_i(out_int),
    .fractional_i(out_fr),
    .fp_o(out)
);

endmodule;
