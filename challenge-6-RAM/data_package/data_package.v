module data_package_sync #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 7
) (
    input clk,
    input rst_n,
    input wen,
    input fin,
    input [DATA_WIDTH-1:0] pkg_in,
    input type,
    output [DATA_WIDTH-1:0] pkg_out,
    output [ADDR_WIDTH-1:0] pkg_num,
    output pkg_num_vld
);
    reg [ADDR_WIDTH-1:0] haddr,laddr;
    always @(posedge clk, negedge rst_n) begin
        if(~rst_n)
            haddr <= {ADDR_WIDTH{1'b1}};
        else if(wen & type)
            haddr <= haddr - 1'b1;
    end
    always @(posedge clk, negedge rst_n) begin
        if(~rst_n)
            laddr <= 0;
        else if(wen & ~type)
            laddr <= laddr + 1'b1;
    end

    wire ren;
    reg fin_reg;
    reg haddr_fin;
    reg laddr_fin;
    always @(posedge clk, negedge rst_n) begin
        if(~rst_n)
            fin_reg <= 1'b0;
        else if(fin)
            fin_reg <= 1'b1;
    end
    assign ren = (fin_reg | fin) & ~laddr_fin;

    wire [ADDR_WIDTH-1:0] waddr;
    reg [ADDR_WIDTH-1:0] raddr;
    assign waddr = (wen & type) ? haddr : laddr;
    always @(posedge clk, negedge rst_n) begin
        if(~rst_n) begin
            raddr <= 0;
            haddr_fin <= 1'b0;
            laddr_fin <= 1'b0;
        end
        else if(ren) begin    // read mode
            if(haddr != {ADDR_WIDTH{1'b1}} && ~haddr_fin) begin    // high address
                if(raddr == haddr + 1'b1) begin
                    raddr <= 0;
                    haddr_fin <= 1'b1;
                end
                else
                    raddr <= raddr - 1'b1; 
            end
            else begin   // low address
                if(raddr == laddr - 1'b1) begin
                    raddr <= raddr;
                    laddr_fin <= 1'b1;
                end
                else
                    raddr <= raddr + 1'b1;
            end
        end
        else if(wen & type) // preparation for high address
            raddr <= {ADDR_WIDTH{1'b1}};
    end

    simple_dual_port_ram_sync #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) u1 (
        .clka(clk),
        .clkb(clk),
        .rst_n(rst_n),
        .wena(wen),
        .renb(ren),
        .waddra(waddr),
        .raddrb(raddr),
        .dina(pkg_in),
        .doutb(pkg_out)
    );

    reg vld_reg;
    always @(posedge clk, negedge rst_n) begin
        if(~rst_n)
            vld_reg <= 1'b0;
        else
            vld_reg <= fin;
    end
    assign pkg_num_vld = vld_reg;

    reg [DATA_WIDTH-1:0] pkg_num_reg;
    always @(posedge clk, negedge rst_n) begin
        if(~rst_n)
            pkg_num_reg <= 0;
        else if(wen)
            pkg_num_reg <= pkg_num_reg + 1'b1;
    end
    assign pkg_num = pkg_num_reg;
    // assign pkg_num = {ADDR_WIDTH{1'b1}} - haddr + laddr - 2;

endmodule



module data_package_async #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 7
) (
    input clk,
    input rst_n,
    input wen,
    input [DATA_WIDTH-1:0] pkg_in,
    input type,
    output [DATA_WIDTH-1:0] pkg_out,
    output [ADDR_WIDTH-1:0] pkg_num,
    output pkg_num_vld
);
    reg [ADDR_WIDTH-1:0] haddr,laddr;
    always @(posedge clk, negedge rst_n) begin
        if(~rst_n)
            haddr <= {ADDR_WIDTH{1'b1}};
        else if(wen & type)
            haddr <= haddr - 1'b1;
    end
    always @(posedge clk, negedge rst_n) begin
        if(~rst_n)
            laddr <= 0;
        else if(wen & ~type)
            laddr <= laddr + 1'b1;
    end

    wire ren;
    reg haddr_fin;
    reg laddr_fin;
    reg w_flag;
    always @(posedge clk, negedge rst_n) begin
        if(~rst_n)
            w_flag <= 1'b0;
        else if(wen)
            w_flag <= 1'b1;
    end
    assign ren = ~wen & ~laddr_fin & w_flag;
    reg r_flag;
    always @(posedge clk, negedge rst_n) begin
        if(~rst_n)
            r_flag <= 1'b0;
        else if(ren)
            r_flag <= 1'b1;
    end
    assign pkg_num_vld = ren | r_flag;

    wire [ADDR_WIDTH-1:0] waddr;
    reg [ADDR_WIDTH-1:0] raddr;
    assign waddr = type ? haddr : laddr;
    always @(posedge clk, negedge rst_n) begin
        if(~rst_n) begin
            raddr <= 0;
            haddr_fin <= 1'b0;
            laddr_fin <= 1'b0;
        end
        else if(ren) begin    // read mode
            if(haddr != {ADDR_WIDTH{1'b1}} && ~haddr_fin) begin    // high address
                if(raddr == haddr + 1'b1) begin
                    raddr <= 0;
                    haddr_fin <= 1'b1;
                end
                else
                    raddr <= raddr - 1'b1; 
            end
            else begin   // low address
                if(raddr == laddr - 1'b1) begin
                    raddr <= raddr;
                    laddr_fin <= 1'b1;
                end
                else
                    raddr <= raddr + 1'b1;
            end
        end
        else if(wen & type) // preparation for high address
            raddr <= {ADDR_WIDTH{1'b1}};
    end

    simple_dual_port_ram_async #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) u1 (
        .clka(clk),
        .clkb(clk),
        .wena(wen),
        .renb(ren),
        .waddra(waddr),
        .raddrb(raddr),
        .dina(pkg_in),
        .doutb(pkg_out)
    );

    reg [DATA_WIDTH-1:0] pkg_num_reg;
    always @(posedge clk, negedge rst_n) begin
        if(~rst_n)
            pkg_num_reg <= 0;
        else if(wen)
            pkg_num_reg <= pkg_num_reg + 1'b1;
    end
    assign pkg_num = pkg_num_reg;

endmodule