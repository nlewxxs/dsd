module fp_to_fixed #(
    parameter WORD_LENGTH = 21
)(
    input [31:0] in, // floating point input
    output signed [WORD_LENGTH-1:0] out // fixed-point output
);
    reg [7:0] exponent;
    reg [7:0] unbiased_exponent;
    reg [22:0] significand;
    reg [WORD_LENGTH-2:0] magnitude;

    assign exponent = in[30:23]; // extract exponent
    assign significand = in[22:0]; // extract significand
    assign unbiased_exponent = ~(exponent - 127 - 8'b00000001); // unbias component using two's complement

    assign out = (in[31]) ? {1'b0, (~magnitude + 1'b1)} : {1'b0, magnitude};

    always @(*) begin

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

        magnitude = {integer_part, fractional_part[22:4]};
    end
endmodule;
