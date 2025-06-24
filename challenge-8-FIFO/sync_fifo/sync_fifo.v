module sync_fifo #(
    parameter DEEPWID = 3,
    parameter BITWID = 5
)(
    input clk,rst_n,
    input wr_en,
    input rd_en,
    input [BITWID-1:0] wr_data,
    output [BITWID-1:0] rd_data,
    input [DEEPWID-1:0] cfg_almost_full,
    input [DEEPWID-1:0] cfg_almost_empty,

    output rd_data_vld,
    output full,
    output empty,
    output almost_full,
    output almost_empty,
    output [DEEPWID:0] fifo_num
);
    wire ram_wr_en;
    wire ram_rd_en;
    // need extra bit for judging full/empty
    wire [DEEPWID:0] wr_addr;   // point to where wait to write
    wire [DEEPWID:0] rd_addr;   // point to where ready to read
    simple_dual_port_ram_sync #(
        .DATA_WIDTH(BITWID),
        .ADDR_WIDTH(DEEPWID)
    ) u_ram (
        .clka(clk),
        .clkb(clk),
        .rst_n(rst_n),
        .wena(ram_wr_en),
        .renb(ram_rd_en),
        .waddra(wr_addr[DEEPWID-1:0]),
        .raddrb(rd_addr[DEEPWID-1:0]),
        .dina(wr_data),
        .doutb(rd_data)
    );

    wr_rd_ctrl #(
        .DEEPWID(DEEPWID)
    ) u_wr_ctrl (
        .clk(clk),
        .rst_n(rst_n),
        .en(wr_en),
        .fe_flag(full),
        .ram_en(ram_wr_en),
        .addr(wr_addr)
    );
    wr_rd_ctrl #(
        .DEEPWID(DEEPWID)
    ) u_rd_ctrl (
        .clk(clk),
        .rst_n(rst_n),
        .en(rd_en),
        .fe_flag(empty),
        .ram_en(ram_rd_en),
        .addr(rd_addr)
    );
    
    full_flag_ptr #(
        .DEEPWID(DEEPWID)
    ) u_full_flag_ptr (
        .wr_addr(wr_addr),
        .rd_addr(rd_addr),
        .cfg_almost_full(cfg_almost_full),
        .full(full),
        .almost_full(almost_full)
    );
    empty_flag_ptr #(
        .DEEPWID(DEEPWID)
    ) u_empty_flag_ptr (
        .wr_addr(wr_addr),
        .rd_addr(rd_addr),
        .cfg_almost_empty(cfg_almost_empty),
        .empty(empty),
        .almost_empty(almost_empty),
        .fifo_num(fifo_num)
    );

    // fe_flag_cnt #(
    //     .DEEPWID(DEEPWID)
    // ) u_fe_flag_cnt(
    //     .clk(clk),
    //     .rst_n(rst_n),
    //     .ram_wr_en(ram_wr_en),
    //     .ram_rd_en(ram_rd_en),
    //     .cfg_almost_full(cfg_almost_full),
    //     .cfg_almost_empty(cfg_almost_empty),
    //     .full(full),
    //     .empty(empty),
    //     .almost_full(almost_full),
    //     .almost_empty(almost_empty),
    //     .fifo_num(fifo_num)
    // );


    rd_data_vld_m u_rd_data_vld_m(
        .clk(clk),
        .rst_n(rst_n),
        .ram_rd_en(ram_rd_en),
        .rd_data_vld(rd_data_vld)
    );

endmodule
