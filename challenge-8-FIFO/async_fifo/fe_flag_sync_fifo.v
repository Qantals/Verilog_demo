module full_flag_ptr_sync_fifo #(
    parameter DEEPWID = 3
)(
    input [DEEPWID:0] wr_addr,
    input [DEEPWID:0] rd_addr,
    input [DEEPWID-1:0] cfg_almost_full,
    output full,
    output almost_full
);
    wire diff_round;
    assign diff_round = (wr_addr[DEEPWID] ^ rd_addr[DEEPWID]);

    wire [DEEPWID:0] full_gap;
    assign full_gap = diff_round ? 
        (rd_addr[DEEPWID-1:0] - wr_addr[DEEPWID-1:0]) :
        (rd_addr[DEEPWID-1:0] + 2**DEEPWID - wr_addr[DEEPWID-1:0]);
    assign almost_full = (full_gap <= {1'b0, cfg_almost_full});
    assign full = (full_gap == 0);

endmodule

module empty_flag_ptr_sync_fifo #(
    parameter DEEPWID = 3
)(
    input [DEEPWID:0] wr_addr,
    input [DEEPWID:0] rd_addr,
    input [DEEPWID-1:0] cfg_almost_empty,
    output empty,
    output almost_empty,
    output [DEEPWID:0] fifo_num
);
    wire diff_round;
    assign diff_round = (wr_addr[DEEPWID] ^ rd_addr[DEEPWID]);

    wire [DEEPWID:0] empty_gap;
    assign empty_gap = diff_round ? 
        (wr_addr[DEEPWID-1:0] + 2**DEEPWID - rd_addr[DEEPWID-1:0]) :
        (wr_addr[DEEPWID-1:0] - rd_addr[DEEPWID-1:0]);
    assign almost_empty = (empty_gap <= {1'b0, cfg_almost_empty});
    assign empty = (empty_gap == 0);

    assign fifo_num = empty_gap;

endmodule
