`timescale 1ns/1ns

module test;
    reg A,B,C;
    wire F1,F2,F3;

    comb_quality uut(
        .A(A),
        .B(B),
        .C(C),
        .F1(F1),
        .F2(F2),
        .F3(F3)
    );

    integer i;
    initial begin
        for(i=0;i<=7;i=i+1) begin
            {A,B,C}=i[3:0];
            #10;
        end
        $finish;
    end

endmodule