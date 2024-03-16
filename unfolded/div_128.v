module div_128 (
    input [31:0] in,
    output reg [31:0] out
);
    // extract exponent and modify it as required
    reg [7:0] modified_exponent;
    assign out = {in[31], modified_exponent, in[22:0]};

    always @(*) begin
        // reduce exponent by 7
        modified_exponent = in[30:23] - 8'b00000111;
    end

endmodule

