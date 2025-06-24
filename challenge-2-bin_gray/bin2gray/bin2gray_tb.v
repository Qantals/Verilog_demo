`timescale 1ps/1ps
module test_4#(
    parameter N=4
)(

);
    reg [3:0] bin_4;
    wire [3:0] gray_4;
    reg [N-1:0] bin_N;
    wire [N-1:0] gray_N;

    bin2gray_4 u_4 (
        .bin(bin_4),
        .gray(gray_4)
    );

    bin2gray_N #(
        .N(N)
    ) u_N (
        .bin(bin_N),
        .gray(gray_N)
    );

    initial begin
        bin_4 = 0;
        while(bin_4 <= 15)
            #10 bin_4 = bin_4 + 1;
    end

    initial begin
        bin_N = 0;
        while(bin_N <= 2**N-1)
            #10 bin_N = bin_N + 1;
    end

    wire check;
    assign check = bin_N == bin_4;

endmodule
