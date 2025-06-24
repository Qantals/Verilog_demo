module simple_dual_port_ram_sync #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 7    // depth = 2**7 = 128
) (
    input clka,
    input clkb,
    input rst_n,
    input wena,
    input renb,
    input [ADDR_WIDTH-1:0] waddra,
    input [ADDR_WIDTH-1:0] raddrb,
    input [DATA_WIDTH-1:0] dina,
    output [DATA_WIDTH-1:0] doutb
);
    reg [DATA_WIDTH-1:0] mem [2**ADDR_WIDTH-1:0];
    always @(posedge clka) begin
        if(wena)
            mem[waddra] <= dina;
    end

    reg [DATA_WIDTH-1:0] doutb_reg;
    always @(posedge clkb, negedge rst_n) begin
        if(~rst_n)
            doutb_reg <= 0;
        else if(renb)
            doutb_reg <= mem[raddrb];
    end
    assign doutb = doutb_reg;

endmodule

module simple_dual_port_ram_async #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 7
) (
    input clka,
    input clkb,
    input wena,
    input renb,
    input [ADDR_WIDTH-1:0] waddra,
    input [ADDR_WIDTH-1:0] raddrb,
    input [DATA_WIDTH-1:0] dina,
    output [DATA_WIDTH-1:0] doutb
);
    reg [DATA_WIDTH-1:0] mem [2**ADDR_WIDTH-1:0];
    always @(posedge clka) begin
        if(wena)
            mem[waddra] <= dina;
    end

    assign doutb = renb ? mem[raddrb] : 0;

endmodule
