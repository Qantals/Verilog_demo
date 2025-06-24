module gen_shift(
    input clk,
    input rst_n,
    input load,
    input [5:0] din,
    output dout
);
    reg [5:0] shift;
    always @(posedge clk, negedge rst_n) begin
        if(~rst_n)
            shift <= 6'b0;
        else if(load)
            shift <= din;
        else
            shift <= {shift[4:0], shift[5]};
    end
    assign dout = shift[5];

endmodule

module gen_fsm(
    input clk,
    input rst_n,
    input [5:0] din,
    output dout
);
    localparam  S1 = 3'b000,
                S2 = 3'b001,
                S3 = 3'b011,
                S4 = 3'b010,
                S5 = 3'b110,
                S6 = 3'b111;
    reg [2:0] state,nxt_state;
    reg dout_reg;

    always @(posedge clk, negedge rst_n) begin
        if(~rst_n)
            state <= S1;
        else
            state <= nxt_state;
    end

    always @(*) begin
        case(state)
            S1: begin nxt_state = S2; dout_reg = din[5]; end
            S2: begin nxt_state = S3; dout_reg = din[4]; end
            S3: begin nxt_state = S4; dout_reg = din[3]; end
            S4: begin nxt_state = S5; dout_reg = din[2]; end
            S5: begin nxt_state = S6; dout_reg = din[1]; end
            default: begin nxt_state = S1; dout_reg = din[0]; end
        endcase
    end
    assign dout = dout_reg;

endmodule

module gen_min(
    input clk,
    input rst_n,
    output dout
);
    reg [2:0] data;
    wire df;
    assign df = (~data[2] | data[0]) & (~data[1] | ~data[0]);

    always @(posedge clk, negedge rst_n) begin
        if(~rst_n)
            data <= 3'b100;
        else
            data <= {df, data[2:1]};
    end
    assign dout = data[0];
endmodule
