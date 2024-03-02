module fp_to_fixed (
    input [31:0] fp_i,
    output reg [31:0] fixed_o
);
    // we define the FP representation according to the IEEE-754 standard
    // and extract the exponent and significand.
    reg [7:0] exponent = fp_i[30:23];
    reg [22:0] mantissa = fp_i[22:0];
    // initialise fixed using sign extension

    // an asynchronous shift cascade that multiplies by the exponent
    always @(*) begin
        // alas these have to be blocking statements to prevent a big mess
        reg [7:0] real_exponent;
        reg [31:0] whole = 1;
        reg [22:0] significand = mantissa;
        real_exponent = exponent - 127;
        $display("exp now: %b\n", real_exponent);

        if (real_exponent[0] == 1) begin
            whole = {whole[30:0], significand[22]};
            significand = significand << 1;
            $display("whole now: %b\n", whole);
            $display("significand now: %b\n", significand);
        end
        if (real_exponent[1] == 1) begin
            whole = {whole[29:0], significand[22:21]};
            significand = significand << 2;
            $display("whole now: %b\n", whole);
            $display("significand now: %b\n", significand);
        end
        if (real_exponent[2] == 1) begin
            whole = {whole[27:0], significand[22:19]};
            significand = significand << 4;
            $display("whole now: %b\n", whole);
            $display("significand now: %b\n", significand);
        end
        if (real_exponent[3] == 1) begin
            whole = {whole[23:0], significand[22:15]};
            significand = significand << 8;
            $display("whole now: %b\n", whole);
            $display("significand now: %b\n", significand);
        end
        // if (real_exponent[4]) whole = {whole[30:0], significand[22]}; significand << 16;
        // if (real_exponent[5]) whole = {whole[30:0], significand[22]}; significand << 32;
        // if (real_exponent[6]) whole = {whole[30:0], significand[22]}; significand << 64;
        // if (real_exponent[7]) whole = {whole[30:0], significand[22]}; significand << 128;

        // temp = real_exponent[0] ? temp << 1 : temp;
        // temp = real_exponent[1] ? temp << 2 : temp;
        // temp = real_exponent[2] ? temp << 4 : temp;
        // temp = real_exponent[3] ? temp << 8 : temp;
        // temp = real_exponent[4] ? temp << 16 : temp;
        // temp = real_exponent[5] ? temp << 32 : temp;
        // temp = real_exponent[6] ? temp << 64 : temp;
        // temp = real_exponent[7] ? temp << 128 : temp;
        // final output is only assigned at the end to ensure that intermediate
        // versions are not accidentally read.
        fixed_o = whole;
    end
endmodule;
