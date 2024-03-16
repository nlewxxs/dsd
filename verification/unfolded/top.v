// top module
module top #(
    parameter WORD_LENGTH = 21,
    parameter N_ITERATIONS = 17
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

    // pipeline 0
    wire [31:0] half_x;

    wire signed [WORD_LENGTH-1:0] x1;
    wire signed [WORD_LENGTH-1:0] y1;
    wire signed [WORD_LENGTH-1:0] z1;
    wire signed [WORD_LENGTH-1:0] x2;
    wire signed [WORD_LENGTH-1:0] y2;
    wire signed [WORD_LENGTH-1:0] z2;
    wire signed [WORD_LENGTH-1:0] x3;
    wire signed [WORD_LENGTH-1:0] y3;
    wire signed [WORD_LENGTH-1:0] z3;

    wire signed [WORD_LENGTH-1:0] x3_o;
    wire signed [WORD_LENGTH-1:0] y3_o;
    wire signed [WORD_LENGTH-1:0] z3_o;

    // pipeline 1
    wire signed [WORD_LENGTH-1:0] x4;
    wire signed [WORD_LENGTH-1:0] y4;
    wire signed [WORD_LENGTH-1:0] z4;
    wire signed [WORD_LENGTH-1:0] x5;
    wire signed [WORD_LENGTH-1:0] y5;
    wire signed [WORD_LENGTH-1:0] z5;
    wire signed [WORD_LENGTH-1:0] x6;
    wire signed [WORD_LENGTH-1:0] y6;
    wire signed [WORD_LENGTH-1:0] z6;

    wire signed [WORD_LENGTH-1:0] x6_o;
    wire signed [WORD_LENGTH-1:0] y6_o;
    wire signed [WORD_LENGTH-1:0] z6_o;

    // pipeline 2
    wire signed [WORD_LENGTH-1:0] x7;
    wire signed [WORD_LENGTH-1:0] y7;
    wire signed [WORD_LENGTH-1:0] z7;
    wire signed [WORD_LENGTH-1:0] x8;
    wire signed [WORD_LENGTH-1:0] y8;
    wire signed [WORD_LENGTH-1:0] z8;
    wire signed [WORD_LENGTH-1:0] x9;
    wire signed [WORD_LENGTH-1:0] y9;
    wire signed [WORD_LENGTH-1:0] z9;

    wire signed [WORD_LENGTH-1:0] x9_o;
    wire signed [WORD_LENGTH-1:0] y9_o;
    wire signed [WORD_LENGTH-1:0] z9_o;

    // pipeline 3
    wire signed [WORD_LENGTH-1:0] x10;
    wire signed [WORD_LENGTH-1:0] y10;
    wire signed [WORD_LENGTH-1:0] z10;
    wire signed [WORD_LENGTH-1:0] x11;
    wire signed [WORD_LENGTH-1:0] y11;
    wire signed [WORD_LENGTH-1:0] z11;
    wire signed [WORD_LENGTH-1:0] x12;
    wire signed [WORD_LENGTH-1:0] y12;
    wire signed [WORD_LENGTH-1:0] z12;

    wire signed [WORD_LENGTH-1:0] x12_o;
    wire signed [WORD_LENGTH-1:0] y12_o;
    wire signed [WORD_LENGTH-1:0] z12_o;

    // pipeline 4
    wire signed [WORD_LENGTH-1:0] x13;
    wire signed [WORD_LENGTH-1:0] y13;
    wire signed [WORD_LENGTH-1:0] z13;
    wire signed [WORD_LENGTH-1:0] x14;
    wire signed [WORD_LENGTH-1:0] y14;
    wire signed [WORD_LENGTH-1:0] z14;
    wire signed [WORD_LENGTH-1:0] x15;
    wire signed [WORD_LENGTH-1:0] y15;
    wire signed [WORD_LENGTH-1:0] z15;

    wire signed [WORD_LENGTH-1:0] x15_o;
    wire signed [WORD_LENGTH-1:0] y15_o;
    wire signed [WORD_LENGTH-1:0] z15_o;

    // pipeline 5
    wire signed [WORD_LENGTH-1:0] x16;
    wire signed [WORD_LENGTH-1:0] y16;
    wire signed [WORD_LENGTH-1:0] z16;
    wire signed [WORD_LENGTH-1:0] x17;
    wire signed [WORD_LENGTH-1:0] y17;
    wire signed [WORD_LENGTH-1:0] z17;

    fp_to_fixed floating_to_fixed (
        .in(in),
        .out(z0)
    );

    divide_two halver (
        .in(in),
        .out(half_x)
    );

    cordic iteration_0 (
        .rst(rst),
        .x_i(x0),
        .y_i(y0),
        .z_i(z0),
        .alpha_i(alphas[0]),
        .iteration_i(0),
        .next_x_o(x1),
        .next_y_o(y1),
        .next_z_o(z1)
    );

    cordic iteration_1 (
        .rst(rst),
        .x_i(x1),
        .y_i(y1),
        .z_i(z1),
        .alpha_i(alphas[1]),
        .iteration_i(1),
        .next_x_o(x2),
        .next_y_o(y2),
        .next_z_o(z2)
    );

    cordic iteration_2 (
        .rst(rst),
        .x_i(x2),
        .y_i(y2),
        .z_i(z2),
        .alpha_i(alphas[2]),
        .iteration_i(2),
        .next_x_o(x3),
        .next_y_o(y3),
        .next_z_o(z3)
    );

    cordic_reg reg_0 (
        .clk(clk),
        .rst(rst),
        .x_i(x3),
        .y_i(y3),
        .z_i(z3),
        .x_o(x3_o),
        .y_o(y3_o),
        .z_o(z3_o)
    );

    cordic iteration_3 (
        .rst(rst),
        .x_i(x3_o),
        .y_i(y3_o),
        .z_i(z3_o),
        .alpha_i(alphas[3]),
        .iteration_i(3),
        .next_x_o(x4),
        .next_y_o(y4),
        .next_z_o(z4)
    );

    cordic iteration_4 (
        .rst(rst),
        .x_i(x4),
        .y_i(y4),
        .z_i(z4),
        .alpha_i(alphas[4]),
        .iteration_i(4),
        .next_x_o(x5),
        .next_y_o(y5),
        .next_z_o(z5)
    );

    cordic iteration_5 (
        .rst(rst),
        .x_i(x5),
        .y_i(y5),
        .z_i(z5),
        .alpha_i(alphas[5]),
        .iteration_i(5),
        .next_x_o(x6),
        .next_y_o(y6),
        .next_z_o(z6)
    );

    cordic_reg reg_5 (
        .clk(clk),
        .rst(rst),
        .x_i(x6),
        .y_i(y6),
        .z_i(z6),
        .x_o(x6_o),
        .y_o(y6_o),
        .z_o(z6_o)
    );

    cordic iteration_6 (
        .rst(rst),
        .x_i(x6_o),
        .y_i(y6_o),
        .z_i(z6_o),
        .alpha_i(alphas[6]),
        .iteration_i(6),
        .next_x_o(x7),
        .next_y_o(y7),
        .next_z_o(z7)
    );

    cordic iteration_7 (
        .rst(rst),
        .x_i(x7),
        .y_i(y7),
        .z_i(z7),
        .alpha_i(alphas[7]),
        .iteration_i(7),
        .next_x_o(x8),
        .next_y_o(y8),
        .next_z_o(z8)
    );

    cordic iteration_8 (
        .rst(rst),
        .x_i(x8),
        .y_i(y8),
        .z_i(z8),
        .alpha_i(alphas[8]),
        .iteration_i(8),
        .next_x_o(x9),
        .next_y_o(y9),
        .next_z_o(z9)
    );

    cordic_reg reg_8 (
        .clk(clk),
        .rst(rst),
        .x_i(x9),
        .y_i(y9),
        .z_i(z9),
        .x_o(x9_o),
        .y_o(y9_o),
        .z_o(z9_o)
    );

    cordic iteration_9 (
        .rst(rst),
        .x_i(x9_o),
        .y_i(y9_o),
        .z_i(z9_o),
        .alpha_i(alphas[9]),
        .iteration_i(9),
        .next_x_o(x10),
        .next_y_o(y10),
        .next_z_o(z10)
    );

    cordic iteration_10 (
        .rst(rst),
        .x_i(x10),
        .y_i(y10),
        .z_i(z10),
        .alpha_i(alphas[10]),
        .iteration_i(10),
        .next_x_o(x11),
        .next_y_o(y11),
        .next_z_o(z11)
    );

    cordic iteration_11 (
        .rst(rst),
        .x_i(x11),
        .y_i(y11),
        .z_i(z11),
        .alpha_i(alphas[11]),
        .iteration_i(11),
        .next_x_o(x12),
        .next_y_o(y12),
        .next_z_o(z12)
    );

    cordic_reg reg_11 (
        .clk(clk),
        .rst(rst),
        .x_i(x12),
        .y_i(y12),
        .z_i(z12),
        .x_o(x12_o),
        .y_o(y12_o),
        .z_o(z12_o)
    );

    cordic iteration_12 (
        .rst(rst),
        .x_i(x12_o),
        .y_i(y12_o),
        .z_i(z12_o),
        .alpha_i(alphas[12]),
        .iteration_i(12),
        .next_x_o(x13),
        .next_y_o(y13),
        .next_z_o(z13)
    );

    cordic iteration_13 (
        .rst(rst),
        .x_i(x13),
        .y_i(y13),
        .z_i(z13),
        .alpha_i(alphas[13]),
        .iteration_i(13),
        .next_x_o(x14),
        .next_y_o(y14),
        .next_z_o(z14)
    );

    cordic iteration_14 (
        .rst(rst),
        .x_i(x14),
        .y_i(y14),
        .z_i(z14),
        .alpha_i(alphas[14]),
        .iteration_i(14),
        .next_x_o(x15),
        .next_y_o(y15),
        .next_z_o(z15)
    );

    cordic_reg reg_14 (
        .clk(clk),
        .rst(rst),
        .x_i(x15),
        .y_i(y15),
        .z_i(z15),
        .x_o(x15_o),
        .y_o(y15_o),
        .z_o(z15_o)
    );

    cordic iteration_15 (
        .rst(rst),
        .x_i(x15_o),
        .y_i(y15_o),
        .z_i(z15_o),
        .alpha_i(alphas[15]),
        .iteration_i(15),
        .next_x_o(x16),
        .next_y_o(y16),
        .next_z_o(z16)
    );

    cordic iteration_16 (
        .rst(rst),
        .x_i(x16),
        .y_i(y16),
        .z_i(z16),
        .alpha_i(alphas[16]),
        .iteration_i(16),
        .next_x_o(x17),
        .next_y_o(y17),
        .next_z_o(z17)
    );

    fixed_to_fp fixed_to_floating (
        .in(x17),
        .out(out)
    );

endmodule
