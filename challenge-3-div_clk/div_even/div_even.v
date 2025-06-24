module div_even #(
    parameter N = 6
)(
    input clk,
    input rst_n,
    output div_even
);
    reg [31:0] cnt;
    reg div_even_reg;
    always @(posedge clk, negedge rst_n) begin
        if(~rst_n) begin
            cnt <= 32'h0;
            div_even_reg <= 1'b0;
        end
        else begin
            if(cnt == (N/2-1)) begin
                cnt <= 32'h0;
                div_even_reg <= ~div_even_reg;
            end 
            else
                cnt <= cnt + 32'h1;
        end
    end

    assign div_even = div_even_reg;
endmodule
