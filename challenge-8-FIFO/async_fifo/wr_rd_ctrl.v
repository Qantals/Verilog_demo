module wr_rd_ctrl #(
    parameter DEEPWID = 3
)(
    input clk,
    input rst_n,
    input en,
    input fe_flag,  // full or empty flag
    output ram_en,
    output [DEEPWID:0] addr   // need extra bit for judging full/empty
);
    assign ram_en = en & ~fe_flag;

    reg [DEEPWID:0] addr_reg;
    always @(posedge clk, negedge rst_n) begin
        if(~rst_n)
            addr_reg <= 0;
        else if(ram_en)
            addr_reg <= addr_reg + 1; 
    end
    assign addr = addr_reg;

endmodule
