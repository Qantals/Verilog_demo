module bin2bcd (
    input [5:0] bin,
    output [3:0] bcd_1,bcd_2
);
    integer i;
    reg [7:0] bcd_tmp;
    reg [5:0] bin_reg;
    always @(*) begin
        bin_reg=bin;
        bcd_tmp=0;
        repeat(6) begin
            if(bcd_tmp[3:0]>=5)
                bcd_tmp=bcd_tmp+3;
            if(bcd_tmp[7:4]>=5)
                bcd_tmp=bcd_tmp+(3<<4);
            bcd_tmp={bcd_tmp[6:0],bin_reg[5]};
            bin_reg=bin_reg<<1;
        end
    end

    assign bcd_1=bcd_tmp[3:0];
    assign bcd_2=bcd_tmp[7:4];

endmodule