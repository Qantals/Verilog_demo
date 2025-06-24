`timescale 1ns/1ps
module dot8_9 (
    input signed [7:0] data0,
    input signed [7:0] data1,
    input signed [7:0] data2,
    input signed [7:0] data3,
    input signed [7:0] data4,
    input signed [7:0] data5,
    input signed [7:0] data6,
    input signed [7:0] data7,
    input signed [7:0] data8,

    input signed [7:0] weight0,
    input signed [7:0] weight1,
    input signed [7:0] weight2,
    input signed [7:0] weight3,
    input signed [7:0] weight4,
    input signed [7:0] weight5,
    input signed [7:0] weight6,
    input signed [7:0] weight7,
    input signed [7:0] weight8,

    output signed [15:0] dot0,
    output signed [15:0] dot1,
    output signed [15:0] dot2,
    output signed [15:0] dot3,
    output signed [15:0] dot4,
    output signed [15:0] dot5,
    output signed [15:0] dot6,
    output signed [15:0] dot7,
    output signed [15:0] dot8
);
    assign dot0 = data0 * weight0;
    assign dot1 = data1 * weight1;
    assign dot2 = data2 * weight2;
    assign dot3 = data3 * weight3;
    assign dot4 = data4 * weight4;
    assign dot5 = data5 * weight5;
    assign dot6 = data6 * weight6;
    assign dot7 = data7 * weight7;
    assign dot8 = data8 * weight8;

endmodule
