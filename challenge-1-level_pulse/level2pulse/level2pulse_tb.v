`timescale 1ps/1ps

module test();
    reg clk;
    reg rst_n;
    reg data_in;
    wire rise;
    wire fall;
    wire double;

    level2pulse u1(
        .clk(clk),
        .rst_n(rst_n), 
        .data_in(data_in), 
        .rise(rise), 
        .fall(fall), 
        .double(double)
    );

    initial begin
        clk = 1'b1;
        forever #5 clk = ~clk;
    end

    initial begin
        rst_n = 1'b0;
        data_in = 1'b0;
        #5 rst_n = 1'b1;
        data_in = 1'b1;
        #40 data_in = ~data_in;
        #20 data_in = ~data_in;
        #30 data_in = ~data_in;
        #30 data_in = ~data_in;
    end
    
endmodule
