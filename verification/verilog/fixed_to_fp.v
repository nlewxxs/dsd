module fixed_to_fp (
    input sign_i,
    input integer_i,
    input [18:0] fractional_i,
    output [31:0] fp_o
);
    /* Given that we know the exponent will always be negative, we can exploit this to get an extremely
    fast and compact method of converting from fixed point to IEEE-754 floating point. */

    reg [31:0] fp_reg;
    assign fp_o = fp_reg;

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
        bitwise_or_array[18] = fractional_i[18];
        bitwise_or_array[17] = bitwise_or_array[18] | fractional_i[17];
        bitwise_or_array[16] = bitwise_or_array[17] | fractional_i[16];
        bitwise_or_array[15] = bitwise_or_array[16] | fractional_i[15];
        bitwise_or_array[14] = bitwise_or_array[15] | fractional_i[14];
        bitwise_or_array[13] = bitwise_or_array[14] | fractional_i[13];
        bitwise_or_array[12] = bitwise_or_array[13] | fractional_i[12];
        bitwise_or_array[11] = bitwise_or_array[12] | fractional_i[11];
        bitwise_or_array[10] = bitwise_or_array[11] | fractional_i[10];
        bitwise_or_array[9] = bitwise_or_array[10] | fractional_i[9];
        bitwise_or_array[8] = bitwise_or_array[9] | fractional_i[8];
        bitwise_or_array[7] = bitwise_or_array[8] | fractional_i[7];
        bitwise_or_array[6] = bitwise_or_array[7] | fractional_i[6];
        bitwise_or_array[5] = bitwise_or_array[6] | fractional_i[5];
        bitwise_or_array[4] = bitwise_or_array[5] | fractional_i[4];
        bitwise_or_array[3] = bitwise_or_array[4] | fractional_i[3];
        bitwise_or_array[2] = bitwise_or_array[3] | fractional_i[2];
        bitwise_or_array[1] = bitwise_or_array[2] | fractional_i[1];
        bitwise_or_array[0] = bitwise_or_array[1] | fractional_i[0];


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
        if (integer_i) begin
            // handle special cases
            fp_reg = (sign_i) ? 32'b10111111100000000000000000000000 : 32'b00111111100000000000000000000000;
        end
        else if (!exponent) begin
            fp_reg = 32'b0;
        end
        else begin
            // normalise the exponent as per the IEEE-754 rules
            fp_reg = {sign_i, ~exponent + 8'b10000000, fractional_i << exponent, 4'b0};
        end
    end
endmodule
