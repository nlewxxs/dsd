module cordic #(
    parameter WORD_LENGTH = 21
)(
    input rst,

    // fixed-point parts are passed as one signal, there is no advantage to splitting them up or not.
    input signed [WORD_LENGTH-1:0] x_i,        // previous x
    input signed [WORD_LENGTH-1:0] y_i,        // previous y
    input signed [WORD_LENGTH-1:0] z_i,        // previous z
    input signed [WORD_LENGTH-1:0] alpha_i,    // alpha for this iteration (determined by cordic_top)
    input [4:0] iteration_i,                   // iteration number (determined by cordic_top)

    output signed [WORD_LENGTH-1:0] next_x_o,  // next x
    output signed [WORD_LENGTH-1:0] next_y_o,  // next y
    output signed [WORD_LENGTH-1:0] next_z_o   // next z
);
    /* might seem bizarre to input both the iteration number and the alpha, when one is dependent
    on the other. However, storing the alphas in each cordic iteration block would be silly when we
    can just keep one copy in the top module. This saves resources. */

    wire signed [WORD_LENGTH-1:0] shifted_x;     // bitwise shifted x
    wire signed [WORD_LENGTH-1:0] shifted_y;     // bitwise shifted y
    wire d;                                     // sign of current angle

    // wires to connect up arithmetic modules
    wire signed [WORD_LENGTH-1:0] x_sum;
    wire signed [WORD_LENGTH-1:0] y_sum;
    wire signed [WORD_LENGTH-1:0] z_sum;
    wire signed [WORD_LENGTH-1:0] x_diff;
    wire signed [WORD_LENGTH-1:0] y_diff;
    wire signed [WORD_LENGTH-1:0] z_diff;

    assign d = z_i[WORD_LENGTH-1];

    add_sub x_arithmetic (
        .a_i(x_i),
        .b_i(shifted_y),
        .sum_o(x_sum),
        .difference_o(x_diff)
    );

    add_sub y_arithmetic (
        .a_i(y_i),
        .b_i(shifted_x),
        .sum_o(y_sum),
        .difference_o(y_diff)
    );

    add_sub z_arithmetic (
        .a_i(z_i),
        .b_i(alpha_i),
        .sum_o(z_sum),
        .difference_o(z_diff)
    );

    // use signed shifting to preserve sign bit.
    assign shifted_x = x_i >>> iteration_i;
    assign shifted_y = y_i >>> iteration_i;

    // update based on sign of z_i
    assign next_x_o = (rst) ? 0 : ((d) ? x_sum : x_diff);
    assign next_y_o = (rst) ? 0 : ((d) ? y_diff : y_sum);
    assign next_z_o = (rst) ? 0 : ((d) ? z_sum : z_diff);

endmodule


