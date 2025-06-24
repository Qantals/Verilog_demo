module gray2bin_4(
    input [3:0] gray,
    output [3:0] bin
);
    reg [3:0] bin_reg;
    always @(*)
        case(gray)
           4'b0000: bin_reg = 4'b0000;
           4'b0001: bin_reg = 4'b0001;
           4'b0011: bin_reg = 4'b0010;
           4'b0010: bin_reg = 4'b0011;
           4'b0110: bin_reg = 4'b0100;
           4'b0111: bin_reg = 4'b0101;
           4'b0101: bin_reg = 4'b0110;
           4'b0100: bin_reg = 4'b0111;

           4'b1100: bin_reg = 4'b1000;
           4'b1101: bin_reg = 4'b1001;
           4'b1111: bin_reg = 4'b1010;
           4'b1110: bin_reg = 4'b1011;
           4'b1010: bin_reg = 4'b1100;
           4'b1011: bin_reg = 4'b1101;
           4'b1001: bin_reg = 4'b1110;
           4'b1000: bin_reg = 4'b1111;
            default: bin_reg = 4'b0000;
        endcase
    
    assign bin = bin_reg;
endmodule




module gray2bin_N
#(
    parameter N = 4
)(
    input [N-1:0] gray,
    output [N-1:0] bin
);
    // reg [N-1:0] bin_reg;
    // integer i;
    // always @(*) begin
    //     bin_reg[N-1] = gray[N-1];
    //     for(i = N-2; i >= 0; i = i - 1)
    //         bin_reg[i] = gray[i] ^ bin_reg[i+1];
    // end
    // assign bin = bin_reg;

    assign bin = {gray[N-1], bin[N-1:1] ^ gray[N-2:0]};
    
endmodule
