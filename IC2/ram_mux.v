`timescale 1ns/1ps
module ram_mux (
    input mode,
    input ram_en,

    output weight_ram_en,
    output data_ram_en
);

    // MODE_DATA = 0, MODE_WEIGHT = 1
    assign data_ram_en = ram_en & ~mode;
    assign weight_ram_en = ram_en & mode;

endmodule
