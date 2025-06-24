`timescale 1ps/1ps
module test();
    parameter N = 4;
    reg [N-1:0] req;
    reg enable;
    reg [N-1:0] priority;
    wire [N-1:0] gnt;
    wire valid;

    fixed_prior_arb_give #(
        .N(N)
    ) u1 (
        .req(req),
        .enable(enable),
        .priority(priority),
        .gnt(gnt),
        .valid(valid)
    );

    integer i;
    integer j;
    initial begin
        enable = 1'b0;
        priority = 0;
        for(j = 0; j < N; j = j + 1) begin
            priority = 1 << j;
            for(i = 0; i < N; i = i + 1) begin
                req = 1 << i;
                #1 enable = 1'b1;
                #5 enable = 1'b0;
                #4;
            end
            for(i = 0; i < 2**N; i = i + 1) begin
                req = i;
                #1 enable = 1'b1;
                #5 enable = 1'b0;
                #4;
            end
        end
    end
    
endmodule
