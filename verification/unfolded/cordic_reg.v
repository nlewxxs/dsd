// A pipeline register to store intermediate results of a cordic iteration

module cordic_reg #(
    parameter WORD_LENGTH = 21
)(
    input clk,
    input rst,

    input signed [WORD_LENGTH-1:0] x_i, // next x
    input signed [WORD_LENGTH-1:0] y_i, // next y
    input signed [WORD_LENGTH-1:0] z_i, // next z

    output reg signed [WORD_LENGTH-1:0] x_o, // x
    output reg signed [WORD_LENGTH-1:0] y_o, // y
    output reg signed [WORD_LENGTH-1:0] z_o, // z
);

    // update synchronously
    always @(posedge clk, posedge rst) begin
        x_o <= (rst) ? {WORD_LENGTH{1'b0}} : x_i;
        y_o <= (rst) ? {WORD_LENGTH{1'b0}} : y_i;
        z_o <= (rst) ? {WORD_LENGTH{1'b0}} : z_i;
    end

endmodule

