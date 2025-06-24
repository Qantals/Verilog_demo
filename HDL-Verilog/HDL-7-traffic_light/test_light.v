`timescale 1ms/100us

module test;
    reg CLK1K;
    reg nRST;
    wire [6:0] seg;
    wire [5:0] dig;
    wire [7:0] led;

    traffic_light traffic_light(
        .CLK1K(CLK1K),
        .nRST(nRST),
        .seg(seg),
        .dig(dig),
        .led(led)
    );

    initial begin
        CLK1K=0;
        nRST=0;
        #20 nRST=1;
        forever
            #0.5 CLK1K=~CLK1K;
    end

    always begin
        #1000;
        if($time>=1000*100)
            $finish;
    end

endmodule