module mac4_element #(
    parameter DATA_W = 8,
    parameter PROD_W = 2*DATA_W,
    parameter SUM_W  = PROD_W + 2     // enough for 4-term accumulation
)(
    input  wire                     clk,
    input  wire                     rst,        // synchronous
    input  wire                     ce,         // clock enable
    input  wire                     valid_in,

    input  wire signed [DATA_W-1:0] a0, a1, a2, a3,
    input  wire signed [DATA_W-1:0] b0, b1, b2, b3,

    output reg  signed [SUM_W-1:0]  c_out,
    output reg                      valid_out
);

    // ==================================================
    // Pipeline Stage 1 : Multiplication
    // ==================================================
    reg signed [PROD_W-1:0] p0_s1, p1_s1, p2_s1, p3_s1;
    reg valid_s1;

    always @(posedge clk) begin
        if (rst) begin
            valid_s1 <= 1'b0;
        end else if (ce) begin
            p0_s1 <= a0 * b0;   // DSP inferred
            p1_s1 <= a1 * b1;
            p2_s1 <= a2 * b2;
            p3_s1 <= a3 * b3;
            valid_s1 <= valid_in;
        end
    end


    // ==================================================
    // Pipeline Stage 2 : First-Level Adder Tree
    // ==================================================
    reg signed [PROD_W:0] sum0_s2, sum1_s2;  // +1 bit
    reg valid_s2;

    always @(posedge clk) begin
        if (rst) begin
            valid_s2 <= 1'b0;
        end else if (ce) begin
            sum0_s2 <= p0_s1 + p1_s1;
            sum1_s2 <= p2_s1 + p3_s1;
            valid_s2 <= valid_s1;
        end
    end


    // ==================================================
    // Pipeline Stage 3 : Final Add
    // ==================================================
    reg valid_s3;

    always @(posedge clk) begin
        if (rst) begin
            c_out    <= {SUM_W{1'b0}};
            valid_s3 <= 1'b0;
        end else if (ce) begin
            c_out    <= sum0_s2 + sum1_s2;
            valid_s3 <= valid_s2;
        end
    end


    // Output valid aligned with data
    always @(posedge clk) begin
        if (rst)
            valid_out <= 1'b0;
        else if (ce)
            valid_out <= valid_s3;
    end

endmodule
