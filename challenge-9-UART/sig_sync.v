module sig_sync (
    input clk,
    input rst_n,
    input sig_async,
    output sig_sync
);
    reg syn_reg1,syn_reg2;
    always @(posedge clk, negedge rst_n) begin
        if(~rst_n) begin    // reset to 0!
            syn_reg1 <= 0;
            syn_reg2 <= 0;
        end
        else begin
            syn_reg1 <= sig_async;
            syn_reg2 <= syn_reg1;
        end
    end
    assign sig_sync = syn_reg2;
    
endmodule
