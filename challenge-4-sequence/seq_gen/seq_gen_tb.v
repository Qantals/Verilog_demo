`timescale 1ps/1ps
module test();
    reg clk,rst_n,load;
    reg [5:0] din;
    wire dout_shift,dout_fsm,dout_min;

    gen_shift u1(
        .clk(clk),
        .rst_n(rst_n),
        .load(load),
        .din(din),
        .dout(dout_shift)
    );
    gen_fsm u2(
        .clk(clk),
        .rst_n(rst_n),
        .din(din),
        .dout(dout_fsm)
    );
    gen_min u3(
        .clk(clk),
        .rst_n(rst_n),
        .dout(dout_min)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst_n = 1'b0;
        load = 1'b1;
        din = 6'b001011;
        #10 rst_n = 1'b1;
        #10 load = 1'b0;
        // #60 din = 6'b101010;
        // load = 1'b1;
        // #10 load = 1'b0;
    end
endmodule
