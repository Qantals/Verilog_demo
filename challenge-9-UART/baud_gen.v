module baud_gen #(
    parameter CLK_FREQ = 50_000_000,
    parameter BAUD_RATE = 9600
)(
    input clk,
    input rst_n,
    output clk_bps,
    output clk_bps16
);
    localparam BPS_DIV = CLK_FREQ / (BAUD_RATE * 2);
    localparam BPS16_DIV = CLK_FREQ / (BAUD_RATE * 16 * 2);

    reg [31:0] bps_cnt;
    reg [31:0] bps16_cnt;
    reg clk_bps_reg;
    reg clk_bps16_reg;

    always @(posedge clk, negedge rst_n) begin
        if(~rst_n) begin
            bps_cnt <= 0;
            clk_bps_reg <= 1'b0;
        end
        else begin
            if(bps_cnt == BPS_DIV - 1) begin
                bps_cnt <= 0;
                clk_bps_reg <= ~clk_bps_reg;
            end
            else
                bps_cnt <= bps_cnt + 1;
        end
    end
    always @(posedge clk, negedge rst_n) begin
        if(~rst_n) begin
            bps16_cnt <= 0;
            clk_bps16_reg <= 1'b0;
        end
        else begin
            if(bps16_cnt == BPS16_DIV - 1) begin
                bps16_cnt <= 0;
                clk_bps16_reg <= ~clk_bps16_reg;
            end
            else
                bps16_cnt <= bps16_cnt + 1;
        end
    end

    assign clk_bps = clk_bps_reg;
    assign clk_bps16 = clk_bps16_reg;

endmodule
