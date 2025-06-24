`timescale 1ns/1ps
module conv_module (
    // input clk,
    // input rst_n,
    input [8*8*1*8-1:0] data_lin,
    input [3*3*3*8-1:0] weight_lin,
    output [6*6*3*8-1:0] conv_lin
);
    integer i;
    genvar r,c,d,j;



    // get dot product
    wire [6*6*3*3*3*16-1:0] dot_ans;
    generate
        // r,c are coordinates of the left upper element
        for(d = 0; d <= 2; d = d + 1) begin:block_conv_dot8_9_d
            for(r = 0; r <= 5; r = r + 1) begin:block_conv_dot8_9_r
                for(c = 0; c <= 5; c = c + 1) begin:block_conv_dot8_9_c
                    // one for 3x3 matrix dot product
                    dot8_9 u_dot8_9(
                        .data0(data_lin[(r*8+c   )*8 +: 8]),
                        .data1(data_lin[(r*8+c+1 )*8 +: 8]),
                        .data2(data_lin[(r*8+c+2 )*8 +: 8]),
                        .data3(data_lin[(r*8+c+8 )*8 +: 8]),
                        .data4(data_lin[(r*8+c+9 )*8 +: 8]),
                        .data5(data_lin[(r*8+c+10)*8 +: 8]),
                        .data6(data_lin[(r*8+c+16)*8 +: 8]),
                        .data7(data_lin[(r*8+c+17)*8 +: 8]),
                        .data8(data_lin[(r*8+c+18)*8 +: 8]),
                        .weight0(weight_lin[(d*9  )*8 +: 8]),
                        .weight1(weight_lin[(d*9+1)*8 +: 8]),
                        .weight2(weight_lin[(d*9+2)*8 +: 8]),
                        .weight3(weight_lin[(d*9+3)*8 +: 8]),
                        .weight4(weight_lin[(d*9+4)*8 +: 8]),
                        .weight5(weight_lin[(d*9+5)*8 +: 8]),
                        .weight6(weight_lin[(d*9+6)*8 +: 8]),
                        .weight7(weight_lin[(d*9+7)*8 +: 8]),
                        .weight8(weight_lin[(d*9+8)*8 +: 8]),
                        .dot0(dot_ans[((d*6*6+r*6+c)*9  )*16 +: 16]),
                        .dot1(dot_ans[((d*6*6+r*6+c)*9+1)*16 +: 16]),
                        .dot2(dot_ans[((d*6*6+r*6+c)*9+2)*16 +: 16]),
                        .dot3(dot_ans[((d*6*6+r*6+c)*9+3)*16 +: 16]),
                        .dot4(dot_ans[((d*6*6+r*6+c)*9+4)*16 +: 16]),
                        .dot5(dot_ans[((d*6*6+r*6+c)*9+5)*16 +: 16]),
                        .dot6(dot_ans[((d*6*6+r*6+c)*9+6)*16 +: 16]),
                        .dot7(dot_ans[((d*6*6+r*6+c)*9+7)*16 +: 16]),
                        .dot8(dot_ans[((d*6*6+r*6+c)*9+8)*16 +: 16])
                    );
                end
            end
        end
    endgenerate




    // signed expand width
    wire [6*6*3*3*3*20-1:0] expand_ans;
    generate
        for(j = 0; j <= 6*6*3*3*3-1; j = j + 1) begin:block_conv_expand20
            expand20 u_expand20(
                .dot(dot_ans[j*16 +: 16]),
                .expand(expand_ans[j*20 +: 20])
            );
        end
    endgenerate



    // get convolution(sum up)
    wire [6*6*3*20-1:0] sum_ans;
    // generate
    //     for(d = 0; d <= 2; d = d + 1) begin
    //         for(r = 0; r <= 2; r = r + 1) begin
    //             for(c = 0; c <= 2; c = c + 1) begin
    //                 sum20_9 u_sum20_9(
    //                     .expand0(expand_ans[((d*6*6+r*6+c)*9  )*20 +: 20]),
    //                     .expand1(expand_ans[((d*6*6+r*6+c)*9+1)*20 +: 20]),
    //                     .expand2(expand_ans[((d*6*6+r*6+c)*9+2)*20 +: 20]),
    //                     .expand3(expand_ans[((d*6*6+r*6+c)*9+3)*20 +: 20]),
    //                     .expand4(expand_ans[((d*6*6+r*6+c)*9+4)*20 +: 20]),
    //                     .expand5(expand_ans[((d*6*6+r*6+c)*9+5)*20 +: 20]),
    //                     .expand6(expand_ans[((d*6*6+r*6+c)*9+6)*20 +: 20]),
    //                     .expand7(expand_ans[((d*6*6+r*6+c)*9+7)*20 +: 20]),
    //                     .expand8(expand_ans[((d*6*6+r*6+c)*9+8)*20 +: 20]),
    //                     .sum(sum_ans[(d*6*6+r*6+c)*20 +: 20])
    //                 );
    //             end
    //         end
    //     end
    // endgenerate
    generate
        for(j = 0; j <= 6*6*3-1; j = j + 1) begin:block_conv_sum20_9
            sum20_9 u_sum20_9(
                .expand0(expand_ans[(j*9  )*20 +: 20]),
                .expand1(expand_ans[(j*9+1)*20 +: 20]),
                .expand2(expand_ans[(j*9+2)*20 +: 20]),
                .expand3(expand_ans[(j*9+3)*20 +: 20]),
                .expand4(expand_ans[(j*9+4)*20 +: 20]),
                .expand5(expand_ans[(j*9+5)*20 +: 20]),
                .expand6(expand_ans[(j*9+6)*20 +: 20]),
                .expand7(expand_ans[(j*9+7)*20 +: 20]),
                .expand8(expand_ans[(j*9+8)*20 +: 20]),
                .sum(sum_ans[j*20 +: 20])
            );
        end
    endgenerate


    // compress every bit
    wire [6*6*3*8-1:0] compress_ans;
    generate
        for(j = 0; j <= 6*6*3-1; j = j + 1) begin:block_conv_compress12
            compress12 u_compress12(
                .sum(sum_ans[(j*20+8) +: 12]),
                .compress(compress_ans[j*8 +: 8])
            );
        end
    endgenerate

    assign conv_lin = compress_ans;


endmodule
