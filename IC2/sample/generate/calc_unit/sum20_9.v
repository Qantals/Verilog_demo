`timescale 1ns/1ps
module sum20_9 (
    input signed [19:0] expand0,
    input signed [19:0] expand1,
    input signed [19:0] expand2,
    input signed [19:0] expand3,
    input signed [19:0] expand4,
    input signed [19:0] expand5,
    input signed [19:0] expand6,
    input signed [19:0] expand7,
    input signed [19:0] expand8,

    output signed [19:0] sum
);
    assign sum = expand0 + expand1 + expand2 + expand3 + expand4 + expand5 + expand6 + expand7 + expand8;

endmodule
