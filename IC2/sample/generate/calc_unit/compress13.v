`timescale 1ns/1ps
module compress13 (
    input signed [12:0] sum,
    output signed [7:0] compress
);
    assign compress = (sum > 127) ? 8'd127 : ((sum < -128) ? -8'd128 : sum[7:0]);
    
endmodule
