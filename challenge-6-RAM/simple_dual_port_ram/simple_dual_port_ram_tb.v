`timescale 1ps/1ps
module test ();
    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 7;    // depth = 2**7 = 128
    reg clk;
    // reg rst_n;
    reg wena;
    reg renb;
    reg [ADDR_WIDTH-1:0] waddra;
    reg [ADDR_WIDTH-1:0] raddrb;
    reg [DATA_WIDTH-1:0] dina;
    wire [DATA_WIDTH-1:0] doutb;

    // simple_dual_port_ram_sync #(
    //     .DATA_WIDTH(DATA_WIDTH),
    //     .ADDR_WIDTH(ADDR_WIDTH)
    // ) u1 (
    //     .clka(clk),
    //     .clkb(clk),
    //     .rst_n(rst_n),
    //     .wena(wena),
    //     .renb(renb),
    //     .waddra(waddra),
    //     .raddrb(raddrb),
    //     .dina(dina),
    //     .doutb(doutb)
    // );
    simple_dual_port_ram_async #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) u1 (
        .clka(clk),
        .clkb(clk),
        .wena(wena),
        .renb(renb),
        .waddra(waddra),
        .raddrb(raddrb),
        .dina(dina),
        .doutb(doutb)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // write data
    integer i;
    initial begin
        wena = 1'b0;
        waddra = 0;
        dina = 0;
        // rst_n = 1'b0;
        #6;
        wena = 1'b1;
        // rst_n = 1'b1;
        for(i = 0; i < 2**ADDR_WIDTH; i = i + 1) begin
            waddra = i;
            dina = dina + 1'b1;
            #10;
        end
    end

    // read data
    integer j;
    initial begin
        renb = 1'b0;
        raddrb = 0;
        #16;
        renb = 1'b1;
        for(j = 0; j < 2**ADDR_WIDTH; j = j + 1) begin
            raddrb = j;
            #10;
        end
    end

endmodule
