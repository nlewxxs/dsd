module fixed_add_sub #(
    parameter WORD_LENGTH = 21
)(
    // async
    input signed [WORD_LENGTH-1:0] a_i,
    input signed [WORD_LENGTH-1:0] b_i,
    output signed [WORD_LENGTH-1:0] sum_o,
    output signed [WORD_LENGTH-1:0] difference_o
);
    assign sum_o = a_i + b_i;
    assign difference_o = a_i - b_i;

endmodule
