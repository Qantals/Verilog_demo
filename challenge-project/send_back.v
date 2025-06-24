module send_back #(
    parameter DATA_WIDTH = 8
)(
    input clk_tx,
    input clk_rx,
    input rst_n,
    input done_tx,
    input done_rx,
    input [DATA_WIDTH-1:0] data_rx,
    input empty,
    output en_tx,
    output rd_en_fifo
);
    reg en_tx_reg;
    assign en_tx = en_tx_reg;

    reg lf_scan_reg;    // clk_rx
    wire en_tx_syncrx;
    always @(posedge clk_rx, negedge rst_n) begin
        if(~rst_n)
            lf_scan_reg <= 0;
        else if(done_rx && data_rx == 8'b00001010)  // get LF(line feed) for ascii=0xA
            lf_scan_reg <= 1;
        else if(en_tx_syncrx)
            lf_scan_reg <= 0;
    end
    sig_sync u_sync_en_tx(
        .clk(clk_rx),
        .rst_n(rst_n),
        .sig_async(en_tx_reg),
        .sig_sync(en_tx_syncrx)
    );

    reg [31:0] wait_tx_cnt;
    wire lf_scan_reg_synctx;
    sig_sync u_sync_lf_scan_reg(
        .clk(clk_tx),
        .rst_n(rst_n),
        .sig_async(lf_scan_reg),
        .sig_sync(lf_scan_reg_synctx)
    );
    always @(posedge clk_tx, negedge rst_n) begin
        if(~rst_n) begin
            wait_tx_cnt <= 0;
            en_tx_reg <= 0;
        end
        else if(empty) begin
            wait_tx_cnt <= 0;
            en_tx_reg <= 0;
        end
        else if(lf_scan_reg_synctx) begin
            wait_tx_cnt <= (wait_tx_cnt == 10) ? 0 : wait_tx_cnt + 1;
            if(wait_tx_cnt == 10)
                en_tx_reg <= 1;
        end
    end

    reg done_tx_init;
    always @(posedge clk_tx, negedge rst_n) begin
        if(~rst_n)
            done_tx_init <= 1;
        else if(empty)
            done_tx_init <= 1;
        else if(en_tx_reg)
            done_tx_init <= 0;
    end
    assign rd_en_fifo = en_tx_reg & (done_tx_init | done_tx);

endmodule
