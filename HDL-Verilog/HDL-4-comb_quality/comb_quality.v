`timescale 1ns/1ns

module comb_quality (
    input A,B,C,
    output reg F1,F2,F3
);

    always @(A,B,C) begin
        if(A && B && C)         //{A,B,C}=3'b111
            {F1,F2,F3}=3'b100;
        else if(A && (B || C))  //{A,B,C}=3'b101 || {A,B,C}=3'b110
            {F1,F2,F3}=3'b010;
        else if(~A && (B && C)) //{A,B,C}=3'b011
            {F1,F2,F3}=3'b001;
        else
            {F1,F2,F3}=3'b000;
    end
    
endmodule