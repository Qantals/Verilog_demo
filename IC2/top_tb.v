`timescale 1ns/1ps
module top_tb;
    reg clk;
    reg rst_n;
    reg mode;
    reg [7:0] din;
    reg ram_en;

    wire [7:0] dout;
    wire out_data_flag;

    top u_top(
        .clk(clk),
        .rst_n(rst_n),
        .mode(mode),
        .din(din),
        .ram_en(ram_en),

        .dout(dout),
        .out_data_flag(out_data_flag)
    );

    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    reg [7:0] data_mem [8*8*1*100-1:0];
    reg [7:0] weight_mem [3*3*3*2-1:0];
    reg [7:0] output_mem [100-1:0];
    integer index_data,index_weight;
    integer i_pic;
    integer i_check;
    // integer cnt_clk;
    initial begin
        // $readmemb("../sample_100/data.txt",data_mem);
        // $readmemb("../sample_100/weight.txt",weight_mem);
        // $readmemb("../sample_100/output.txt",output_mem);
        $readmemb("D:/IC2/primaAI_check/git_share/sample_100/data.txt",data_mem);
        $readmemb("D:/IC2/primaAI_check/git_share/sample_100/weight.txt",weight_mem);
        $readmemb("D:/IC2/primaAI_check/git_share/sample_100/output.txt",output_mem);
    end

    initial begin
        i_pic = 0;
        rst_n = 0;
        mode = 0;
        din = 0;
        ram_en = 0;
        #11 rst_n = 1;

        // get in weight
        ram_en = 1;
        mode = 1;
        for(index_weight = 0; index_weight <= 53; index_weight = index_weight + 1) begin
            din = weight_mem[index_weight];
            @(posedge clk);
            #1;
        end
        ram_en = 0;
        // pass and calculate
        for(i_pic = 0; i_pic <= 99; i_pic = i_pic + 1) begin
            // i_pic = 4;
            // get in data
            for(index_data = 0; index_data <= 63; index_data = index_data + 1) begin
                ram_en = 1;
                mode = 0;
                din = data_mem[index_data+i_pic*64];
                @(posedge clk);
                #1;
                // if({$random} % 2) begin
                //     ram_en = 0;
                //     @(posedge clk);
                //     #1;
                // end
            end
        end
    end

    initial begin
        i_check = 0;
        while(i_check <= 99) begin
            // calculate
            @(posedge out_data_flag);
            #10;
            // while(out_data_flag != 1) begin
            //     @(posedge clk);
            //     #1;
            // end


            // check
            if($signed(output_mem[i_check]) == $signed(dout))
                $display("%0d:check OK,dout=%0d",i_check,$signed(dout));
            else
                $display("%0d:check fail,dout=%0d,standard=%0d",i_check,$signed(dout),$signed(output_mem[i_check]));
            i_check = i_check + 1;
        end
        // $display("clk cnt=%0d",cnt_clk);
        $finish;
    end


endmodule
