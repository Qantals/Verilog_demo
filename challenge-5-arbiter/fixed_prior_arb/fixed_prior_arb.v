module fixed_prior_arb_give #(
    parameter N = 4
)(
    input [N-1:0] req,
    input enable,
    input [N-1:0] priority,
    output [N-1:0] gnt,
    output valid
);
    /* use gate level description */
    wire [2*N-1:0] req_double;
    wire [2*N-1:0] gnt_double;
    assign req_double = {req, req};
    assign gnt_double = req_double & ~(req_double - priority);

    assign gnt = gnt_double[N-1:0] | gnt_double[2*N-1:N];
    assign valid = enable & (|gnt);

endmodule

module fixed_prior_arb_behav #(
    parameter N = 4
)(
    input [N-1:0] req,
    input enable,
    output [N-1:0] gnt,
    output valid
);
    /* use behavior level description */
    integer i;
    reg [N-1:0] result;
    reg find;

    always @(req) begin
        result = 0;
        find = 0;
        for(i = 0; i < N; i = i +1) begin
            if(req[i] & ~find) begin
                result[i] = 1'b1;
                find = 1'b1;
            end
        end
    end
    assign gnt = result;
    assign valid = enable & (|gnt);

endmodule

module fixed_prior_arb_cons #(
    parameter N = 4
)(
    input [N-1:0] req,
    input enable,
    output [N-1:0] gnt,
    output valid
);
    /*use structure level description */
    wire [N-1:0] find;
    assign find = {find[N-2:0] | req[N-2:0], 1'b0};
    assign gnt = req & ~find;
    assign valid = enable & (|gnt);

endmodule
