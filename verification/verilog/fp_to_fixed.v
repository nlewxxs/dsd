module fp_to_fixed (
    input clk,
    input [31:0] fp_i, // floating point input
    output sign_o, // sign of fixed-point
    output reg integer_o, // integer part of fixed-point
    output reg [18:0] fractional_o // fractional part of fixed-point
);

    reg [7:0] exponent;
    reg [7:0] unbiased_exponent;
    reg [22:0] significand;

    assign sign_o = fp_i[31]; // keep the same sign
    assign exponent = fp_i[30:23]; // extract exponent
    assign significand = fp_i[22:0]; // extract significand
    assign unbiased_exponent = ~(exponent - 127 - 8'b00000001); // unbias component using two's complement

    always @(posedge clk) begin

        reg integer_part = 1'b1; // for denormalising the significand
        reg [22:0] fractional_part = significand;

        if (unbiased_exponent[0] == 1) begin
            fractional_part = {integer_part, fractional_part[22:1]}; // sign extend
            integer_part = 1'b0;
        end

        if (unbiased_exponent[1] == 1) begin
            fractional_part = {1'b0, integer_part, fractional_part[22:2]}; // sign extend
            integer_part = 1'b0;
        end

        if (unbiased_exponent[2] == 1) begin
            fractional_part = {3'b0, integer_part, fractional_part[22:4]}; // sign extend
            integer_part = 1'b0;
        end

        if (unbiased_exponent[3] == 1) begin
            fractional_part = {7'b0, integer_part, fractional_part[22:8]}; // sign extend
            integer_part = 1'b0;
        end

        if (unbiased_exponent[4] == 1) begin
            fractional_part = {15'b0, integer_part, fractional_part[22:16]}; // sign extend
            integer_part = 1'b0;
        end

        integer_o <= integer_part;
        fractional_o <= fractional_part[22:4]; // KEEP ONLY BITS REQUIRED BY MONTE-CARLO RESULTS
        $display("full fractional part: %b\n", fractional_part);
        $display("truncated fractional part: %b\n", fractional_o);

    end
endmodule;
