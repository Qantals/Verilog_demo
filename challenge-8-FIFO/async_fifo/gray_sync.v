module gray_sync #(
    parameter N = 4
)(
    input clk,
    input rst_n,
    input [N-1:0] gray,
    output [N-1:0] gray_r,
    output [N-1:0] gray_rr
);
    reg [N-1:0] gray_r_reg;
    reg [N-1:0] gray_rr_reg;
    always @(posedge clk, negedge rst_n) begin
        if(~rst_n) begin
            gray_r_reg <= 0;
            gray_rr_reg <= 0;
        end
        else begin
            gray_r_reg <= gray;
            gray_rr_reg <= gray_r_reg;
        end
    end
    assign gray_r = gray_r_reg;
    assign gray_rr = gray_rr_reg;
    
endmodule