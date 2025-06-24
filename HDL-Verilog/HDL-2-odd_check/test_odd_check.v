`timescale 1ns/1ns

module test;
    // reg [5:0] din[2:0];
    // wire dout[2:0];

    // genvar gen_i;
    // generate
    //     for(gen_i=2; gen_i<=6; gen_i=gen_i+2) begin
    //         odd_check #(
    //             .N(gen_i)
    //         ) check_inst (
    //             .din(din[gen_i/2-1][gen_i-1:0]),
    //             .dout(dout[gen_i/2-1])
    //         );
    //     end
    // endgenerate

    reg [1:0] din_2;
    reg [3:0] din_4;
    reg [5:0] din_6;
    wire dout_2,dout_4,dout_6;

    odd_check #(
        .N(2)
    ) odd_check_2_inst (
        .din(din_2),
        .dout(dout_2)
    );

    odd_check #(
        .N(4)
    ) odd_check_4_inst (
        .din(din_4),
        .dout(dout_4)
    );

    odd_check #(
        .N(6)
    ) odd_check_6_inst (
        .din(din_6),
        .dout(dout_6)
    );

    // integer force_i;
    // initial begin:force_all
    //     for(force_i=0; force_i<2**6; force_i=force_i+1) begin
    //         din[0]=force_i<2**2 ? force_i : 'bz;
    //         din[1]=force_i<2**4 ? force_i : 'bz;
    //         din[2]=force_i;
    //         #10;
    //     end
    //     $finish;
    // end

    integer force_i;
    initial begin
        for(force_i=0; force_i<2**6; force_i=force_i+1) begin
            din_2=force_i<2**2 ? force_i : 'bz;
            din_4=force_i<2**4 ? force_i : 'bz;
            din_6=force_i;
            #10;
        end
        $finish;
    end

    //check=1 :has odd  '1' in total
    //check=0 :has even '1' in total
    wire check_2,check_4,check_6;
    assign check_2=(^din_2)^dout_2;
    assign check_4=(^din_4)^dout_4;
    assign check_6=(^din_6)^dout_6;

endmodule