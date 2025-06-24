`timescale 1ns/1ps
module connect_sum_all (
    input clk,
    input rst_n,
    // input [$clog2(67)-1:0] cnt,
    input [$clog2(68)-1:0] cnt,

    input signed [20:0] dot_D1,
    input signed [20:0] dot_D2,
    input signed [20:0] dot_D3,

    output reg [7:0] ans_reg
);

    wire signed [20:0] sum_all;
    assign sum_all = dot_D1 + dot_D2 + dot_D3;

    // compress
    wire [7:0] compress;
    compress_utility #(
        .SUM_WIDTH(21)
    ) u_conv_3x3_compress_D3(
        .sum_accum(sum_all),
        .ans(compress)
    );

    // register
    always @(posedge clk, negedge rst_n) begin
        if(~rst_n)
            ans_reg <= 0;
        // else if(cnt == 67)
        else if(cnt == 68)
            ans_reg <= compress;
    end

endmodule
