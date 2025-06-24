module seq_detection_cover_Mealy(
    input clk,
    input rst_n,
    input data,
    output result
);
    localparam S0 = 2'b00,
                S1= 2'b01,
                S2= 2'b11;
    reg [1:0] state, nxt_state;

    always @(posedge clk, negedge rst_n) begin
        if(~rst_n)
            state <= S0;
        else
            state <= nxt_state;
    end

    always @(*) begin
        case(state)
            S0: nxt_state = data ? S1 : S0;
            S1: nxt_state = data ? S1 : S2;
            default: nxt_state = data ? S1 : S0;
        endcase
    end

    assign result = (state == S2 && data);

endmodule

module seq_detection_noncover_Mealy(
    input clk,
    input rst_n,
    input data,
    output result
);
    localparam S0 = 2'b00,
                S1= 2'b01,
                S2= 2'b11;
    reg [1:0] state, nxt_state;

    always @(posedge clk, negedge rst_n) begin
        if(~rst_n)
            state <= S0;
        else
            state <= nxt_state;
    end

    always @(*) begin
        case(state)
            S0: nxt_state = data ? S1 : S0;
            S1: nxt_state = data ? S1 : S2;
            default: nxt_state = S0;  // change is here.
        endcase
    end

    assign result = (state == S2 && data);

endmodule





module seq_detection_cover_Moore(
    input clk,
    input rst_n,
    input data,
    output result
);
    localparam S0 = 2'b00,
                S1= 2'b01,
                S2= 2'b11,
                S3= 2'b10;
    reg [1:0] state, nxt_state;

    always @(posedge clk, negedge rst_n) begin
        if(~rst_n)
            state <= S0;
        else
            state <= nxt_state;
    end

    always @(*) begin
        case(state)
            S0: nxt_state = data ? S1 : S0;
            S1: nxt_state = data ? S1 : S2;
            S2: nxt_state = data ? S3 : S0;
            default: nxt_state = data ? S1 : S2;
        endcase
    end

    assign result = (state == S3);

endmodule

module seq_detection_noncover_Moore(
    input clk,
    input rst_n,
    input data,
    output result
);
    localparam S0 = 2'b00,
                S1= 2'b01,
                S2= 2'b11,
                S3= 2'b10;
    reg [1:0] state, nxt_state;

    always @(posedge clk, negedge rst_n) begin
        if(~rst_n)
            state <= S0;
        else
            state <= nxt_state;
    end

    always @(*) begin
        case(state)
            S0: nxt_state = data ? S1 : S0;
            S1: nxt_state = data ? S1 : S2;
            S2: nxt_state = data ? S3 : S0;
            default: nxt_state = data ? S1 :S0;  // change is here.
        endcase
    end

    assign result = (state == S3);

endmodule
