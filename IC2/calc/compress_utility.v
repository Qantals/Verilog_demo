`timescale 1ns/1ps
// `define COMPRESS_NORMAL
module compress_utility #(
    parameter SUM_WIDTH = 20
)(
    input signed [SUM_WIDTH-1:0] sum_accum,
    output reg signed [7:0] ans
);

    `ifdef COMPRESS_NORMAL
    // normal(mux X2)
    assign ans = ($signed(sum_accum[SUM_WIDTH-1:8]) > 127) ? 8'd127 : (($signed(sum_accum[SUM_WIDTH-1:8]) < -128) ? -8'd128 : $signed(sum_accum[15:8]));
    
    `else
    // speed?(mux X1)
    wire gt,lt;
    assign gt = ($signed(sum_accum[SUM_WIDTH-1:8]) > 127);
    assign lt = ($signed(sum_accum[SUM_WIDTH-1:8]) < -128);
    always @(*) begin
        case ({gt, lt})
            {1'd1, 1'd0}: ans =  8'd127;
            {1'd0, 1'd1}: ans =  -8'd128;
            default: ans = $signed(sum_accum[15:8]);
        endcase
    end

    `endif

endmodule
