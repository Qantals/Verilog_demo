`timescale 1ns/1ps
module pool_2x2(
    input clk,
    input rst_n,
    input in_vld,
    // input [$clog2(67)-1:0] cnt,
    input [$clog2(68)-1:0] cnt,
    input signed [7:0] conv,

    output [3*8-1:0] pool_lin_reg
);

    reg signed [7:0] data0;
    reg signed [7:0] data1;
    reg signed [7:0] data2;
    always @(posedge clk, negedge rst_n) begin
        if(~rst_n) begin
            data0 <= 0;
            data1 <= 0;
            data2 <= 0;
        end
        else if(in_vld)begin
            case (cnt)
                // 20,36,52: data0 <= conv;
                // 21,28,29, 37,44,45, 53,60,61: data0 <= (conv > data0) ? conv : data0;
                // 22,38,54: data1 <= conv;
                // 23,30,31, 39,46,47, 55,62,63: data1 <= (conv > data1) ? conv : data1;
                // 24,40,56: data2 <= conv;
                // 25,32,33, 41,48,49, 57,64,65: data2 <= (conv > data2) ? conv : data2;
                21,37,53: data0 <= conv;
                22,29,30, 38,45,46, 54,61,62: data0 <= (conv > data0) ? conv : data0;
                23,39,55: data1 <= conv;
                24,31,32, 40,47,48, 56,63,64: data1 <= (conv > data1) ? conv : data1;
                25,41,57: data2 <= conv;
                26,33,34, 42,49,50, 58,65,66: data2 <= (conv > data2) ? conv : data2;
                // default: 
            endcase
        end
    end

    assign pool_lin_reg[0*8 +: 8] = $unsigned(data0);
    assign pool_lin_reg[1*8 +: 8] = $unsigned(data1);
    assign pool_lin_reg[2*8 +: 8] = $unsigned(data2);

endmodule
