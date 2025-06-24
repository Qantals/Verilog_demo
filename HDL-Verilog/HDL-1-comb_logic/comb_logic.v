`timescale 1ns/1ns

module comb_logic(
    input a,b,c,
    output f
);
    wire n1,n2,n3;

    assign n1 = ~ a;
    assign n2 = n1 & b;
    assign n3 = a ^ c;
    assign f = n2 | n3;
    
endmodule