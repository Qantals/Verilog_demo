`timescale 1ns/1ps
module max8_4 (
    input signed [7:0] conv0,
    input signed [7:0] conv1,
    input signed [7:0] conv2,
    input signed [7:0] conv3,

    output signed [7:0] max
);
    wire signed [7:0] cmp1;
    wire signed [7:0] cmp2;

    assign cmp1 = (conv0 > conv1) ? conv0 : conv1;
    assign cmp2 = (conv2 > conv3) ? conv2 : conv3;

    assign max = (cmp1 > cmp2) ? cmp1 : cmp2;

endmodule
