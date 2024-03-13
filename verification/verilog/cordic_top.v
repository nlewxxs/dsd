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

    reg signed [N_ITERATIONS-1:0] [WORD_LENGTH-1:0] alphas; // arctan lookup table
    reg [4:0] iteration; // current iteration

    // current values
    reg signed [WORD_LENGTH-1:0] x;
    reg signed [WORD_LENGTH-1:0] y;
    reg signed [WORD_LENGTH-1:0] z;
    reg signed [WORD_LENGTH-1:0] alpha;

    // wires
    wire signed [WORD_LENGTH-1:0] next_x;
    wire signed [WORD_LENGTH-1:0] next_y;
    wire signed [WORD_LENGTH-1:0] next_z;

    reg signed [WORD_LENGTH-1:0] working_z; // the angle the cordic function is currently calculating

    reg [1:0] state; // 2'b0 - waiting, 2'b01 - calculating, 2'b11 - done;

    assign out = (state == 2'b11) ? next_x : out;
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
        alphas[0]  = 21'b00_1100100100110110110;
        alphas[1]  = 21'b00_0111111010000011010;
        alphas[2]  = 21'b00_0011110011001111110;
        alphas[3]  = 21'b00_0001111110011011111;
        alphas[4]  = 21'b00_0000111110100101001;
        alphas[5]  = 21'b00_0000011111011010100;
        alphas[6]  = 21'b00_0000001111110111011;
        alphas[7]  = 21'b00_0000000111111000000;
        alphas[8]  = 21'b00_0000000011111100000;
        alphas[9]  = 21'b00_0000000001111110000;
        alphas[10] = 21'b00_0000000000111111000;
        alphas[11] = 21'b00_0000000000011111100;
        alphas[12] = 21'b00_0000000000001111110;
        alphas[13] = 21'b00_0000000000000111111;
        alphas[14] = 21'b00_0000000000000011111;
        alphas[15] = 21'b00_0000000000000001111;
        alphas[16] = 21'b00_0000000000000000111;
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

