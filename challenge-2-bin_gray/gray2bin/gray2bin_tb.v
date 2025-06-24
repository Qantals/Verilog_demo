`timescale 1ps/1ps
module test_4#(
    parameter N=4
)(

);
    wire [3:0] bin_4;
    reg [3:0] gray_4;
    wire [N-1:0] bin_N;
    reg [N-1:0] gray_N;

    gray2bin_4 u_4 (
        .bin(bin_4),
        .gray(gray_4)
    );

    gray2bin_N #(
        .N(N)
    ) u_N (
        .bin(bin_N),
        .gray(gray_N)
    );

    initial begin
        gray_4 = 0;
        while(gray_4 <= 15)
            #10 gray_4 = gray_4 + 1;
    end

    initial begin
        gray_N = 0;
        while(gray_N <= 2**N-1)
            #10 gray_N = gray_N + 1;
    end

    wire check;
    assign check = gray_N == gray_4;

endmodule
