`timescale 1ns/1ps
module connect_inner_dot (
    input clk,
    input rst_n,
    input in_vld,
    // input [$clog2(67)-1:0] cnt,
    input [$clog2(68)-1:0] cnt,

    input [7:0] data_c0,
    input [7:0] data_c1,
    input [7:0] data_c2,

    input [7:0] weight0,
    input [7:0] weight1,
    input [7:0] weight2,
    input [7:0] weight3,
    input [7:0] weight4,
    input [7:0] weight5,
    input [7:0] weight6,
    input [7:0] weight7,
    input [7:0] weight8,

    output [20:0] dot
);

    wire accum_clr;
    // assign accum_clr = (cnt == 30);
    assign accum_clr = (cnt == 31);

    wire en;
    // assign en = (cnt==30 || cnt==32 || cnt==34 || cnt==46 || cnt==48 || cnt==50 || cnt==62 || cnt==64 || cnt==66);
    assign en = (cnt==31 || cnt==33 || cnt==35 || cnt==47 || cnt==49 || cnt==51 || cnt==63  || cnt==65 || cnt==67) && in_vld;

    reg [7:0] data_in;
    always @(*) begin
        case (cnt)
            // 30,46,62: data_in = data_c0;
            // 32,48,64: data_in = data_c1;
            // 34,50,66: data_in = data_c2;
            31,47,63: data_in = data_c0;
            33,49,65: data_in = data_c1;
            35,51,67: data_in = data_c2;
            default: data_in = 0;
        endcase
    end

    reg [7:0] weight_in;
    always @(*) begin
        case (cnt)
            // 30: weight_in = weight0;
            // 32: weight_in = weight1;
            // 34: weight_in = weight2;
            // 46: weight_in = weight3;
            // 48: weight_in = weight4;
            // 50: weight_in = weight5;
            // 62: weight_in = weight6;
            // 64: weight_in = weight7;
            // 66: weight_in = weight8;
            31: weight_in = weight0;
            33: weight_in = weight1;
            35: weight_in = weight2;
            47: weight_in = weight3;
            49: weight_in = weight4;
            51: weight_in = weight5;
            63: weight_in = weight6;
            65: weight_in = weight7;
            67: weight_in = weight8;
            default: weight_in = 0;
        endcase
    end
    

    inner_dot_T9_utility #(
        .SUM_WIDTH(21)
    ) u_connect_inner_dot_T9 (
        .clk(clk),
        .rst_n(rst_n),
        .en(en),
        .accum_clr(accum_clr),
        .data(data_in),
        .weight(weight_in),
        .ans(dot)
    );

endmodule
