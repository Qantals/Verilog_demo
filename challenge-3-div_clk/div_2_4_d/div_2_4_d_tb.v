`timescale 1ps/1ps
module test();
    reg clk,rst_n;
    wire div_2,div_4;

    div_2_4_d u1(
        .clk(clk),
        .rst_n(rst_n),
        .div_2(div_2),
        .div_4(div_4)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst_n = 1'b0;
        #10 rst_n = 1'b1;
    end

endmodule
