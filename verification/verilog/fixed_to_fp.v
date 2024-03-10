module fixed_to_fp (
    input clk,
    input sign_i,
    input integer_i,
    input [18:0] fractional_i,
    output [31:0] fp_o
);
    /* Given that we know the exponent will always be negative, we can exploit this to get an extremely
    fast and compact method of converting from fixed point to IEEE-754 floating point. */

    reg cursor; // this tracks whether the MSB has been encountered yet
    reg [18:0] cursor_array;
    reg [7:0] exponent;
    reg [31:0] fp_reg;

    assign fp_o = fp_reg;

    always @(posedge clk) begin

        // check special cases first
        if (integer_i == 1) begin
            if (sign_i == 1) fp_reg <= 32'b1;
            else fp_reg <= 32'b0;
        end else begin

            /* SPECIAL ALGORITHM */
            /* We keep a cursor to keep track of whether the MSB has been encountered yet or not.
            The value of the cursor is then compared with each input bit using cur = !cur AND in.
            This will evaluate to:
                0 for all leading zeros
                1 for the first 1 encountered in the input
                0 for all subsequent 1s or 0s
            Storing the value of the cursor in an output each time will allow us to then select an
            exponent using a simple multiplexer.
            */

            // reset values
            cursor = 0;
            cursor_array = 0;

            // perform sweep for MSB. These must be blocking statements.
            cursor_array[18] = ~cursor & fractional_i[18];
            cursor_array[17] = ~cursor & fractional_i[17];
            cursor_array[16] = ~cursor & fractional_i[16];
            cursor_array[15] = ~cursor & fractional_i[15];
            cursor_array[14] = ~cursor & fractional_i[14];
            cursor_array[13] = ~cursor & fractional_i[13];
            cursor_array[12] = ~cursor & fractional_i[12];
            cursor_array[11] = ~cursor & fractional_i[11];
            cursor_array[10] = ~cursor & fractional_i[10];
            cursor_array[9] = ~cursor & fractional_i[9];
            cursor_array[8] = ~cursor & fractional_i[8];
            cursor_array[7] = ~cursor & fractional_i[7];
            cursor_array[6] = ~cursor & fractional_i[6];
            cursor_array[5] = ~cursor & fractional_i[5];
            cursor_array[4] = ~cursor & fractional_i[4];
            cursor_array[3] = ~cursor & fractional_i[3];
            cursor_array[2] = ~cursor & fractional_i[2];
            cursor_array[1] = ~cursor & fractional_i[1];
            cursor_array[0] = ~cursor & fractional_i[0];

            // now we just select the exponent, this translates to a simple mux.
            // Not the actual exponent, then add 128 to take care of both the IEE-754 bias and two's complement
            // in one go.

            case(cursor_array)
                19'b1000000000000000000: exponent = ~(8'b00000001) + 8'b10000000;
                19'b0100000000000000000: exponent = ~(8'b00000010) + 8'b10000000;
                19'b0010000000000000000: exponent = ~(8'b00000011) + 8'b10000000;
                19'b0001000000000000000: exponent = ~(8'b00000100) + 8'b10000000;
                19'b0000100000000000000: exponent = ~(8'b00000101) + 8'b10000000;
                19'b0000010000000000000: exponent = ~(8'b00000110) + 8'b10000000;
                19'b0000001000000000000: exponent = ~(8'b00000111) + 8'b10000000;
                19'b0000000100000000000: exponent = ~(8'b00001000) + 8'b10000000;
                19'b0000000010000000000: exponent = ~(8'b00001001) + 8'b10000000;
                19'b0000000001000000000: exponent = ~(8'b00001010) + 8'b10000000;
                19'b0000000000100000000: exponent = ~(8'b00001011) + 8'b10000000;
                19'b0000000000010000000: exponent = ~(8'b00001100) + 8'b10000000;
                19'b0000000000001000000: exponent = ~(8'b00001101) + 8'b10000000;
                19'b0000000000000100000: exponent = ~(8'b00001110) + 8'b10000000;
                19'b0000000000000010000: exponent = ~(8'b00001111) + 8'b10000000;
                19'b0000000000000001000: exponent = ~(8'b00010000) + 8'b10000000;
                19'b0000000000000000100: exponent = ~(8'b00010001) + 8'b10000000;
                19'b0000000000000000010: exponent = ~(8'b00010010) + 8'b10000000;
                19'b0000000000000000001: exponent = ~(8'b00010011) + 8'b10000000;
                default: exponent = 8'b0;
            endcase

            fp_reg <= {sign_i, exponent, fractional_i << exponent, 4'b0};
        end
    end
endmodule
