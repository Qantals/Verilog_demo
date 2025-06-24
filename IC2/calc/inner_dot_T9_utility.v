`timescale 1ns/1ps
module inner_dot_T9_utility #(
    parameter SUM_WIDTH = 20
)(
    input clk,
    input rst_n,
    input en,
    input accum_clr,
    input signed [7:0] data,
    input signed [7:0] weight,
    output signed [SUM_WIDTH-1:0] ans
);

    wire signed [15:0] product;
    assign product = data * weight;


    reg signed [SUM_WIDTH-1:0] sum_accum;
    always @(posedge clk, negedge rst_n) begin
        if(~rst_n)
            sum_accum <= 0;
        else if(en) begin
            if(accum_clr)  // cnt == 0
                sum_accum <= product;
            else
                sum_accum <= sum_accum + product;
        end
    end

    // assign ans = ($signed(sum_accum[19:8]) > 127) ? 8'd127 : (($signed(sum_accum[19:8]) < -128) ? -8'd128 : $signed(sum_accum[15:8]));
    assign ans = sum_accum;

endmodule