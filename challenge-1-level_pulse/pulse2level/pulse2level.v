module pulse2level(
    input clk,
    input rst_n,
    input start,
    input stop,
    output level
);
    reg level_reg;
    always @(posedge clk, negedge rst_n)
        if(~rst_n)
            level_reg <= 1'b0;
        else if(start == 1'b1 && level_reg == 1'b0)
            level_reg <= 1'b1;
        else if(stop == 1'b1 && level_reg == 1'b1)
            level_reg <= 1'b0;
        else
            level_reg <= level_reg;

    assign level = level_reg;

endmodule
