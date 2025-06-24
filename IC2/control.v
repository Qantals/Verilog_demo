`timescale 1ns/1ps
module control (
    input clk,
    input rst_n,
    input in_vld,

    // output reg [$clog2(67)-1:0] cnt,
    output reg [$clog2(68)-1:0] cnt,
    output reg out_data_flag
);

    reg [2:0] cnt_side;
    always @(posedge clk, negedge rst_n) begin
        if(~rst_n)
            cnt <= 0;
        else if(cnt == 68) begin
            if(in_vld)
                cnt <= cnt_side + 1;
            else
                cnt <= {4'b0000, cnt_side};
        end
        else if(cnt >= 64)
            cnt <= cnt + 1;
        else if(in_vld)
            cnt <= cnt + 1;
    end

    always @(posedge clk, negedge rst_n) begin
        if(~rst_n)
            cnt_side <= 0;
        else if(cnt >= 64) begin
            if(in_vld)
                cnt_side <= cnt_side + 1;
            else
                cnt_side <= cnt_side;
        end
        else
            cnt_side <= 0;
    end

    always @(posedge clk, negedge rst_n) begin
        if(~rst_n)
            out_data_flag <= 0;
        // else if(cnt == 67)
        else if(cnt == 68)
            out_data_flag <= 1;
        else
            out_data_flag <= 0;
    end

endmodule
