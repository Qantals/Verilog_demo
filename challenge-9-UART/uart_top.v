`timescale 1ns/1ps
module uart_top ();
    parameter DATA_WIDTH = 7;
    parameter PARITY_ON = 0;
    // parameter PARITY_ODD = 1;
    parameter STOP_BIT = 1;

    parameter CLK_FREQ = 100_000_000;
    parameter BAUD_RATE = 9600;

    reg clk;
    reg rst_n;
    reg [DATA_WIDTH-1:0] data_pkg_in;
    reg en_tx;

    wire [DATA_WIDTH-1:0] data_pkg_out;
    wire clk_tx;
    wire clk_rx;
    wire data_line;
    wire done_tx;
    wire done_rx;
    wire prity_vld_rx;

    uart_tx #(
        .DATA_WIDTH(DATA_WIDTH),
        .PARITY_ON(PARITY_ON),
        .PARITY_ODD(1),
        .STOP_BIT(STOP_BIT)
    ) u_tx (
        .clk(clk_tx),
        .rst_n(rst_n),
        .data_pkg(data_pkg_in),
        .en(en_tx),
        .tx(data_line),
        .done(done_tx)
    );

    uart_rx #(
        .DATA_WIDTH(DATA_WIDTH),
        .PARITY_ON(PARITY_ON),
        .PARITY_ODD(0),
        .STOP_BIT(STOP_BIT)
    ) u_rx (
        .clk(clk_rx),
        .rst_n(rst_n),
        .rx(data_line),
        .data_pkg(data_pkg_out),
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

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    integer i;
    initial begin
        while (1) begin
            rst_n = 1'b0;
            en_tx = 1'b0;
            for(i = 0; i < DATA_WIDTH; i = i + 1)
                data_pkg_in[i] = $random;
            #25000;
            rst_n = 1'b1;
            en_tx = 1'b1;
            @(u_tx.state_cur == u_tx.STOP_S);
            #1;
            en_tx = 1'b0;
            @(u_rx.state_cur == u_rx.IDLE_S);
            #1;
            for(i = 0; i < 2; i = i + 1)
                @(posedge clk_tx);
            @(negedge clk_tx);
        end
    end

endmodule
