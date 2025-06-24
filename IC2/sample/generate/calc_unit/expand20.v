`timescale 1ns/1ps
module expand20 (
    input signed [15:0] dot,
    output signed [19:0] expand  
);
    assign expand = dot;
    
endmodule
