`timescale 1ps/1ps
module test ();
    parameter DEEPWID = 3;
    parameter BITWID = 5;

    reg clk,rst_n;
    reg wr_en;
    reg rd_en;
    reg [BITWID-1:0] wr_data;
    wire [BITWID-1:0] rd_data;
    reg [DEEPWID-1:0] cfg_almost_full;
    reg [DEEPWID-1:0] cfg_almost_empty;

    wire rd_data_vld;
    wire full;
    wire empty;
    wire almost_full;
    wire almost_empty;
    wire [DEEPWID:0] fifo_num;

    sync_fifo #(
        .DEEPWID(DEEPWID),
        .BITWID(BITWID)
    ) u_sync_fifo (
        .clk(clk),
        .rst_n(rst_n),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .wr_data(wr_data),
        .rd_data(rd_data),
        .cfg_almost_full(cfg_almost_full),
        .cfg_almost_empty(cfg_almost_empty),

        .rd_data_vld(rd_data_vld),
        .full(full),
        .empty(empty),
        .almost_full(almost_full),
        .almost_empty(almost_empty),
        .fifo_num(fifo_num)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst_n = 1'b0;
        wr_en = 1'b0;
        rd_en = 1'b0;
        wr_data = 0;
        cfg_almost_full = 1;
        cfg_almost_empty = 2;
        #6 rst_n = 1'b1;
        wr_en = 1'b1;
        wr_data = 3;
        #10 wr_data = 5;
        #10 wr_data = 16;
        #10 wr_data = 28;
        #10 wr_data = 8;
        #10 wr_data = 9;
        #10 wr_data = 14;
        #10 wr_data = 7;
        #10 wr_data = 26;
        #10 wr_data = 30;
        rd_en = 1'b1;
        #10 wr_data = 17;
        #10 wr_data = 4;
        #10 wr_data = 25;
        #10 wr_data = 22;
        #10;
        wr_en = 1'b0;
        #90 rd_en = 1'b0;
    end

    // integer i;
    // initial begin
    //     while (1) begin
    //         rst_n = 1'b0;
    //         wr_en = 1'b0;
    //         rd_en = 1'b0;
    //         wr_data = 0;
    //         cfg_almost_full = {$random} % 8;
    //         cfg_almost_empty = {$random} % 8;
    //         #6 rst_n = 1'b1;
    //         for(i = 0; i < 100; i = i + 1) begin
    //             wr_en = $random;
    //             // wr_data = wr_en ? ({$random} % 32) : z;
    //             wr_data = {$random} % 32;
    //             rd_en = $random;
    //             #10;
    //         end
    //         #50;
    //         @(negedge clk);
    //     end
    // end

endmodule
