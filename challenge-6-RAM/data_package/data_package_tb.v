`timescale 1ps/1ps
module test (
    output reg check_num,
    output reg check_data
);
    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 7;
    reg clk;
    reg rst_n;
    reg wen;
    // reg fin;
    reg [DATA_WIDTH-1:0] pkg_in;
    reg type;
    wire [DATA_WIDTH-1:0] pkg_out;
    wire [ADDR_WIDTH-1:0] pkg_num;
    wire pkg_num_vld;

    // data_package_sync #(
    //     .DATA_WIDTH(DATA_WIDTH),
    //     .ADDR_WIDTH(ADDR_WIDTH)
    // ) u1 (
    //     .clk(clk),
    //     .rst_n(rst_n),
    //     .wen(wen),
    //     .fin(fin),
    //     .pkg_in(pkg_in),
    //     .type(type),
    //     .pkg_out(pkg_out),
    //     .pkg_num(pkg_num),
    //     .pkg_num_vld(pkg_num_vld)
    // );
    data_package_async #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) u1 (
        .clk(clk),
        .rst_n(rst_n),
        .wen(wen),
        .pkg_in(pkg_in),
        .type(type),
        .pkg_out(pkg_out),
        .pkg_num(pkg_num),
        .pkg_num_vld(pkg_num_vld)
    );
    // check module
    reg [ADDR_WIDTH-1:0] check_pkg_num_low;
    reg [ADDR_WIDTH-1:0] check_pkg_num_high;
    reg [DATA_WIDTH-1:0] check_pkg_out_low [2**ADDR_WIDTH-1:0];
    reg [DATA_WIDTH-1:0] check_pkg_out_high [2**ADDR_WIDTH-1:0];
    reg [ADDR_WIDTH-1:0] check_read_addr;
    task check_data_put;
        input type;
        input [DATA_WIDTH-1:0] data;
        if(type) begin
            check_pkg_out_high[check_pkg_num_high] = data;
            check_pkg_num_high = check_pkg_num_high + 1;
        end
        else begin
            check_pkg_out_low[check_pkg_num_low] = data;
            check_pkg_num_low = check_pkg_num_low + 1;
        end
    endtask

    // simulation
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    reg [3:0] rand_pkg_len;
    integer i,j,k;
    initial begin
        for(k = 0; k < 5; k = k + 1) begin
            check_pkg_num_high = 0;
            check_pkg_num_low = 0;
            rst_n = 1'b0;
            wen = 1'b0;
            // fin = 1'b0;
            pkg_in = 0;
            type = 1'b0;
            rand_pkg_len = 0;
            @(posedge clk);
            #1;
            rst_n = 1'b1;
            wen = 1'b1;
            for(i = 0; i < 10; i = i + 1) begin
                rand_pkg_len = 4 + {$random} % (10 - 4 + 1);    // 4~10
                type = $random;
                for(j = 0; j < rand_pkg_len; j = j + 1) begin
                    pkg_in = $random;  // auto trunk
                    check_data_put(type,pkg_in);
                    // if(i >= 9 && j >= rand_pkg_len - 1)
                    //     fin = 1'b1;
                    @(posedge clk);
                    #1;
                end
            end
            // fin = 1'b0;
            wen = 1'b0;
            #1;
            // OK for read check
            if(pkg_num_vld && pkg_num == check_pkg_num_high + check_pkg_num_low)
                check_num = 1'b1;
            else begin
                check_num = 1'b0;
                $display("wrong pkg num!");
                $finish;
            end
            if(check_pkg_num_high != 0) begin
                check_read_addr = 0;
                while (check_read_addr < check_pkg_num_high) begin
                    if(pkg_out == check_pkg_out_high[check_read_addr])
                        check_data = 1'b1;
                    else begin
                        check_data = 1'b0;
                        $display("wrong data!");
                        $finish;
                    end
                    @(posedge clk);
                    #1;
                    check_read_addr = check_read_addr + 1;
                end
            end
            if(check_pkg_num_low != 0) begin
                check_read_addr = 0;
                while (check_read_addr < check_pkg_num_low) begin
                    if(pkg_out == check_pkg_out_low[check_read_addr])
                        check_data = 1'b1;
                    else begin
                        check_data = 1'b0;
                        $display("wrong data!");
                        $finish;
                    end
                    @(posedge clk);
                    #1;
                    check_read_addr = check_read_addr + 1;
                end
            end
            // @(u1.ren == 1'b0);
            #100;
        end
    end

endmodule
