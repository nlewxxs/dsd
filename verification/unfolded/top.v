// top module
module top #(
    parameter WORD_LENGTH = 21
)(
    input clk,
    input rst,
    input [31:0] in,    // input value, IEEE-754 format
    output [31:0] out   // output value, IEEE-754 format
);

    // connections
    wire signed [WORD_LENGTH-1:0] z0;           // fixed-point starting angle
    wire signed [WORD_LENGTH-1:0] result;       // fixed-point cordic result
    localparam x0 = 21'b00_1001101101110100111; // 1/K - starting x value
    localparam y0 = 0;                          // 0 - starting y value

    reg signed [WORD_LENGTH-1:0] alphas [N_ITERATIONS-1:0]; // arctan lookup table

    // init LUT
    initial begin
        alphas[0]  = 21'b00_1100100100001111111;    // 0.7853984832763671875
        alphas[1]  = 21'b00_0111011010110001101;    // 0.4636478424072265625
        alphas[2]  = 21'b00_0011111010110110111;    // 0.2449779510498046875
        alphas[3]  = 21'b00_0001111111010101110;    // 0.124355316162109375
        alphas[4]  = 21'b00_0000111111111010101;    // 0.0624179840087890625
        alphas[5]  = 21'b00_0000011111111111011;    // 0.0312404632568359375
        alphas[6]  = 21'b00_0000001111111111111;    // 0.0156230926513671875
        alphas[7]  = 21'b00_0000001000000000000;    // 0.0078125
        alphas[8]  = 21'b00_0000000100000000000;    // 0.00390625
        alphas[9]  = 21'b00_0000000010000000000;    // 0.001953125
        alphas[10] = 21'b00_0000000001000000000;    // 0.0009765625
        alphas[11] = 21'b00_0000000000100000000;    // 0.00048828125
        alphas[12] = 21'b00_0000000000010000000;    // 0.000244140625
        alphas[13] = 21'b00_0000000000001000000;    // 0.0001220703125
        alphas[14] = 21'b00_0000000000000100000;    // 0.00006103515625
        alphas[15] = 21'b00_0000000000000010000;    // 0.000030517578125
        alphas[16] = 21'b00_0000000000000001000;    // 0.0000152587890625
    end

    wire signed [WORD_LENGTH-1:0] x0_o;
    wire signed [WORD_LENGTH-1:0] y0_o;
    wire signed [WORD_LENGTH-1:0] z0_o;

    wire signed [WORD_LENGTH-1:0] x1;
    wire signed [WORD_LENGTH-1:0] y1;
    wire signed [WORD_LENGTH-1:0] z1;
    wire signed [WORD_LENGTH-1:0] x1_o;
    wire signed [WORD_LENGTH-1:0] y1_o;
    wire signed [WORD_LENGTH-1:0] z1_o;

    wire signed [WORD_LENGTH-1:0] x2;
    wire signed [WORD_LENGTH-1:0] y2;
    wire signed [WORD_LENGTH-1:0] z2;
    wire signed [WORD_LENGTH-1:0] x2_o;
    wire signed [WORD_LENGTH-1:0] y2_o;
    wire signed [WORD_LENGTH-1:0] z2_o;

    wire signed [WORD_LENGTH-1:0] x3;
    wire signed [WORD_LENGTH-1:0] y3;
    wire signed [WORD_LENGTH-1:0] z3;
    wire signed [WORD_LENGTH-1:0] x3_o;
    wire signed [WORD_LENGTH-1:0] y3_o;
    wire signed [WORD_LENGTH-1:0] z3_o;

    wire signed [WORD_LENGTH-1:0] x4;
    wire signed [WORD_LENGTH-1:0] y4;
    wire signed [WORD_LENGTH-1:0] z4;
    wire signed [WORD_LENGTH-1:0] x4_o;
    wire signed [WORD_LENGTH-1:0] y4_o;
    wire signed [WORD_LENGTH-1:0] z4_o;

    wire signed [WORD_LENGTH-1:0] x5;
    wire signed [WORD_LENGTH-1:0] y5;
    wire signed [WORD_LENGTH-1:0] z5;
    wire signed [WORD_LENGTH-1:0] x5_o;
    wire signed [WORD_LENGTH-1:0] y5_o;
    wire signed [WORD_LENGTH-1:0] z5_o;

    wire signed [WORD_LENGTH-1:0] x6;
    wire signed [WORD_LENGTH-1:0] y6;
    wire signed [WORD_LENGTH-1:0] z6;
    wire signed [WORD_LENGTH-1:0] x6_o;
    wire signed [WORD_LENGTH-1:0] y6_o;
    wire signed [WORD_LENGTH-1:0] z6_o;

    wire signed [WORD_LENGTH-1:0] x7;
    wire signed [WORD_LENGTH-1:0] y7;
    wire signed [WORD_LENGTH-1:0] z7;
    wire signed [WORD_LENGTH-1:0] x7_o;
    wire signed [WORD_LENGTH-1:0] y7_o;
    wire signed [WORD_LENGTH-1:0] z7_o;

    wire signed [WORD_LENGTH-1:0] x8;
    wire signed [WORD_LENGTH-1:0] y8;
    wire signed [WORD_LENGTH-1:0] z8;
    wire signed [WORD_LENGTH-1:0] x8_o;
    wire signed [WORD_LENGTH-1:0] y8_o;
    wire signed [WORD_LENGTH-1:0] z8_o;

    wire signed [WORD_LENGTH-1:0] x9;
    wire signed [WORD_LENGTH-1:0] y9;
    wire signed [WORD_LENGTH-1:0] z9;
    wire signed [WORD_LENGTH-1:0] x9_o;
    wire signed [WORD_LENGTH-1:0] y9_o;
    wire signed [WORD_LENGTH-1:0] z9_o;

    wire signed [WORD_LENGTH-1:0] x10;
    wire signed [WORD_LENGTH-1:0] y10;
    wire signed [WORD_LENGTH-1:0] z10;
    wire signed [WORD_LENGTH-1:0] x10_o;
    wire signed [WORD_LENGTH-1:0] y10_o;
    wire signed [WORD_LENGTH-1:0] z10_o;

    wire signed [WORD_LENGTH-1:0] x11;
    wire signed [WORD_LENGTH-1:0] y11;
    wire signed [WORD_LENGTH-1:0] z11;
    wire signed [WORD_LENGTH-1:0] x11_o;
    wire signed [WORD_LENGTH-1:0] y11_o;
    wire signed [WORD_LENGTH-1:0] z11_o;

    wire signed [WORD_LENGTH-1:0] x12;
    wire signed [WORD_LENGTH-1:0] y12;
    wire signed [WORD_LENGTH-1:0] z12;
    wire signed [WORD_LENGTH-1:0] x12_o;
    wire signed [WORD_LENGTH-1:0] y12_o;
    wire signed [WORD_LENGTH-1:0] z12_o;

    wire signed [WORD_LENGTH-1:0] x13;
    wire signed [WORD_LENGTH-1:0] y13;
    wire signed [WORD_LENGTH-1:0] z13;
    wire signed [WORD_LENGTH-1:0] x13_o;
    wire signed [WORD_LENGTH-1:0] y13_o;
    wire signed [WORD_LENGTH-1:0] z13_o;

    wire signed [WORD_LENGTH-1:0] x14;
    wire signed [WORD_LENGTH-1:0] y14;
    wire signed [WORD_LENGTH-1:0] z14;
    wire signed [WORD_LENGTH-1:0] x14_o;
    wire signed [WORD_LENGTH-1:0] y14_o;
    wire signed [WORD_LENGTH-1:0] z14_o;

    wire signed [WORD_LENGTH-1:0] x15;
    wire signed [WORD_LENGTH-1:0] y15;
    wire signed [WORD_LENGTH-1:0] z15;
    wire signed [WORD_LENGTH-1:0] x15_o;
    wire signed [WORD_LENGTH-1:0] y15_o;
    wire signed [WORD_LENGTH-1:0] z15_o;

    wire signed [WORD_LENGTH-1:0] x16;
    wire signed [WORD_LENGTH-1:0] y16;
    wire signed [WORD_LENGTH-1:0] z16;
    wire signed [WORD_LENGTH-1:0] x16_o;
    wire signed [WORD_LENGTH-1:0] y16_o;
    wire signed [WORD_LENGTH-1:0] z16_o;

    fp_to_fixed floating_to_fixed (
        .in(in),
        .out(z0)
    );

    cordic iteration_0 (
        .rst(rst),
        .x_i(x0),
        .y_i(y0),
        .z_i(z0),
        .alpha_i(alphas[0]),
        .iteration_i(0),
        .next_x_o(x0_o),
        .next_y_o(y0_o),
        .next_z_o(z0_o)
    );

    cordic_reg reg_0 (
        .clk(clk),
        .rst(rst),
        .x_i(x0_o),
        .y_i(y0_o),
        .z_i(z0_o),
        .x_o(x1),
        .y_o(y1),
        .z_o(z1)
    );

    cordic iteration_1 (
        .rst(rst),
        .x_i(x1),
        .y_i(y1),
        .z_i(z1),
        .alpha_i(alphas[1]),
        .iteration_i(1),
        .next_x_o(x1_o),
        .next_y_o(y1_o),
        .next_z_o(z1_o)
    );

    cordic_reg reg_1 (
        .clk(clk),
        .rst(rst),
        .x_i(x1_o),
        .y_i(y1_o),
        .z_i(z1_o),
        .x_o(x2),
        .y_o(y2),
        .z_o(z2)
    );

    cordic iteration_2 (
        .rst(rst),
        .x_i(x2),
        .y_i(y2),
        .z_i(z2),
        .alpha_i(alphas[2]),
        .iteration_i(2),
        .next_x_o(x2_o),
        .next_y_o(y2_o),
        .next_z_o(z2_o)
    );

    cordic_reg reg_2 (
        .clk(clk),
        .rst(rst),
        .x_i(x2_o),
        .y_i(y2_o),
        .z_i(z2_o),
        .x_o(x3),
        .y_o(y3),
        .z_o(z3)
    );

    cordic iteration_3 (
        .rst(rst),
        .x_i(x3),
        .y_i(y3),
        .z_i(z3),
        .alpha_i(alphas[3]),
        .iteration_i(3),
        .next_x_o(x3_o),
        .next_y_o(y3_o),
        .next_z_o(z3_o)
    );

    cordic_reg reg_3 (
        .clk(clk),
        .rst(rst),
        .x_i(x3_o),
        .y_i(y3_o),
        .z_i(z3_o),
        .x_o(x4),
        .y_o(y4),
        .z_o(z4)
    );

    cordic iteration_4 (
        .rst(rst),
        .x_i(x4),
        .y_i(y4),
        .z_i(z4),
        .alpha_i(alphas[4]),
        .iteration_i(4),
        .next_x_o(x4_o),
        .next_y_o(y4_o),
        .next_z_o(z4_o)
    );

    cordic_reg reg_4 (
        .clk(clk),
        .rst(rst),
        .x_i(x4_o),
        .y_i(y4_o),
        .z_i(z4_o),
        .x_o(x5),
        .y_o(y5),
        .z_o(z5)
    );

    cordic iteration_5 (
        .rst(rst),
        .x_i(x5),
        .y_i(y5),
        .z_i(z5),
        .alpha_i(alphas[5]),
        .iteration_i(5),
        .next_x_o(x5_o),
        .next_y_o(y5_o),
        .next_z_o(z5_o)
    );

    cordic_reg reg_5 (
        .clk(clk),
        .rst(rst),
        .x_i(x5_o),
        .y_i(y5_o),
        .z_i(z5_o),
        .x_o(x6),
        .y_o(y6),
        .z_o(z6)
    );

    cordic iteration_6 (
        .rst(rst),
        .x_i(x6),
        .y_i(y6),
        .z_i(z6),
        .alpha_i(alphas[6]),
        .iteration_i(6),
        .next_x_o(x6_o),
        .next_y_o(y6_o),
        .next_z_o(z6_o)
    );

    cordic_reg reg_6 (
        .clk(clk),
        .rst(rst),
        .x_i(x6_o),
        .y_i(y6_o),
        .z_i(z6_o),
        .x_o(x7),
        .y_o(y7),
        .z_o(z7)
    );

    cordic iteration_7 (
        .rst(rst),
        .x_i(x7),
        .y_i(y7),
        .z_i(z7),
        .alpha_i(alphas[7]),
        .iteration_i(7),
        .next_x_o(x7_o),
        .next_y_o(y7_o),
        .next_z_o(z7_o)
    );

    cordic_reg reg_7 (
        .clk(clk),
        .rst(rst),
        .x_i(x7_o),
        .y_i(y7_o),
        .z_i(z7_o),
        .x_o(x8),
        .y_o(y8),
        .z_o(z8)
    );

    cordic iteration_8 (
        .rst(rst),
        .x_i(x8),
        .y_i(y8),
        .z_i(z8),
        .alpha_i(alphas[8]),
        .iteration_i(8),
        .next_x_o(x8_o),
        .next_y_o(y8_o),
        .next_z_o(z8_o)
    );

    cordic_reg reg_8 (
        .clk(clk),
        .rst(rst),
        .x_i(x8_o),
        .y_i(y8_o),
        .z_i(z8_o),
        .x_o(x9),
        .y_o(y9),
        .z_o(z9)
    );

    cordic iteration_9 (
        .rst(rst),
        .x_i(x9),
        .y_i(y9),
        .z_i(z9),
        .alpha_i(alphas[9]),
        .iteration_i(9),
        .next_x_o(x9_o),
        .next_y_o(y9_o),
        .next_z_o(z9_o)
    );

    cordic_reg reg_9 (
        .clk(clk),
        .rst(rst),
        .x_i(x9_o),
        .y_i(y9_o),
        .z_i(z9_o),
        .x_o(x10),
        .y_o(y10),
        .z_o(z10)
    );

    cordic iteration_10 (
        .rst(rst),
        .x_i(x10),
        .y_i(y10),
        .z_i(z10),
        .alpha_i(alphas[10]),
        .iteration_i(10),
        .next_x_o(x10_o),
        .next_y_o(y10_o),
        .next_z_o(z10_o)
    );

    cordic_reg reg_10 (
        .clk(clk),
        .rst(rst),
        .x_i(x10_o),
        .y_i(y10_o),
        .z_i(z10_o),
        .x_o(x11),
        .y_o(y11),
        .z_o(z11)
    );

    cordic iteration_11 (
        .rst(rst),
        .x_i(x11),
        .y_i(y11),
        .z_i(z11),
        .alpha_i(alphas[11]),
        .iteration_i(11),
        .next_x_o(x11_o),
        .next_y_o(y11_o),
        .next_z_o(z11_o)
    );

    cordic_reg reg_11 (
        .clk(clk),
        .rst(rst),
        .x_i(x11_o),
        .y_i(y11_o),
        .z_i(z11_o),
        .x_o(x12),
        .y_o(y12),
        .z_o(z12)
    );

    cordic iteration_12 (
        .rst(rst),
        .x_i(x12),
        .y_i(y12),
        .z_i(z12),
        .alpha_i(alphas[12]),
        .iteration_i(12),
        .next_x_o(x12_o),
        .next_y_o(y12_o),
        .next_z_o(z12_o)
    );

    cordic_reg reg_12 (
        .clk(clk),
        .rst(rst),
        .x_i(x12_o),
        .y_i(y12_o),
        .z_i(z12_o),
        .x_o(x13),
        .y_o(y13),
        .z_o(z13)
    );

    cordic iteration_13 (
        .rst(rst),
        .x_i(x13),
        .y_i(y13),
        .z_i(z13),
        .alpha_i(alphas[13]),
        .iteration_i(13),
        .next_x_o(x13_o),
        .next_y_o(y13_o),
        .next_z_o(z13_o)
    );

    cordic_reg reg_13 (
        .clk(clk),
        .rst(rst),
        .x_i(x13_o),
        .y_i(y13_o),
        .z_i(z13_o),
        .x_o(x14),
        .y_o(y14),
        .z_o(z14)
    );

    cordic iteration_14 (
        .rst(rst),
        .x_i(x14),
        .y_i(y14),
        .z_i(z14),
        .alpha_i(alphas[14]),
        .iteration_i(14),
        .next_x_o(x14_o),
        .next_y_o(y14_o),
        .next_z_o(z14_o)
    );

    cordic_reg reg_14 (
        .clk(clk),
        .rst(rst),
        .x_i(x14_o),
        .y_i(y14_o),
        .z_i(z14_o),
        .x_o(x15),
        .y_o(y15),
        .z_o(z15)
    );

    cordic iteration_15 (
        .rst(rst),
        .x_i(x15),
        .y_i(y15),
        .z_i(z15),
        .alpha_i(alphas[15]),
        .iteration_i(15),
        .next_x_o(x15_o),
        .next_y_o(y15_o),
        .next_z_o(z15_o)
    );

    cordic_reg reg_15 (
        .clk(clk),
        .rst(rst),
        .x_i(x15_o),
        .y_i(y15_o),
        .z_i(z15_o),
        .x_o(x16),
        .y_o(y16),
        .z_o(z16)
    );

    cordic iteration_16 (
        .rst(rst),
        .x_i(x16),
        .y_i(y16),
        .z_i(z16),
        .alpha_i(alphas[16]),
        .iteration_i(16),
        .next_x_o(x16_o),
        .next_y_o(y16_o),
        .next_z_o(z16_o)
    );

    cordic_reg reg_16 (
        .clk(clk),
        .rst(rst),
        .x_i(x16_o),
        .y_i(y16_o),
        .z_i(z16_o),
        .x_o(x17),
        .y_o(y17),
        .z_o(z17)
    );

    fixed_to_fp fixed_to_floating (
        .in(x17),
        .out(out)
    );

endmodule
