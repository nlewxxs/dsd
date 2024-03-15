module cordic_top #(
    parameter WORD_LENGTH = 21,
    parameter N_ITERATIONS = 17
)(
    input clk,
    input rst,
    // all inputs and outputs signed fixed-point
    input signed [WORD_LENGTH-1:0] in,
    output signed [WORD_LENGTH-1:0] out
);
    // since we know the number of iterations beforehand, we can hardcode the starting x and ys.
    localparam x0 = 21'b00_1001101101110100111; // 1/K
    localparam y0 = 0;

    reg signed [WORD_LENGTH-1:0] alphas [N_ITERATIONS-1:0]; // arctan lookup table
    reg [4:0] iteration; // current iteration

    // current values
    reg signed [WORD_LENGTH-1:0] x;
    reg signed [WORD_LENGTH-1:0] y;
    reg signed [WORD_LENGTH-1:0] z;
    wire signed [WORD_LENGTH-1:0] alpha;

    // wires
    wire signed [WORD_LENGTH-1:0] next_x;
    wire signed [WORD_LENGTH-1:0] next_y;
    wire signed [WORD_LENGTH-1:0] next_z;

    reg signed [WORD_LENGTH-1:0] working_z; // the angle the cordic function is currently calculating

    reg [1:0] state; // 2'b0 - waiting, 2'b01 - calculating, 2'b11 - done;

    assign out = (state == 2'b11) ? x : out;
    assign alpha = alphas[iteration];

    always @(posedge clk) begin
        x <= (state == 2'b0) ? x0 : next_x;
        y <= (state == 2'b0) ? y0 : next_y;
        z <= (state == 2'b0) ? in : next_z;
    end

    // FSM implementation
    always @(posedge clk) begin
        case (state)
            2'b00: begin
                // waiting for new input
                if (in != working_z) begin
                    working_z <= in;
                    state <= 2'b01;
                end
            end
            2'b01: begin
                // calculating value. Ignore input changes at this time.
                if (iteration < N_ITERATIONS) begin
                    iteration <= iteration + 5'b00001;
                end
                else begin
                    state <= 2'b11;
                    iteration <= 5'b0;
                end
            end
            2'b11: begin
                // Done with calculation
                state <= 2'b0;
            end
            default: state <= 2'b0;
        endcase
    end

    /* Instantiate the arctan lookup table (this needs to be manually changed if parameters are changed,
    since we are using a LUT implementation for this)
    we keep only one copy of this in the top module, because keeping a LUT inside each iteration block
    would be expensive. (for folded no difference because only one iteration block, but for unfolded
    this would be an issue. Thinking ahead) */

    initial begin
        alphas[0]  = 21'b00_1100100100001111111;    // 0.7853984832763671875
        alphas[1]  = 21'b00_0111011010110001101;    // 0.4636478424072265625
        alphas[2]  = 21'b00_0011111010110110111;    // 0.2449779510498046875
        alphas[3]  = 21'b00_0001111111010101110;    // 0.124355316162109375
        alphas[4]  = 21'b00_0000111111111010101;    // 0.0624179840087890625
        alphas[5]  = 21'b00_0000011111111111011;    // 0.0312404632568359375
        alphas[6]  = 21'b00_0000001111111111111;    // 0.0156230926513671875
        alphas[7]  = 21'b00_0000001000000000000;    // 0.0078125
        alphas[8]  = 21'b00_0000000100000000000;    // 0.00390625
        alphas[9]  = 21'b00_0000000010000000000;    // 0.001953125
        alphas[10] = 21'b00_0000000001000000000;    // 0.0009765625
        alphas[11] = 21'b00_0000000000100000000;    // 0.00048828125
        alphas[12] = 21'b00_0000000000010000000;    // 0.000244140625
        alphas[13] = 21'b00_0000000000001000000;    // 0.0001220703125
        alphas[14] = 21'b00_0000000000000100000;    // 0.00006103515625
        alphas[15] = 21'b00_0000000000000010000;    // 0.000030517578125
        alphas[16] = 21'b00_0000000000000001000;    // 0.0000152587890625
   end

    /* if the input changes, we start counting the number of clock cycles.
    Once the number of clock cycles reaches the number of iterations and the input has stayed constant
    during this time, we set the valid bit high for one cycle indicating the the output is ready. */

    cordic cordic(
        .rst(rst),
        .x_i(x),
        .y_i(y),
        .z_i(z),
        .alpha_i(alpha),
        .iteration_i(iteration),
        .next_x_o(next_x),
        .next_y_o(next_y),
        .next_z_o(next_z)
    );

endmodule

