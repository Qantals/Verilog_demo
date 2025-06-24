module full_flag_ptr #(
    parameter DEEPWID = 3
)(
    input [DEEPWID:0] wr_addr,
    input [DEEPWID:0] rd_addr,
    input [DEEPWID-1:0] cfg_almost_full,
    output full,
    output almost_full
);
    // assign full = (wr_addr[DEEPWID] ^ rd_addr[DEEPWID]) && (wr_addr[DEEPWID-1:0] == rd_addr[DEEPWID-1:0]);

    wire diff_round;
    assign diff_round = (wr_addr[DEEPWID] ^ rd_addr[DEEPWID]);

    wire [DEEPWID:0] full_gap;
    assign full_gap = diff_round ? 
        (rd_addr[DEEPWID-1:0] - wr_addr[DEEPWID-1:0]) :
        (rd_addr[DEEPWID-1:0] + 2**DEEPWID - wr_addr[DEEPWID-1:0]);
    assign almost_full = (full_gap <= {1'b0, cfg_almost_full});
    assign full = (full_gap == 0);

endmodule

module empty_flag_ptr #(
    parameter DEEPWID = 3
)(
    input [DEEPWID:0] wr_addr,
    input [DEEPWID:0] rd_addr,
    input [DEEPWID-1:0] cfg_almost_empty,
    output empty,
    output almost_empty,
    output [DEEPWID:0] fifo_num
);

    // assign empty = ~(wr_addr[DEEPWID] ^ rd_addr[DEEPWID]) && (wr_addr[DEEPWID-1:0] == rd_addr[DEEPWID-1:0]);

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






module fe_flag_cnt #(
    parameter DEEPWID = 3
)(
    input clk,
    input rst_n,
    input ram_wr_en,
    input ram_rd_en,
    input [DEEPWID-1:0] cfg_almost_full,
    input [DEEPWID-1:0] cfg_almost_empty,
    output full,
    output empty,
    output almost_full,
    output almost_empty,
    output [DEEPWID:0] fifo_num
);
    reg [DEEPWID:0] data_vld_cnt;
    always @(posedge clk, negedge rst_n) begin
        if(~rst_n)
            data_vld_cnt <= 0;
        else if(~(ram_wr_en & ram_rd_en)) begin
            if(ram_wr_en)
                data_vld_cnt <= data_vld_cnt + 1;
            else if(ram_rd_en)
                data_vld_cnt <= data_vld_cnt - 1;
        end
    end
    assign full = (data_vld_cnt == 2**DEEPWID);
    assign almost_full = (data_vld_cnt >= 2 ** DEEPWID - cfg_almost_full);
    assign empty = (data_vld_cnt == 0);
    assign almost_empty = (data_vld_cnt <= 0 + cfg_almost_empty);

    assign fifo_num = data_vld_cnt;

endmodule