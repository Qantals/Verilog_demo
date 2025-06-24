`timescale 1ps/1ps
module test();
    reg clk,rst_n;
    wire div_even;

    div_even #(
        .N(6)
    ) u1(
        .clk(clk),
        .rst_n(rst_n),
        .div_even(div_even)
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
