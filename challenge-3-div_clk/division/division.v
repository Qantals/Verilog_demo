module division #(
    parameter N = 5
)(
    input clk,
    input rst_n,
    output div_out
);
    wire div_even,div_odd;
    div_even #(
        .N(N & 32'hFFFF_FFFE)
    ) u_even (
        .clk(clk),
        .rst_n(rst_n),
        .div_even(div_even)
    );
    div_odd #(
        .N(N | 32'h1)
    ) u_odd (
        .clk(clk),
        .rst_n(rst_n),
        .div_odd(div_odd)
    );

    assign div_out = (N & 32'h1 == 32'h1) ? div_odd : div_even;

endmodule
