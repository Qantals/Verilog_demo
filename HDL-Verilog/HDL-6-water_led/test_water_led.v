`timescale 1ms/1us

module test;
    reg clk1MHz;
    reg rst;
    wire [7:0] led;

    water_led water_led(
        .rst(rst),
        .clk1MHz(clk1MHz),
        .led(led)
    );

    //clk1MHz generate
    initial begin
        clk1MHz=0;
        #10;
        forever begin
            clk1MHz = ~clk1MHz;
            #0.001;
        end
    end

    //rst generate
    initial begin
        rst=1;
        #5;
        rst=0;
        #6000 rst=1;
        #2000 rst=0;
        #7000 rst=1;
        #4000 rst=0;
    end

    //finish time
    always begin
        #1000;
        if($time>=1000*40)
            $finish;
    end

endmodule