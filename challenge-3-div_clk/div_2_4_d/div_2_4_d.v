module div_2_4_d (
    input clk,
    input rst_n,
    output div_2,
    output div_4
);
    reg div_2_reg,div_4_reg;
    always @(posedge clk, negedge rst_n) begin
        if(~rst_n)
            div_2_reg <= 1'b0;
        else
            div_2_reg <= ~div_2_reg;
    end

    always @(posedge div_2_reg, negedge rst_n) begin
        if(~rst_n)
            div_4_reg <= 1'b0;
        else
            div_4_reg <= ~div_4_reg;
    end

    assign div_2 = div_2_reg;
    assign div_4 = div_4_reg;

endmodule
