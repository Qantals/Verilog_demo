module rd_data_vld_m (
    input clk,
    input rst_n,
    input ram_rd_en,
    output rd_data_vld
);
    reg rd_data_vld_reg;
    always @(posedge clk, negedge rst_n) begin
        if(~rst_n)
            rd_data_vld_reg <= 1'b0;
        else if(ram_rd_en)
            rd_data_vld_reg <= 1'b1;
        else
            rd_data_vld_reg <= 1'b0;
    end
    assign rd_data_vld = rd_data_vld_reg;

endmodule
