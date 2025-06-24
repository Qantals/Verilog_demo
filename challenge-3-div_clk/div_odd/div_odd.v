module div_odd #(
    parameter  N = 5
)
(
    input clk,
    input rst_n,
    output div_odd
);
    reg [31:0] cnt1,cnt2;
    wire trigger;
    assign trigger = (cnt1 >= (N-1)/2 && cnt2 >= (N-1)/2);

    always @(posedge clk, negedge rst_n) begin
        if(~rst_n)
            cnt1 <= 32'h0;
        else begin
            if(cnt1 == N-1)
                cnt1 <= 32'h0;
            else
                cnt1 <= cnt1 + 32'h1;
        end
    end
    always @(negedge clk, negedge rst_n) begin
        if(~rst_n)
            cnt2 <= 32'h0;
        else begin
            if(cnt2 == N-1)
                cnt2 <= 32'h0;
            else
                cnt2 <= cnt2 + 32'h1;
        end
    end

    assign div_odd = trigger;

endmodule
