module clock_division
    #(parameter DIVCLK_CNTMAX = 24999)
    (clk_in,rst_n,divclk);
    input clk_in;
    input rst_n;
    output  reg divclk;

    reg [31:0] cnt;              

    always@(posedge clk_in,negedge rst_n) begin
        if(~rst_n) begin
            cnt<=0;
            divclk<=0;
        end
        else if(cnt == DIVCLK_CNTMAX) begin
            cnt <= 0;
            divclk <= ~divclk;
        end
        else
            cnt <= cnt + 1;
    end 

endmodule