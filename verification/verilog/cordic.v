module cordic #(
    parameter WORD_LENGTH = 21,
    parameter N_ITERATIONS = 17
)(
    input clk,
    input rst,
    // fixed-point parts are passed as one signal, there is no advantage to splitting them up or not.
    input signed [WORD_LENGTH-1:0] x_i,        // previous x
    input signed [WORD_LENGTH-1:0] y_i,        // previous y
    input signed [WORD_LENGTH-1:0] z_i,        // previous z
    input signed [WORD_LENGTH-1:0] alpha_i,    // alpha for this iteration (determined by cordic_top)
    input [4:0] iteration_i,                   // iteration number (determined by cordic_top)

    output reg signed [WORD_LENGTH-1:0] next_x_o,  // next x
    output reg signed [WORD_LENGTH-1:0] next_y_o,  // next y
    output reg signed [WORD_LENGTH-1:0] next_z_o   // next z
);
    /* might seem bizarre to input both the iteration number and the alpha, when one is dependent
    on the other. However, storing the alphas in each cordic iteration block would be silly when we
    can just keep one copy in the top module. This saves resources. */

    reg signed [WORD_LENGTH-1:0] shifted_x;     // bitwise shifted x
    reg signed [WORD_LENGTH-1:0] shifted_y;     // bitwise shifted y
    reg d;                                      // sign of current angle

    // wires to connect up arithmetic modules
    wire signed [WORD_LENGTH-1:0] x_sum;
    wire signed [WORD_LENGTH-1:0] y_sum;
    wire signed [WORD_LENGTH-1:0] z_sum;
    wire signed [WORD_LENGTH-1:0] x_diff;
    wire signed [WORD_LENGTH-1:0] y_diff;
    wire signed [WORD_LENGTH-1:0] z_diff;

    assign d = z_i[WORD_LENGTH-1];

    fixed_add_sub x_arithmetic (
        .a_i(x_i),
        .b_i(shifted_y),
        .sum_o(x_sum),
        .difference_o(x_diff)
    );

    fixed_add_sub y_arithmetic (
        .a_i(y_i),
        .b_i(shifted_x),
        .sum_o(y_sum),
        .difference_o(y_diff)
    );

    fixed_add_sub z_arithmetic (
        .a_i(z_i),
        .b_i(alpha_i),
        .sum_o(z_sum),
        .difference_o(z_diff)
    );

    always @(posedge clk) begin
        // use signed shifting to preserve sign bit.
        shifted_x <= x_i >>> iteration_i;
        shifted_y <= y_i >>> iteration_i;

        $display("x: %b, y: %b", x_i, y_i);
        $display("shifted_x: %b, shifted_y: %b", shifted_x, shifted_y);
        $display("z sign: %b", d);

        // update based on sign of z_i
        next_x_o <= (d) ? x_diff : x_sum;
        next_y_o <= (d) ? y_sum : y_diff;
        next_z_o <= (d) ? z_diff : z_sum;
        $display("next_x: %b, next_y: %b", next_x_o, next_y_o);
    end
endmodule

