module top (
    input clk,
    input rst_n,
    input rx,
    output tx,
    output full_n,
    output empty_n
);
    parameter DEEPWID = 5;
    parameter DATA_WIDTH = 7;
    parameter PARITY_ON = 1;
    parameter PARITY_ODD = 1;
    parameter STOP_BIT = 1;

    parameter CLK_FREQ = 50_000_000;
    parameter BAUD_RATE = 9600;

    wire clk_tx;
    wire clk_rx;
    wire en_tx;
    wire done_tx;
    wire done_rx;
    wire prity_vld_rx;
    wire [DATA_WIDTH-1:0] data_rx;
    wire [DATA_WIDTH-1:0] data_tx;
    // fifo
    wire full;
    wire empty;
    wire rd_en_fifo;

    assign full_n = ~full;
    assign empty_n = ~empty;

    uart_tx #(
        .DATA_WIDTH(DATA_WIDTH),
        .PARITY_ON(PARITY_ON),
        .PARITY_ODD(PARITY_ODD),
        .STOP_BIT(STOP_BIT)
    ) u_tx (
        .clk(clk_tx),
        .rst_n(rst_n),
        .data_pkg(data_tx),
        .en(en_tx),
        .tx(tx),
        .done(done_tx)
    );

    uart_rx #(
        .DATA_WIDTH(DATA_WIDTH),
        .PARITY_ON(PARITY_ON),
        .PARITY_ODD(PARITY_ODD),
        .STOP_BIT(STOP_BIT)
    ) u_rx (
        .clk(clk_rx),
        .rst_n(rst_n),
        .rx(rx),
        .data_pkg(data_rx),
        .prity_vld(prity_vld_rx),
        .done(done_rx)
    );

    baud_gen #(
        .CLK_FREQ(CLK_FREQ),
        .BAUD_RATE(BAUD_RATE)
    ) u_baud_gen (
        .clk(clk),
        .rst_n(rst_n),
        .clk_bps(clk_tx),
        .clk_bps16(clk_rx)
    );

    async_fifo #(
        .DEEPWID(DEEPWID),
        .BITWID(DATA_WIDTH)
    ) u_async_fifo (
        .wclk(clk_rx),
        .rclk(clk_tx),
        .rst_n(rst_n),
        .wr_en(done_rx),
        .rd_en(rd_en_fifo),
        .wr_data(data_rx),
        .rd_data(data_tx),
        .cfg_almost_full({DEEPWID{1'b0}}),
        .cfg_almost_empty({DEEPWID{1'b0}}),

        .rd_data_vld(),
        .full(full),
        .empty(empty),  // clk_tx
        .almost_full(),
        .almost_empty(),
        .fifo_num()
    );

    send_back #(
        .DATA_WIDTH(DATA_WIDTH)
    ) u_send_back (
        .clk_tx(clk_tx),
        .clk_rx(clk_rx),
        .rst_n(rst_n),
        .done_tx(done_tx),
        .done_rx(done_rx),
        .data_rx(data_rx),
        .empty(empty),
        .en_tx(en_tx),
        .rd_en_fifo(rd_en_fifo)
    );

endmodule
