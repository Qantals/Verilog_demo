`timescale 1ns/1ns

module mux_4(
    input [3:0] din,
    input [1:0] sel,
    output reg dout
);
    
    always @(din,sel) begin
        case(sel)
            2'b00: dout=din[0];
            2'b01: dout=din[1];
            2'b10: dout=din[2];
            2'b11: dout=din[3];
            default: dout=1'bz;
        endcase
    end

    // assign dout=din[sel];
    
endmodule