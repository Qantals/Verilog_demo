module led_show(
    input rst_n,
    input CLK1K,
    input [3:0] num_1,num_2,num_3,num_4,num_5,num_6,
    output reg [5:0] dig,
    output reg [6:0] seg
    );

    //dig generate
    always @(posedge CLK1K,negedge rst_n) begin
        if(!rst_n)
            dig<=6'b111_110;
        else
            dig<={dig[4:0],dig[5]};
    end

    //choose a num
    reg [3:0] num;
    always@(*) begin
        if(!rst_n)
            num = 4'hA;
        else begin
            case(dig)
                6'b111_110 : num = num_1;
                6'b111_101 : num = num_2;
                6'b111_011 : num = num_3;
                6'b110_111 : num = num_4;
                6'b101_111 : num = num_5;
                6'b011_111 : num = num_6;
                default : num = 4'hA;   //(A~F means seg off)
            endcase
        end
    end

    //dig output(A~F means seg off)
    always@(*)
        case(num)
            4'h0 : seg = 7'h3f;
            4'h1 : seg = 7'h06;
            4'h2 : seg = 7'h5b;
            4'h3 : seg = 7'h4f;
            4'h4 : seg = 7'h66;
            4'h5 : seg = 7'h6d;
            4'h6 : seg = 7'h7d;
            4'h7 : seg = 7'h07;
            4'h8 : seg = 7'h7f;
            4'h9 : seg = 7'h6f;
            default :seg = 7'h00;
        endcase

endmodule
