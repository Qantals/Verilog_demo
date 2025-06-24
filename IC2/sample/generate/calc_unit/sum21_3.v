`timescale 1ns/1ps
module sum21_3 (
    input signed [20:0] expand0,
    input signed [20:0] expand1,
    input signed [20:0] expand2,

    output signed [20:0] sum
);
    assign sum = expand0 + expand1 + expand2;
    
endmodule
