module mol7(
    input clk,
    input rst_n,
    input data_in,
    output vld
);
    reg [2:0] state_cur,state_nxt;  // 0~6
    wire [3:0] mol_nxt; // 0~13
    
    always @(posedge clk, negedge rst_n) begin
        if(~rst_n)
            state_cur <= 0;
        else
            state_cur <= state_nxt;
    end

    always @(*) begin
        if(mol_nxt < 7)
            state_nxt = mol_nxt[2:0];
        else // mol_nxt < 14
            state_nxt = mol_nxt - 7;
    end
    assign mol_nxt = (state_cur << 1) + data_in;

    assign vld = state_nxt == 0;

endmodule
