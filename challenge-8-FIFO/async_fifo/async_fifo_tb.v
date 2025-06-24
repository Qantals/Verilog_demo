`timescale 1ps/1fs
module test ();
    parameter DEEPWID = 3;
    parameter BITWID = 5;

    reg wclk,rclk;
    reg rst_n;
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

    async_fifo #(
        .DEEPWID(DEEPWID),
        .BITWID(BITWID)
    ) u_async_fifo (
        .wclk(wclk),
        .rclk(rclk),
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
        wclk = 1'b0;
        forever #5 wclk = ~wclk;
    end
    initial begin
        rclk = 1'b0;
        #0.3;
        forever #10 rclk = ~rclk;
    end

    integer i,j;
    initial begin
        rst_n = 1'b0;
        wr_en = 1'b0;
        wr_data = 0;
        cfg_almost_full = 1;
        cfg_almost_empty = 2;
        #6 rst_n = 1'b1;
        wr_en = 1'b1;
        for(i = 0; i < 32; i = i + 1) begin
            wr_data = i;
            #10;
        end
        wr_en = 1'b0;
    end
    initial begin
        rd_en = 1'b0;
        #0.3;
        #11;
        #100 rd_en = 1'b1;
        #1000 rd_en = 1'b0;
    end

endmodule
