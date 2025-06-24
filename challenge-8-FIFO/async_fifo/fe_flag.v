module full_flag_wr #(
    parameter DEEPWID = 3
)(
    input [DEEPWID:0] wr_addr_g,
    input [DEEPWID:0] rd_addr_g_rr,
    input [DEEPWID:0] wr_addr_b,
    input [DEEPWID-1:0] cfg_almost_full,
    output full,
    output almost_full
);
    assign full = (wr_addr_g[DEEPWID:(DEEPWID-1)] == ~rd_addr_g_rr[DEEPWID:(DEEPWID-1)]) &&
        (wr_addr_g[DEEPWID-2:0] == rd_addr_g_rr[DEEPWID-2:0]);

    wire [DEEPWID:0] rd_addr_b_rr;
    gray2bin_N #(
        .N(DEEPWID + 1)
    ) u_g2b_full_flag_rd (
        .gray(rd_addr_g_rr),
        .bin(rd_addr_b_rr)
    );

    full_flag_ptr_sync_fifo #(
        .DEEPWID(DEEPWID)
    ) u_full_flag_ptr_sync_fifo (
        .wr_addr(wr_addr_b),
        .rd_addr(rd_addr_b_rr),
        .cfg_almost_full(cfg_almost_full),
        .full(),
        .almost_full(almost_full)
    );

endmodule


module empty_flag_rd #(
    parameter DEEPWID = 3
)(
    input [DEEPWID:0] wr_addr_g_rr,
    input [DEEPWID:0] rd_addr_g,
    input [DEEPWID:0] rd_addr_b,
    input [DEEPWID-1:0] cfg_almost_empty,
    output empty,
    output almost_empty
);
    assign empty = (wr_addr_g_rr == rd_addr_g);

    wire [DEEPWID:0] wr_addr_b_rr;
    gray2bin_N #(
        .N(DEEPWID + 1)
    ) u_g2b_full_flag_wr (
        .gray(wr_addr_g_rr),
        .bin(wr_addr_b_rr)
    );

    empty_flag_ptr_sync_fifo #(
        .DEEPWID(DEEPWID)
    ) u_empty_flag_ptr_sync_fifo (
        .wr_addr(wr_addr_b_rr),
        .rd_addr(rd_addr_b),
        .cfg_almost_empty(cfg_almost_empty),
        .empty(),
        .almost_empty(almost_empty),
        .fifo_num() // not proper clock domain
    );

endmodule
