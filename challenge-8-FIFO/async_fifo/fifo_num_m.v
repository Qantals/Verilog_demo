module fifo_num_m #(
    parameter DEEPWID = 3
)(
    input [DEEPWID:0] wr_addr,  // different clock domain
    input [DEEPWID:0] rd_addr,  // different clock domain
    output [DEEPWID:0] fifo_num
);
    empty_flag_ptr_sync_fifo #(
        .DEEPWID(DEEPWID)
    ) u_fifo_num_sync_fifo (
        .wr_addr(wr_addr),
        .rd_addr(rd_addr),
        .cfg_almost_empty({DEEPWID{1'b0}}),
        .empty(),
        .almost_empty(),
        .fifo_num(fifo_num)
    );

endmodule