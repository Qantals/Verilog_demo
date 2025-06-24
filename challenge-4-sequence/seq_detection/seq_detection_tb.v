`timescale 1ps/1ps
module test();
    reg clk,rst_n,data;
    wire result_cover,result_noncover;

    // seq_detection_cover_Mealy u1(
    //     .clk(clk),
    //     .rst_n(rst_n),
    //     .data(data),
    //     .result(result_cover)
    // );
    // seq_detection_noncover_Mealy u2(
    //     .clk(clk),
    //     .rst_n(rst_n),
    //     .data(data),
    //     .result(result_noncover)
    // );

    seq_detection_cover_Moore u1(
        .clk(clk),
        .rst_n(rst_n),
        .data(data),
        .result(result_cover)
    );
    seq_detection_noncover_Moore u2(
        .clk(clk),
        .rst_n(rst_n),
        .data(data),
        .result(result_noncover)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst_n = 1'b0;
        data = 1'b1;
        #6 rst_n = 1'b1;
        #10 data = 1'b0;
        #10 data = 1'b1;
        #10 data = 1'b0;
        #10 data = 1'b1;
        #10 data = 1'b1;
        #10 data = 1'b1;
    end
endmodule
