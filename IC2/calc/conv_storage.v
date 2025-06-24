`timescale 1ns/1ps
module conv_storage (
    input clk,
    input rst_n,
    input in_vld,
    // input [$clog2(67)-1:0] cnt,
    input [$clog2(68)-1:0] cnt,
    input [7:0] ans_D1,
    input [7:0] ans_D2,
    input [7:0] ans_D3,
    output reg [7:0] conv_D1_reg,
    output reg [7:0] conv_D2_reg,
    output reg [7:0] conv_D3_reg
);


    always @(posedge clk, negedge rst_n) begin
        if(~rst_n) begin
            conv_D1_reg <= 0;
            conv_D2_reg <= 0;
            conv_D3_reg <= 0;
        end
        // else if((cnt>=19 && cnt<=24) ||
        //         (cnt>=27 && cnt<=32) ||
        //         (cnt>=35 && cnt<=40) ||
        //         (cnt>=43 && cnt<=48) ||
        //         (cnt>=51 && cnt<=56) ||
        //         (cnt>=59 && cnt<=64)) begin
        else if(((cnt>=20 && cnt<=25) ||
                (cnt>=28 && cnt<=33) ||
                (cnt>=36 && cnt<=41) ||
                (cnt>=44 && cnt<=49) ||
                (cnt>=52 && cnt<=57) ||
                (cnt>=60 && cnt<=65)) && in_vld) begin
            conv_D1_reg <= ans_D1;
            conv_D2_reg <= ans_D2;
            conv_D3_reg <= ans_D3;
        end
    end


endmodule
