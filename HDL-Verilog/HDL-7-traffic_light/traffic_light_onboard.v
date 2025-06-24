`timescale 1ms/100us

module traffic_light (
    input CLK50MHz,
    input nRST,
    output [6:0] seg,
    output [5:0] dig,
    output [7:0] led
);

    //clk division
    wire CLK1Hz;
    wire CLK1KHz;
    clock_division #(.DIVCLK_CNTMAX(25_000_000-1))
        light_clock(
            .clk_in(CLK50MHz),
            .rst_n(nRST),
            .divclk(CLK1Hz)
    );
    clock_division #(.DIVCLK_CNTMAX(25_000-1))
        display_clock(
            .clk_in(CLK50MHz),
            .rst_n(nRST),
            .divclk(CLK1KHz)
    );

    //led show
    wire [3:0] num_1,num_2,num_5,num_6;
    led_show led_show(
        .rst_n(nRST),
        .CLK1K(CLK1KHz),
        .num_1(num_1),
        .num_2(num_2),
        .num_3(4'hA),
        .num_4(4'hA),
        .num_5(num_5),
        .num_6(num_6),
        .dig(dig),
        .seg(seg)
    );

    //bcd convert
    reg [5:0] num_A,num_B;
    bin2bcd bin2bcd_A(
        .bin(num_A),
        .bcd_1(num_1),
        .bcd_2(num_2)
    );
    bin2bcd bin2bcd_B(
        .bin(num_B),
        .bcd_1(num_5),
        .bcd_2(num_6)
    );

    //traffic time counter
    reg [5:0] cnt_traf;//0~59
    always @(posedge CLK1Hz,negedge nRST) begin
        if(~nRST)
            cnt_traf<=59;
        else begin
            if(cnt_traf==0)
                cnt_traf<=59;
            else
                cnt_traf<=cnt_traf-1;
        end
    end

    //A path control(59~30:stop; 29~0:start)
    reg [2:0] led_A;
    always @(*) begin
        if(!nRST) begin
            led_A=3'b000;
            num_A=cnt_traf-30+1;    //as cnt_traf=59
        end else if(cnt_traf>=30) begin
            led_A=3'b100;   //red light
            num_A=cnt_traf-30+1;
        end else if(cnt_traf>=5) begin
            led_A=3'b001;   //green light
            num_A=cnt_traf-5+1;
        end else begin
            led_A=3'b010;   //yellow light
            num_A=cnt_traf+1;
        end
    end

    //B path control(59~30:start; 29~0:stop)
    reg [2:0] led_B;
    always @(*) begin
        if(!nRST) begin
            led_B=3'b000;
            num_B=cnt_traf+1;    //as cnt_traf=59
        end else if(cnt_traf<=29) begin
            led_B=3'b100;   //red light
            num_B=cnt_traf+1;
        end else if(cnt_traf<=34) begin
            led_B=3'b010;   //yellow light
            num_B=cnt_traf-30+1;
        end else begin
            led_B=3'b001;   //green light
            num_B=cnt_traf-35+1;
        end
    end

    //led mapping
    assign led[7:5]=led_B;
    assign led[2:0]=led_A;
    assign led[4:3]=2'b00;

endmodule