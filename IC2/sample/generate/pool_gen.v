`timescale 1ns/1ps
module pool_gen;

    reg [6*6*3*8-1:0] conv_lin;
    wire [3*3*3*8-1:0] pool_lin;

    pool_module u_pool_module(
        .conv_lin(conv_lin),
        .pool_lin(pool_lin)
    );


    reg [7:0] conv_mem [6*6*3*100-1:0];
    reg [7:0] pool_mem [3*3*3*100-1:0];
    integer i_c,i_p;
    integer i_pic;

    initial begin
        $readmemb("../sample_100/conv.txt",conv_mem);
        for(i_pic = 0; i_pic <= 100-1; i_pic = i_pic + 1) begin
            for(i_c = 0; i_c <= 6*6*3-1; i_c = i_c + 1) begin
                conv_lin[i_c*8 +: 8] = conv_mem[i_pic*6*6*3+i_c];
            end
            #100;   // depend on your logic delay
            for(i_p = 0; i_p <= 3*3*3-1; i_p = i_p + 1) begin
                pool_mem[i_pic*3*3*3+i_p] = pool_lin[i_p*8 +: 8];
            end
        end
        $writememb("../sample_100/pool.txt",pool_mem);
        $finish;
    end


endmodule
