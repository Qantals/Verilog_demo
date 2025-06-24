`timescale 1ns/1ns

module odd_check #(
    parameter N=8
) (
    input [N-1:0] din,
    output dout
);

    assign dout=~(^din);
    
endmodule