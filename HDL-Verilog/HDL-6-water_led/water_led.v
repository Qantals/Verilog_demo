`timescale 1ms/1us

module water_led (
    input clk1MHz,
    input rst,
    output reg [7:0] led
);
    
    //clk division
    reg [18:0] cnt_clk;//0~500K
    reg clk1Hz;
    always @(posedge clk1MHz,posedge rst) begin
        if(rst) begin
            cnt_clk<=0;
            clk1Hz<=0;
        end else begin
            if(cnt_clk==500_000-1) begin
                cnt_clk<=0;
                clk1Hz <= ~clk1Hz;
            end else
                cnt_clk<=cnt_clk+1;
        end
    end

    //water led
    always @(posedge clk1Hz,posedge rst) begin
        if(rst)
            led<=8'b0000_0001;
        else
            led<={led[6:0],led[7]};
    end

endmodule