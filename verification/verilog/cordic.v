module cordic #(
    parameter WORD_LENGTH = 21,
    parameter N_ITERATIONS = 17
)(
    input clk,
    input rst,
    // all inputs and outputs signed fixed-point
    input sign_i,
    output sign_o,
    input integer_i,
    output integer_o,
    input [WORD_LENGTH-3:0] fractional_i,
    output [WORD_LENGTH-3:0] fractional_o
);

    reg signed [N_ITERATIONS-1:0] [WORD_LENGTH-1:0] alphas; // arctan lookup table
    assign sign_o = alphas[0][WORD_LENGTH-1];
    assign integer_o = alphas[0][WORD_LENGTH-2];
    assign fractional_o = alphas[0][WORD_LENGTH-3:0];

    // instantiate the arctan lookup table (this needs to be manually changed if parameters are changed,
    // since we are using a LUT implementation for this)
    initial begin
        alphas[0]  = 21'b00_1100100100110110110;
        alphas[1]  = 21'b00_0111111010000011010;
        alphas[2]  = 21'b00_0011110011001111110;
        alphas[3]  = 21'b00_0001111110011011111;
        alphas[4]  = 21'b00_0000111110100101001;
        alphas[5]  = 21'b00_0000011111011010100;
        alphas[6]  = 21'b00_0000001111110111011;
        alphas[7]  = 21'b00_0000000111111000000;
        alphas[8]  = 21'b00_0000000011111100000;
        alphas[9]  = 21'b00_0000000001111110000;
        alphas[10] = 21'b00_0000000000111111000;
        alphas[11] = 21'b00_0000000000011111100;
        alphas[12] = 21'b00_0000000000001111110;
        alphas[13] = 21'b00_0000000000000111111;
        alphas[14] = 21'b00_0000000000000011111;
        alphas[15] = 21'b00_0000000000000001111;
        alphas[16] = 21'b00_0000000000000000111;
    end

endmodule

