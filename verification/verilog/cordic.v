module cordic #(
    parameter WORD_LENGTH = 21,
    parameter N_ITERATIONS = 17
)(
    input clk,
    input rst,
    input sign_i,               // sign of the input
    input integer_i,            // integer part of fixed-point input
    input [WORD_LENGTH-3:0] fractional_i,  // fractional part of fixed-point input
    output sign_o,              // sign of output
    output integer_o,           // integer part of fixed-point output
    output [WORD_LENGTH-3:0] fractional_o  // fractional part of fixed-point output
);

    reg [N_ITERATIONS-1:0] [WORD_LENGTH-1:0] alphas; // arctan lookup table

    // instantiate the arctan lookup table (this needs to be manually changed if parameters are changed,
    // since we are using a LUT implementation for this)
    initial begin
        alphas[0] <= WORD_LENGTH'b00_1100100100110110110;
        alphas[1] <= WORD_LENGTH'b00_0111111010000011010;
        alphas[2] <= WORD_LENGTH'b00_0011110011001111110;
        alphas[3] <= WORD_LENGTH'b00_0001111110011011111;
        alphas[4] <= WORD_LENGTH'b00_0000111110100101001;
        alphas[5] <= WORD_LENGTH'b00_0000011111011010100;
        alphas[6] <= WORD_LENGTH'b00_0000001111110111011;
        alphas[7] <= WORD_LENGTH'b00_0000000111111000000;
        alphas[8] <= WORD_LENGTH'b00_0000000011111100000;
        alphas[9] <= WORD_LENGTH'b00_0000000001111110000;
        alphas[10] <= WORD_LENGTH'b00_0000000000111111000;
        alphas[11] <= WORD_LENGTH'b00_0000000000011111100;
        alphas[12] <= WORD_LENGTH'b00_0000000000001111110;
        alphas[13] <= WORD_LENGTH'b00_0000000000000111111;
        alphas[14] <= WORD_LENGTH'b00_0000000000000011111;
        alphas[15] <= WORD_LENGTH'b00_0000000000000001111;
        alphas[16] <= WORD_LENGTH'b00_0000000000000000111;
    end

endmodule