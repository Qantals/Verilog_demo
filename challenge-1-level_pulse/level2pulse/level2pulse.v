module level2pulse(
    input clk,
    input rst_n,
    input data_in,
    output rise,
    output fall,
    output double
);
    reg  data_reg;
    always @(posedge clk, negedge rst_n)
        if(~rst_n)
            data_reg <= 1'b0;
        else
            data_reg <= data_in;
    
    assign rise = data_in == 1'b1 && data_reg == 1'b0;
    assign fall = data_in == 1'b0 && data_reg == 1'b1;
    assign double = rise | fall;

endmodule
