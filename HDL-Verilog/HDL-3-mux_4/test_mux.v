`timescale 1ns/1ns

module test;
    wire [3:0] din;
    reg [1:0] sel;
    wire dout;

    mux_4 uut(
        .din(din),
        .sel(sel),
        .dout(dout)
    );

    assign din=4'bxz10;

    integer i;
    initial begin
        for(i=0;i<=3;i=i+1) begin
            sel=i;
            #10;
        end
        $finish;
    end
    
endmodule