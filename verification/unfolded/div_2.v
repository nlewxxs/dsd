module div_2 (
    // input and output in IEEE-754 format
    input [31:0] in,
    output [31:0] out
);
    // halving a FP number is the same as just subtracting one from the exponent
    reg [7:0] modified_exponent;
    assign out = {in[31], modified_exponent, in[22:0]};

    always @(*) begin
        modified_exponent = in[30:23] - 8'b00000001;
    end

endmodule

