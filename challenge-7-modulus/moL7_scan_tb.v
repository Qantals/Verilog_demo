`timescale 1ps/1ps
module test ();
    reg clk;
    reg rst_n;
    reg data_in;
    wire vld;

    mol7 u1(
        .clk(clk),
        .rst_n(rst_n),
        .data_in(data_in),
        .vld(vld)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // initial begin
    //     rst_n = 1'b0;
    //     data_in = 1'b0;
    //     #6 rst_n = 1;
    //     data_in = 1'b1;
    //     #10 data_in = 1'b1;
    //     #10 data_in = 1'b1;
    //     #10 data_in = 1'b0;
    //     #10 data_in = 1'b1;
    //     #10 data_in = 1'b0;
    //     #10 data_in = 1'b0;
    //     #10 data_in = 1'b1;
    // end

    reg [31:0] seq_num;
    initial begin
        rst_n = 1'b0;
        data_in = 1'b0;
        seq_num = 0;
        #6 rst_n = 1'b1;
        forever begin
            data_in = {$random};
            seq_num = (seq_num << 1) + data_in;
            #10;
        end
    end

    reg check;
    always @(posedge clk) begin
        if(rst_n) begin
            #2;
            check = ((seq_num % 7 == 0 && vld) || (seq_num % 7 != 0 && ~vld)) ? 1'b1 : 1'b0;
        end
    end

endmodule