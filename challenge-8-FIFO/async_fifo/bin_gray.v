module bin2gray_N
#(
    parameter N = 4
)(
    input [N-1:0] bin,
    output [N-1:0] gray
);
    assign gray = bin ^ (bin >> 1);
endmodule


module gray2bin_N
#(
    parameter N = 4
)(
    input [N-1:0] gray,
    output [N-1:0] bin
);
    assign bin = {gray[N-1], bin[N-1:1] ^ gray[N-2:0]};
endmodule
