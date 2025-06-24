
module counter_10 (
    input rst,
    input en,
    input clk50m,
    output reg [6:0] seg,
    output [5:0] dig
);

    //clock devision
    reg [23:0] cnt_clk;//0~12.5M-1
    reg clk2hz;
    always @(posedge clk50m,posedge rst) begin
        if(rst) begin
            cnt_clk<=0;
            clk2hz<=0;
        end else if(en) begin
            if(cnt_clk==12_500_000-1) begin
                cnt_clk<=0;
                clk2hz <= ~clk2hz;
            end else
                cnt_clk<=cnt_clk+1;
        end
    end

    //count_10
    reg [3:0] cnt_num;//0~9
    always @(posedge clk2hz,posedge rst) begin
        if(rst)
            cnt_num<=0;
        else if(en) begin
            if(cnt_num==9)
                cnt_num<=0;
            else
                cnt_num<=cnt_num+1;
        end
    end

    //dig and seg output
    always @(*) begin
        case(cnt_num)
            4'h0 : seg = 7'h3f;
            4'h1 : seg = 7'h06;
            4'h2 : seg = 7'h5b;
            4'h3 : seg = 7'h4f;
            4'h4 : seg = 7'h66;
            4'h5 : seg = 7'h6d;
            4'h6 : seg = 7'h7d;
            4'h7 : seg = 7'h07;
            4'h8 : seg = 7'h7f;
            4'h9 : seg = 7'h6f;
        endcase
    end
    assign dig=6'b111110;

endmodule