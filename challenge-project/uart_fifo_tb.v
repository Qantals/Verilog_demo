`timescale 1ns/1ns
module test ();
    reg clk;
    reg rst_n;
    reg rx;
    wire tx;
    wire full_n;
    wire empty_n;

    top u_top(
        .clk(clk),
        .rst_n(rst_n),
        .rx(rx),
        .tx(tx),
        .full_n(full_n),
        .empty_n(empty_n)
    );

    reg [63:0] mirror_rx_state_cur,mirror_tx_state_cur;
    always @(u_top.u_rx.state_cur) begin
        case (u_top.u_rx.state_cur)
            u_top.u_rx.IDLE_S: mirror_rx_state_cur = "IDLE";
            u_top.u_rx.START_S: mirror_rx_state_cur = "START";
            u_top.u_rx.DATA_S: mirror_rx_state_cur = "DATA";
            u_top.u_rx.PRITY_S: mirror_rx_state_cur = "PRITY";
            u_top.u_rx.STOP_S: mirror_rx_state_cur = "STOP";
        endcase
    end
    always @(u_top.u_tx.state_cur) begin
        case (u_top.u_tx.state_cur)
            u_top.u_tx.IDLE_S: mirror_tx_state_cur = "IDLE";
            u_top.u_tx.START_S: mirror_tx_state_cur = "START";
            u_top.u_tx.DATA_S: mirror_tx_state_cur = "DATA";
            u_top.u_tx.PRITY_S: mirror_tx_state_cur = "PRITY";
            u_top.u_tx.STOP_S: mirror_tx_state_cur = "STOP";
        endcase
    end

    initial begin
        clk = 1'b0;
        forever #10 clk = ~clk;
    end

    integer i;
    initial begin
        rst_n = 1'b0;
        rx = 1'b1;
        #11 rst_n = 1'b1;
        @(posedge u_top.clk_tx);
        @(posedge u_top.clk_tx);
        @(posedge u_top.clk_tx);
        #1 rx = 0;
        @(posedge u_top.clk_tx);
        #1 rx = 1;
        @(posedge u_top.clk_tx);
        @(posedge u_top.clk_tx);
        @(posedge u_top.clk_tx);
        @(posedge u_top.clk_tx);
        @(posedge u_top.clk_tx);
        @(posedge u_top.clk_tx);
        @(posedge u_top.clk_tx);
        #1 rx = 0;
        @(posedge u_top.clk_tx);
        #1 rx = 1;
        @(posedge u_top.clk_tx);
        #1 rx = 0;
        @(posedge u_top.clk_tx);
        @(posedge u_top.clk_tx);
        #1 rx = 1;
        @(posedge u_top.clk_tx);
        #1 rx = 0;
        @(posedge u_top.clk_tx);
        #1 rx = 1;
        @(posedge u_top.clk_tx);
        #1 rx = 0;
        @(posedge u_top.clk_tx);
        @(posedge u_top.clk_tx);
        @(posedge u_top.clk_tx);
        #1 rx = 1;
    end

endmodule
