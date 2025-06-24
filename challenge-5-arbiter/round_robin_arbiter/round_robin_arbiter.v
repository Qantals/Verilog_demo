module round_robin_arbiter_fsm(
    input clk,
    input rst_n,
    input [3:0] req,
    input enable,
    output [3:0] gnt,
    output valid
);
    reg [3:0] cur_state,nxt_state;
    localparam IDLE = 4'b0000,
                S1  = 4'b0001,
                S2  = 4'b0010,
                S3  = 4'b0100,
                S4  = 4'b1000;

    always @(posedge clk, negedge rst_n) begin
        if(~rst_n)
            cur_state <= IDLE;
        else
            cur_state <= nxt_state;
    end
    always @(*) begin
        if(enable) begin
            case (cur_state)
                S1: nxt_state =     (req[1]) ? S2 : (
                                    (req[2]) ? S3 : (
                                    (req[3]) ? S4 : (
                                    (req[0]) ? S1 : IDLE )));

                S2: nxt_state =     (req[2]) ? S3 : (
                                    (req[3]) ? S4 : (
                                    (req[0]) ? S1 : (
                                    (req[1]) ? S2 : IDLE )));

                S3: nxt_state =     (req[3]) ? S4 : (
                                    (req[0]) ? S1 : (
                                    (req[1]) ? S2 : (
                                    (req[2]) ? S3 : IDLE )));

                default: nxt_state =(req[0]) ? S1 : (
                                    (req[1]) ? S2 : (
                                    (req[2]) ? S3 : (
                                    (req[3]) ? S4 : IDLE )));
            endcase
        end
        else
            nxt_state = IDLE;
    end

    assign gnt = cur_state;
    assign valid = enable & (|gnt);

endmodule

module round_robin_arbiter_mask #(
    parameter N = 4
)(
    input clk,
    input rst_n,
    input [N-1:0] req,
    input enable,
    output [N-1:0] gnt,
    output valid
);
    reg [N-1:0] gnt_reg;
    reg [N-1:0] mask_reg;
    wire [N-1:0] mask;
    wire [N-1:0] mask_out;
    wire routine;
    assign mask = ~gnt_reg & ~(gnt_reg - 1) & mask_reg;
    assign mask_out = req & mask;
    assign routine = ~(|mask_out);
    always @(posedge clk, negedge rst_n) begin
        if(~rst_n)
            mask_reg <= {N{1'b1}};
        else if(enable)
            mask_reg <= routine ? {N{1'b1}} : mask;
        else
            mask_reg <= {N{1'b1}};
    end

    wire [N-1:0] req_sel;
    assign req_sel = routine ? req : mask_out;
    always @(posedge clk, negedge rst_n) begin
        if(~rst_n)
            gnt_reg <= {N{1'b0}};
        else if(enable)
            gnt_reg <= req_sel & (~req_sel + 1'b1);
        else
            gnt_reg <= {N{1'b0}};
    end
    assign gnt = gnt_reg;

    reg valid_reg;
    always @(posedge clk, negedge rst_n) begin
        if(~rst_n)
            valid_reg <= 1'b0;
        else if(enable & |req)
            valid_reg <= 1'b1;
        else
            valid_reg <= 1'b0;
    end
    assign valid = valid_reg & enable;

endmodule

module round_robin_arbiter_give #(
    parameter N = 4
)(
    input clk,
    input rst_n,
    input [N-1:0] req,
    input enable,
    output [N-1:0] gnt,
    output valid
);

    reg [N-1:0] priority_reg;
    wire [N-1:0] gnt_wire;
    always @(posedge clk, negedge rst_n) begin
        if(~rst_n)
            priority_reg <= 1;
        else if(enable & |req)
            priority_reg <= {gnt_wire[N-2:0], gnt_wire[N-1]};
    end

    fixed_prior_arb_give #(
        .N(N)
    ) u_fixed_sel_priority (
        .req(req),
        .enable(1'b1),
        .priority(priority_reg),
        .gnt(gnt_wire),
        .valid()
    );

    reg [N-1:0] gnt_reg;
    always @(posedge clk, negedge rst_n) begin
        if(~rst_n)
            gnt_reg <= 0;
        else if(enable)
            gnt_reg <= gnt_wire;
    end
    assign gnt = gnt_reg;

    reg valid_reg;
    always @(posedge clk, negedge rst_n) begin
        if(~rst_n)
            valid_reg <= 1'b0;
        else if(enable & |req)
            valid_reg <= 1'b1;
        else
            valid_reg <= 1'b0;
    end
    assign valid = valid_reg & enable;

endmodule