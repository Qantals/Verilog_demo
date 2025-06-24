`timescale 1ns/1ps
module pool_module (
    // input clk,
    // input rst_n,
    input [6*6*3*8-1:0] conv_lin,
    output [3*3*3*8-1:0] pool_lin
);
    genvar r,c,d;


    // get max
    wire [3*3*3*8-1:0] max_ans;
    generate
        // r,c are coordinates of the left upper element
        for(d = 0; d <= 2; d = d + 1) begin:block_pool_max8_4_d
            for(r = 0; r <= 2; r = r + 1) begin:block_pool_max8_4_r
                for(c = 0; c <= 2; c = c + 1) begin:block_pool_max8_4_c
                    // one for 2x2 matrix pool
                    max8_4 u_max8_4(
                        .conv0(conv_lin[(d*6*6+(r*6+c)*2  )*8 +: 8]),
                        .conv1(conv_lin[(d*6*6+(r*6+c)*2+1)*8 +: 8]),
                        .conv2(conv_lin[(d*6*6+(r*6+c)*2+6)*8 +: 8]),
                        .conv3(conv_lin[(d*6*6+(r*6+c)*2+7)*8 +: 8]),
                        .max(max_ans[(d*3*3+r*3+c)*8 +: 8])
                    );
                end
            end
        end
    endgenerate

    assign pool_lin = max_ans;

endmodule
