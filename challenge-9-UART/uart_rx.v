module uart_rx #(
    parameter DATA_WIDTH = 8,
    parameter PARITY_ON = 1,
    parameter PARITY_ODD = 1,
    parameter STOP_BIT = 1  // choose 1 / 2 / 3=1.5
)(
    input clk,  // (9600 * 16)Hz
    input rst_n,
    input rx,
    output [DATA_WIDTH-1:0] data_pkg,
    output prity_vld,
    output done
);
    reg [15:0] rx_reg;
    reg [3:0] bps16_cnt;
    reg [3:0] data_num_cnt;
    reg stop_fin;

    reg [2:0] state_cur,state_nxt;
    parameter IDLE_S = 3'b000,
            START_S  = 3'b001,
            DATA_S   = 3'b011,
            PRITY_S  = 3'b010,
            STOP_S   = 3'b110;
    always @(posedge clk, negedge rst_n) begin
        if(~rst_n)
            state_cur <= IDLE_S;
        else
            state_cur <= state_nxt;
    end
    always @(*) begin
        case (state_cur)
            IDLE_S:  state_nxt = ~(|rx_reg[7:0]) ? START_S : IDLE_S;
            START_S: state_nxt = (bps16_cnt == 7) ? DATA_S : START_S;
            DATA_S:  state_nxt = (data_num_cnt == DATA_WIDTH && bps16_cnt == 15) ?
                (PARITY_ON ? PRITY_S : STOP_S) : DATA_S;
            PRITY_S: state_nxt = (bps16_cnt == 15) ? STOP_S : PRITY_S;
            STOP_S:  state_nxt = (stop_fin) ? IDLE_S : STOP_S;
            default: state_nxt = IDLE_S;
        endcase
    end

    // rx_reg
    always @(posedge clk, negedge rst_n) begin
        if(~rst_n)
            rx_reg <= 16'hFFFF;
        else
            rx_reg <= {rx_reg[14:0], rx};   // left shift
    end

    // bps16_cnt
    always @(posedge clk, negedge rst_n) begin
        if(~rst_n)
            bps16_cnt <= 0;
        else begin
            case (state_cur)
                IDLE_S:  bps16_cnt <= 0;
                START_S: bps16_cnt <= (bps16_cnt == 7) ? 0 : bps16_cnt + 1;
                default: bps16_cnt <= bps16_cnt + 1;
            endcase
        end
    end

    // data_num_cnt
    always @(posedge clk, negedge rst_n) begin
        if(~rst_n)
            data_num_cnt <= 0;
        else if(state_cur == DATA_S && bps16_cnt == 9)
            data_num_cnt <= data_num_cnt + 1;
        else if(state_cur == IDLE_S)
            data_num_cnt <= 0;
    end

    // data_pkg_reg
    reg [DATA_WIDTH-1:0] data_pkg_reg;
    wire rx_ave;
    assign rx_ave = (rx_reg[0] & rx_reg[1]) | (rx_reg[0] & rx_reg[2]) | (rx_reg[1] & rx_reg[2]);
    always @(posedge clk, negedge rst_n) begin
        if(~rst_n)
            data_pkg_reg <= 0;
        else if(state_cur == DATA_S && bps16_cnt == 9)   // rx_reg[2:0] --> the 7/8/9 data of 1~16 samples
            data_pkg_reg <= {rx_ave, data_pkg_reg[DATA_WIDTH-1:1]}; // right shift (LSB first)
    end
    assign data_pkg = data_pkg_reg;

    // prity_reg
    reg prity_reg;
    wire odd_check;
    assign odd_check = ^{data_pkg, prity_reg};
    always @(posedge clk, negedge rst_n) begin
        if(~rst_n)
            prity_reg <= 0;
        else if(state_cur == PRITY_S && bps16_cnt == 9)
            prity_reg <= rx_ave;
    end
    assign prity_vld = PARITY_ON ? (PARITY_ODD ? odd_check : ~odd_check) : 1'b0;

    // stop_fin
    reg [1:0] stop_bit_cnt;
    always @(posedge clk,negedge rst_n) begin
        if(~rst_n)
            stop_bit_cnt <= 0;
        else if(state_cur == STOP_S && bps16_cnt == 15)
            stop_bit_cnt <= stop_bit_cnt + 1;
        else if(state_cur == IDLE_S)
            stop_bit_cnt <= 0;
    end
    always @(*) begin
        case (STOP_BIT)
            3:   stop_fin = (stop_bit_cnt == 1 && bps16_cnt == 7);
            2:   stop_fin = (stop_bit_cnt == 1 && bps16_cnt == 15);
            default: stop_fin = (stop_bit_cnt == 0 && bps16_cnt == 15);
        endcase
    end

    // done
    reg done_reg;
    always @(posedge clk, negedge rst_n) begin
        if(~rst_n)
            done_reg <= 0;
        else if(state_cur == STOP_S && stop_fin)
            done_reg <= 1;
        else if(state_cur == IDLE_S)
            done_reg <= 0;
    end
    assign done = done_reg;

endmodule
