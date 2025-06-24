`timescale 1ps/1ps
module test();
    reg clk;
    reg rst_n;
    reg [3:0] req;
    reg enable;
    wire [3:0] gnt;
    wire valid;

    round_robin_arbiter_give #(
        .N(4)
    ) u1 (
        .clk(clk),
        .rst_n(rst_n),
        .req(req),
        .enable(enable),
        .gnt(gnt),
        .valid(valid)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // integer i;
    // initial begin
    //     rst_n = 1'b0;
    //     enable = 1'b0;
    //     req = 4'b0000;
    //     #6 rst_n = 1'b1;
    //     for(i = 0; i < 16; i = i + 1) begin
    //         req = i;
    //         enable = 1'b1;
    //         #60 enable = 1'b0;
    //         #10;
    //     end
    // end

    integer i;
    initial begin
        i=0;
        rst_n = 1'b0;
        enable = 1'b0;
        req = 4'b0000;
        #6 rst_n = 1'b1;
        enable = 1'b1;
        while (1) begin
            req = i;
            #10;
            i = {$random} % 16;
        end
    end
    
endmodule
