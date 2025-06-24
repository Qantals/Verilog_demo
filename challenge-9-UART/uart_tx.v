module uart_tx #(
    parameter DATA_WIDTH = 8,
    parameter PARITY_ON = 1,
    parameter PARITY_ODD = 1,
    parameter STOP_BIT = 1  // choose 1 / 2
)(
    input clk,  // 9600Hz
    input rst_n,
    input [DATA_WIDTH-1:0] data_pkg,
    input en,   // only hold for one clock
    output tx,
    output done
);
    reg [3:0] data_num_cnt;
    wire stop_fin;

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
            IDLE_S:  state_nxt = (en) ? START_S : IDLE_S;
            START_S: state_nxt = DATA_S;
            DATA_S:  state_nxt = (data_num_cnt == DATA_WIDTH - 1) ?
                (PARITY_ON ? PRITY_S : STOP_S) : DATA_S;
            PRITY_S: state_nxt = STOP_S;
            STOP_S:  state_nxt = (stop_fin) ? IDLE_S : STOP_S;
            default: state_nxt = IDLE_S;
        endcase
    end

    // data_num_cnt
    always @(posedge clk, negedge rst_n) begin
        if(~rst_n)
            data_num_cnt <= 0;
        else if(state_cur == DATA_S)
            data_num_cnt <= data_num_cnt + 1;
        else if(state_cur == IDLE_S)
            data_num_cnt <= 0;
    end

    // tx_reg
    reg tx_reg;
    always @(*) begin
        case (state_cur)
            START_S: tx_reg <= 1'b0;
            DATA_S:  tx_reg <= data_pkg[data_num_cnt];
            PRITY_S: tx_reg <= PARITY_ODD ? (~(^data_pkg)) : (^data_pkg);   // already ensure PRITY_ON = 1
            default: tx_reg <= 1'b1;
        endcase
    end
    assign tx = tx_reg;

    // stop_fin
    reg stop_bit_cnt;
    always @(posedge clk,negedge rst_n) begin
        if(~rst_n)
            stop_bit_cnt <= 0;
        else if(state_cur == STOP_S)
            stop_bit_cnt <= stop_bit_cnt + 1;
        else if(state_cur == IDLE_S)
            stop_bit_cnt <= 0;
    end
    assign stop_fin = (stop_bit_cnt == STOP_BIT - 1);

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
