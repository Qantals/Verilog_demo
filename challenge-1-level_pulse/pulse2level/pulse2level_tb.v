`timescale 1ps/1ps

module test();
    reg clk;
    reg rst_n;
    reg start;
    reg stop;
    wire level;


    pulse2level u1(
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .stop(stop),
        .level(level)
    );

    initial begin
        clk = 1'b1;
        forever #5 clk = ~clk;
    end

    initial begin
        rst_n = 1'b0;
        start = 1'b0;
        stop = 1'b0;
        #5 rst_n = 1'b1;
        start = 1'b1;
        #10 start = 1'b0;
        #20 stop = 1'b1;
        #10 stop = 1'b0;

        #20 start = 1'b1;
        #10 start = 1'b0;

        #10 start = 1'b1;
        #10 start = 1'b0;

        #20 stop = 1'b1;
        #10 stop = 1'b0;

        #10 stop = 1'b1;
        #10 stop = 1'b0;

    end
    
endmodule
