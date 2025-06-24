`timescale 1ns/1ps
module top (
    input clk,
    input rst_n,
    input mode,
    input [7:0] din,
    input ram_en,

    output [7:0] dout,
    output out_data_flag
);

    wire weight_ram_en;
    wire data_ram_en;

    ram_mux u_ram_mux (
        .mode(mode),
        .ram_en(ram_en),
        .weight_ram_en(weight_ram_en),
        .data_ram_en(data_ram_en)
    );

    wire [19*8-1:0] data_mem;
    data_ram u_data_ram(
        .clk(clk),
        .rst_n(rst_n),
        .wen(data_ram_en),
        .din(din),
        .dout(data_mem)
    );

    wire [3*3*3*2*8-1:0] weight_mem;
    weight_ram u_weight_ram(
        .clk(clk),
        .rst_n(rst_n),
        .wen(weight_ram_en),
        .din(din),
        .dout(weight_mem)
    );

    // wire [$clog2(67)-1:0] cnt;
    wire [$clog2(68)-1:0] cnt;
    control u_control(
        .clk(clk),
        .rst_n(rst_n),
        .in_vld(data_ram_en),
        .cnt(cnt),
        .out_data_flag(out_data_flag)
    );

    wire in_vld;
    assign in_vld = (data_ram_en || cnt >= 64);

    // dot module 
    wire [19:0] conv_dot_D1;
    wire [19:0] conv_dot_D2;
    wire [19:0] conv_dot_D3;
    inner_dot_T2_utility #(
        .SUM_WIDTH(20)
    ) u_conv_inner_dot_D1 (
        .clk(clk),
        .rst_n(rst_n),
        .in_vld(in_vld),
        .data0(data_mem[ 0*8 +: 8]),
        .data1(data_mem[ 1*8 +: 8]),
        .data2(data_mem[ 2*8 +: 8]),
        .data3(data_mem[ 8*8 +: 8]),
        .data4(data_mem[ 9*8 +: 8]),
        .data5(data_mem[10*8 +: 8]),
        .data6(data_mem[16*8 +: 8]),
        .data7(data_mem[17*8 +: 8]),
        .data8(data_mem[18*8 +: 8]),
        .weight0(weight_mem[(0*9+0)*8 +: 8]),
        .weight1(weight_mem[(0*9+1)*8 +: 8]),
        .weight2(weight_mem[(0*9+2)*8 +: 8]),
        .weight3(weight_mem[(0*9+3)*8 +: 8]),
        .weight4(weight_mem[(0*9+4)*8 +: 8]),
        .weight5(weight_mem[(0*9+5)*8 +: 8]),
        .weight6(weight_mem[(0*9+6)*8 +: 8]),
        .weight7(weight_mem[(0*9+7)*8 +: 8]),
        .weight8(weight_mem[(0*9+8)*8 +: 8]),
        .ans(conv_dot_D1)
    );
    inner_dot_T2_utility #(
        .SUM_WIDTH(20)
    ) u_conv_inner_dot_D2 (
        .clk(clk),
        .rst_n(rst_n),
        .in_vld(in_vld),
        .data0(data_mem[ 0*8 +: 8]),
        .data1(data_mem[ 1*8 +: 8]),
        .data2(data_mem[ 2*8 +: 8]),
        .data3(data_mem[ 8*8 +: 8]),
        .data4(data_mem[ 9*8 +: 8]),
        .data5(data_mem[10*8 +: 8]),
        .data6(data_mem[16*8 +: 8]),
        .data7(data_mem[17*8 +: 8]),
        .data8(data_mem[18*8 +: 8]),
        .weight0(weight_mem[(1*9+0)*8 +: 8]),
        .weight1(weight_mem[(1*9+1)*8 +: 8]),
        .weight2(weight_mem[(1*9+2)*8 +: 8]),
        .weight3(weight_mem[(1*9+3)*8 +: 8]),
        .weight4(weight_mem[(1*9+4)*8 +: 8]),
        .weight5(weight_mem[(1*9+5)*8 +: 8]),
        .weight6(weight_mem[(1*9+6)*8 +: 8]),
        .weight7(weight_mem[(1*9+7)*8 +: 8]),
        .weight8(weight_mem[(1*9+8)*8 +: 8]),
        .ans(conv_dot_D2)
    );
    inner_dot_T2_utility #(
        .SUM_WIDTH(20)
    ) u_conv_inner_dot_D3 (
        .clk(clk),
        .rst_n(rst_n),
        .in_vld(in_vld),
        .data0(data_mem[ 0*8 +: 8]),
        .data1(data_mem[ 1*8 +: 8]),
        .data2(data_mem[ 2*8 +: 8]),
        .data3(data_mem[ 8*8 +: 8]),
        .data4(data_mem[ 9*8 +: 8]),
        .data5(data_mem[10*8 +: 8]),
        .data6(data_mem[16*8 +: 8]),
        .data7(data_mem[17*8 +: 8]),
        .data8(data_mem[18*8 +: 8]),
        .weight0(weight_mem[(2*9+0)*8 +: 8]),
        .weight1(weight_mem[(2*9+1)*8 +: 8]),
        .weight2(weight_mem[(2*9+2)*8 +: 8]),
        .weight3(weight_mem[(2*9+3)*8 +: 8]),
        .weight4(weight_mem[(2*9+4)*8 +: 8]),
        .weight5(weight_mem[(2*9+5)*8 +: 8]),
        .weight6(weight_mem[(2*9+6)*8 +: 8]),
        .weight7(weight_mem[(2*9+7)*8 +: 8]),
        .weight8(weight_mem[(2*9+8)*8 +: 8]),
        .ans(conv_dot_D3)
    );


    wire [7:0] conv_compress_D1;
    wire [7:0] conv_compress_D2;
    wire [7:0] conv_compress_D3;
    compress_utility #(
        .SUM_WIDTH(20)
    ) u_conv_3x3_compress_D1(
        .sum_accum(conv_dot_D1),
        .ans(conv_compress_D1)
    );
    compress_utility #(
        .SUM_WIDTH(20)
    ) u_conv_3x3_compress_D2(
        .sum_accum(conv_dot_D2),
        .ans(conv_compress_D2)
    );
    compress_utility #(
        .SUM_WIDTH(20)
    ) u_conv_3x3_compress_D3(
        .sum_accum(conv_dot_D3),
        .ans(conv_compress_D3)
    );




    wire [7:0] conv_D1;
    wire [7:0] conv_D2;
    wire [7:0] conv_D3;
    conv_storage u_conv_storage(
        .clk(clk),
        .rst_n(rst_n),
        .in_vld(in_vld),
        .cnt(cnt),
        .ans_D1(conv_compress_D1),
        .ans_D2(conv_compress_D2),
        .ans_D3(conv_compress_D3),
        .conv_D1_reg(conv_D1),
        .conv_D2_reg(conv_D2),
        .conv_D3_reg(conv_D3)
    );

    wire [3*8-1:0] pool_lin_D1;
    wire [3*8-1:0] pool_lin_D2;
    wire [3*8-1:0] pool_lin_D3;
    pool_module u_pool_module(
        .clk(clk),
        .rst_n(rst_n),
        .in_vld(in_vld),
        .cnt(cnt),
        .conv_D1(conv_D1),
        .conv_D2(conv_D2),
        .conv_D3(conv_D3),
        .pool_lin_D1(pool_lin_D1),
        .pool_lin_D2(pool_lin_D2),
        .pool_lin_D3(pool_lin_D3)
    );

    wire [20:0] connect_dot_D1;
    wire [20:0] connect_dot_D2;
    wire [20:0] connect_dot_D3;
    connect_inner_dot u_connect_inner_dot_D1(
        .clk(clk),
        .rst_n(rst_n),
        .in_vld(in_vld),
        .cnt(cnt),
        .data_c0(pool_lin_D1[0*8 +: 8]),
        .data_c1(pool_lin_D1[1*8 +: 8]),
        .data_c2(pool_lin_D1[2*8 +: 8]),
        .weight0(weight_mem[(27+0*9+0)*8 +: 8]),
        .weight1(weight_mem[(27+0*9+1)*8 +: 8]),
        .weight2(weight_mem[(27+0*9+2)*8 +: 8]),
        .weight3(weight_mem[(27+0*9+3)*8 +: 8]),
        .weight4(weight_mem[(27+0*9+4)*8 +: 8]),
        .weight5(weight_mem[(27+0*9+5)*8 +: 8]),
        .weight6(weight_mem[(27+0*9+6)*8 +: 8]),
        .weight7(weight_mem[(27+0*9+7)*8 +: 8]),
        .weight8(weight_mem[(27+0*9+8)*8 +: 8]),
        .dot(connect_dot_D1)
    );
    connect_inner_dot u_connect_inner_dot_D2(
        .clk(clk),
        .rst_n(rst_n),
        .in_vld(in_vld),
        .cnt(cnt),
        .data_c0(pool_lin_D2[0*8 +: 8]),
        .data_c1(pool_lin_D2[1*8 +: 8]),
        .data_c2(pool_lin_D2[2*8 +: 8]),
        .weight0(weight_mem[(27+1*9+0)*8 +: 8]),
        .weight1(weight_mem[(27+1*9+1)*8 +: 8]),
        .weight2(weight_mem[(27+1*9+2)*8 +: 8]),
        .weight3(weight_mem[(27+1*9+3)*8 +: 8]),
        .weight4(weight_mem[(27+1*9+4)*8 +: 8]),
        .weight5(weight_mem[(27+1*9+5)*8 +: 8]),
        .weight6(weight_mem[(27+1*9+6)*8 +: 8]),
        .weight7(weight_mem[(27+1*9+7)*8 +: 8]),
        .weight8(weight_mem[(27+1*9+8)*8 +: 8]),
        .dot(connect_dot_D2)
    );
    connect_inner_dot u_connect_inner_dot_D3(
        .clk(clk),
        .rst_n(rst_n),
        .in_vld(in_vld),
        .cnt(cnt),
        .data_c0(pool_lin_D3[0*8 +: 8]),
        .data_c1(pool_lin_D3[1*8 +: 8]),
        .data_c2(pool_lin_D3[2*8 +: 8]),
        .weight0(weight_mem[(27+2*9+0)*8 +: 8]),
        .weight1(weight_mem[(27+2*9+1)*8 +: 8]),
        .weight2(weight_mem[(27+2*9+2)*8 +: 8]),
        .weight3(weight_mem[(27+2*9+3)*8 +: 8]),
        .weight4(weight_mem[(27+2*9+4)*8 +: 8]),
        .weight5(weight_mem[(27+2*9+5)*8 +: 8]),
        .weight6(weight_mem[(27+2*9+6)*8 +: 8]),
        .weight7(weight_mem[(27+2*9+7)*8 +: 8]),
        .weight8(weight_mem[(27+2*9+8)*8 +: 8]),
        .dot(connect_dot_D3)
    );

    connect_sum_all u_connect_sum_all(
        .clk(clk),
        .rst_n(rst_n),
        .cnt(cnt),
        .dot_D1(connect_dot_D1),
        .dot_D2(connect_dot_D2),
        .dot_D3(connect_dot_D3),
        .ans_reg(dout)
    );


endmodule
