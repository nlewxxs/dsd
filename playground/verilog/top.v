module top (
    input clk,
    input [31:0] in,
    output [31:0] out
);

fp_to_fixed fp_converter (
    .fp_i(in),
    .fixed_o(out)
);

endmodule;

