module fixed_to_fp #(
    parameter WORD_LENGTH = 21
)(
    input signed [WORD_LENGTH-1:0] in,
    output [31:0] out
);
    /* Given that we know the exponent will always be negative, we can exploit this to get an extremely
    fast and compact method of converting from fixed point to IEEE-754 floating point. */

    /* don't actually have to worry about negatives here because cos() output will always be positive
    for the given range. */

    reg [31:0] fp;

    // split up input for ease of conversion
    wire sign;
    wire integer_part;
    wire [WORD_LENGTH-3:0] fractional;

    assign sign = in[WORD_LENGTH-1];
    assign integer_part = in[WORD_LENGTH-2];
    assign fractional = in[WORD_LENGTH-3:0];
    assign out = fp;

    always @(*) begin
        reg [7:0] exponent;
        reg [18:0] bitwise_or_array; // explained below
        /* SPECIAL METHOD */
        /* If we can identify the location of the first 1, we can use this to determine the exponent
        This can be done by propagating a bitwise OR operation throughout the fractional part.
        This will evaluate to:
            0 for all leading zeros
            1 for the first 1 encountered in the input
            1 for all subsequent 1s or 0s
        The resulting bitwise_or_array will allow us to then select an exponent using a simple multiplexer.
        */
        bitwise_or_array[18] = fractional[18];
        bitwise_or_array[17] = bitwise_or_array[18] | fractional[17];
        bitwise_or_array[16] = bitwise_or_array[17] | fractional[16];
        bitwise_or_array[15] = bitwise_or_array[16] | fractional[15];
        bitwise_or_array[14] = bitwise_or_array[15] | fractional[14];
        bitwise_or_array[13] = bitwise_or_array[14] | fractional[13];
        bitwise_or_array[12] = bitwise_or_array[13] | fractional[12];
        bitwise_or_array[11] = bitwise_or_array[12] | fractional[11];
        bitwise_or_array[10] = bitwise_or_array[11] | fractional[10];
        bitwise_or_array[9] = bitwise_or_array[10] | fractional[9];
        bitwise_or_array[8] = bitwise_or_array[9] | fractional[8];
        bitwise_or_array[7] = bitwise_or_array[8] | fractional[7];
        bitwise_or_array[6] = bitwise_or_array[7] | fractional[6];
        bitwise_or_array[5] = bitwise_or_array[6] | fractional[5];
        bitwise_or_array[4] = bitwise_or_array[5] | fractional[4];
        bitwise_or_array[3] = bitwise_or_array[4] | fractional[3];
        bitwise_or_array[2] = bitwise_or_array[3] | fractional[2];
        bitwise_or_array[1] = bitwise_or_array[2] | fractional[1];
        bitwise_or_array[0] = bitwise_or_array[1] | fractional[0];


        // now we just select the exponent, this translates to a simple mux.
        case(bitwise_or_array)
            19'b1111111111111111111: exponent = 8'b00000001;
            19'b0111111111111111111: exponent = 8'b00000010;
            19'b0011111111111111111: exponent = 8'b00000011;
            19'b0001111111111111111: exponent = 8'b00000100;
            19'b0000111111111111111: exponent = 8'b00000101;
            19'b0000011111111111111: exponent = 8'b00000110;
            19'b0000001111111111111: exponent = 8'b00000111;
            19'b0000000111111111111: exponent = 8'b00001000;
            19'b0000000011111111111: exponent = 8'b00001001;
            19'b0000000001111111111: exponent = 8'b00001010;
            19'b0000000000111111111: exponent = 8'b00001011;
            19'b0000000000011111111: exponent = 8'b00001100;
            19'b0000000000001111111: exponent = 8'b00001101;
            19'b0000000000000111111: exponent = 8'b00001110;
            19'b0000000000000011111: exponent = 8'b00001111;
            19'b0000000000000001111: exponent = 8'b00010000;
            19'b0000000000000000111: exponent = 8'b00010001;
            19'b0000000000000000011: exponent = 8'b00010010;
            19'b0000000000000000001: exponent = 8'b00010011;
            default: exponent = 8'b0;
        endcase

        // this is written with the assumption that the input will not be outside the required [-1, 1] range
        if (integer_part) begin
            // handle special cases
            fp = (sign) ? 32'b10111111100000000000000000000000 : 32'b00111111100000000000000000000000;
        end
        else if (exponent == 8'b0) begin
            fp = 32'b0;
        end
        else begin
            // normalise the exponent as per the IEEE-754 rules
            fp = {sign, ~exponent + 8'b10000000, fractional << exponent, 4'b0};
        end
    end
endmodule
