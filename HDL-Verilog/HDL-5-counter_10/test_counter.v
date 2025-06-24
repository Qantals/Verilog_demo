`timescale 1ms/1ms

module test;

    reg rst;
    reg en;
    reg clk1k;
    wire [6:0] seg;
    wire dig;

    counter_10 count_10(
        .rst(rst),
        .en(en),
        .clk1k(clk1k),
        .seg(seg),
        .dig(dig)
    );

    //clk1k generate
    initial begin
        clk1k=0;
        #10;
        forever begin
            clk1k = ~clk1k;
            #1;
        end
    end

    //rst and en
    initial begin
        rst=1;  en=0;
        #5;
        rst=0;  en=1;
        #2000;
        rst=0;  en=0;
        #4000;
        rst=1;  en=0;
        #1000;
        rst=0;  en=0;
        #3000;
        rst=0;  en=1;
    end

    //finish time
    always begin
        #500;
        if($time>=500*40)
            $finish;
    end

endmodule