`timescale 1ns/1ns

module test;
    reg a,b,c;
    wire f;
    integer i;

    comb_logic uut(
        .a(a),
        .b(b),
        .c(c),
        .f(f)
    );

    always begin
        for(i=0;i<=7;i=i+1) begin
            {a,b,c}=i;
            #10;
        end
        $finish;
    end
endmodule