module sdram_top(
    input clk_50M,
    input rst_n, //press S2 to reset

    output sdram_clk,
    output sdram_cs,
    output sdram_ras,
    output sdram_cas,
    output sdram_we,

    output [12:0] sdram_adr,
    output [1:0]  sdram_ba,
    output [1:0]  sdram_dqm,
    inout  [15:0] sdram_dq,

    input rxp,
    output txp,
    output SDRAM_init_done
);


wire clk_133M;
wire aux_clk;
wire sdram_init_fin;

`include "print.svh"
defparam tx.uart_freq = 115200;
defparam tx.clk_freq = 133333000;


reg result;
assign txp = uart_txp;
//assign txp = result;
assign print_clk = clk_133M;
assign SDRAM_init_done = result;


reg cmd_en;
reg cmd_wr_rd;
wire cmd_av;

reg [9:0] cmd_len;
reg [24:0] cmd_adr;

wire [9:0] wr_remain_space;
reg wr_en;
reg [15:0] wr_data;
reg [1:0] wr_mask;

wire [9:0] rd_remain_space;
wire rd_av;
reg rd_en;
wire [15:0] rd_data;

reg [8:0] tx_cnt;
reg [2:0] rd_cnt;


reg [3:0] test_status;
reg [16*8-1:0] dataout;

reg [47:0] t_result0;
reg [47:0] t_result1;



always@(posedge clk_133M or negedge sdram_init_fin)begin
    if(!sdram_init_fin)begin
        cmd_en <= 1'b0;
        cmd_wr_rd <= 1'b0;
        cmd_len <= 10'd0;
        cmd_adr <= 25'd0;

        wr_en <= 1'b0;
        wr_data <= 16'd0;
        wr_mask <= 2'd0;

        rd_en <= 1'b0;

        test_status <= 4'd0;
        
        rd_cnt <= 3'd0;
        tx_cnt <= 8'd0;

        result <= 1'b0;
    end else begin
        tx_cnt <= tx_cnt + 8'd1;

        rd_en<=1'b0;
        cmd_en<=1'b0;
        wr_en<=1'b0;
        case(test_status)
            4'd0:begin
                wr_en <= 1'b1;
                wr_data <= 16'hAAAA;
                wr_mask <= 2'b00;
                test_status <= 4'd1;
                `print("\x0d\nWrite aaaa ffff 0000 to ram0. \x0d\nWrite 5555 0000 ffff to ram1.",STR);
                tx_cnt <= 0;
            end
            1:begin
                wr_en <= 1'b1;
                wr_data <= 16'hffff;
                test_status <= 4'd2;
            end
            2:begin
                wr_en <= 1'b1;
                wr_data <= 16'h0000;
                test_status <= 4'd3;
            end
            3:begin
                wr_en <= 1'b1;
                wr_data <= 16'h5555;
                test_status <= 4'd4;
            end
            4:begin
                wr_en <= 1'b1;
                wr_data <= 16'h0000;
                test_status <= 4'd5;
            end
            5:begin
                wr_en <= 1'b1;
                wr_data <= 16'hffff;
                test_status <= 4'd6;
            end
            6:begin
                cmd_en <= 1'b1;
                cmd_wr_rd <= 1'b0;
                cmd_len <= 10'd3;
                cmd_adr <= 25'h0;
                test_status <= 4'd7;
            end
            7:begin
                cmd_en <= 1'b1;
                cmd_wr_rd <= 1'b0;
                cmd_len <= 10'd3;
                cmd_adr <= 25'h1000000;
                test_status <= 4'd8;
            end
            8:begin
                cmd_en <= 1'b1;
                cmd_wr_rd <= 1'b1;
                cmd_len <= 10'd3;
                cmd_adr <= 25'h0;
                test_status <= 4'd9;
            end
            9:begin
                cmd_en <= 1'b1;
                cmd_wr_rd <= 1'b1;
                cmd_len <= 10'd3;
                cmd_adr <= 25'h1000000;
                test_status <= 4'd10;
            end
            10:begin
                if(rd_av)begin
                    rd_en <= 1'b1;
                end
                if(rd_av && rd_en)begin
                    rd_cnt <= rd_cnt + 3'd1;
                    dataout[(5-rd_cnt)*16+:16] <= rd_data;
                end

                if(tx_cnt > 96)begin
                    test_status <= 4'd11;
                    `print("\x0d\nRead from ram0:",STR);
                end
            end
            11:begin
                if(tx_cnt > 128)begin
                    test_status <= 4'd12;
                    `print(dataout[95:48],6);//6 Byte Data
                end
            end
            12:begin
                if(tx_cnt > 144)begin
                    test_status <= 4'd13;
                    `print("\x0d\nRead from ram1:",STR);
                end
            end
            13:begin
                if(tx_cnt > 176)begin
                    test_status <= 4'd14;
                    `print(dataout[47:0],6);//6 Byte Data
                end
            end
            14:begin
                if(tx_cnt>192)begin
                    test_status <= 4'd15;
                    t_result0 = dataout[95:48];
                    t_result1 = dataout[47:0];
                    if(t_result0 == 48'haaaaffff0000 && t_result1 == 48'h55550000ffff )begin
                        `print("\x0d\n\x0d\n[OK] [OK] [OK] [OK] [OK] [OK]\x0d\n",STR);
                        result <= 1'b1;
                    end
                    else begin
                        `print("\x0d\n\x0d\n[TEST FAILED] !!!!!!!!!!!!!!!\x0d\n",STR);
                        result <= 1'b0;
                    end
                end
            end
        endcase
    end
end

wire sdram_clk_p;

SDRAM_PLL SDRAM_PLL(
    .clkout0(clk_133M), //output clkout0
    .clkout1(sdram_clk_p),
    .clkout2(aux_clk),
    .clkin(clk_50M) //input clkin
);

IODELAY sdram_clk_dly(
    .DO(sdram_clk),
    .DF(),
    .DI(sdram_clk_p),
    .SDTAP(1'b0),
    .VALUE(1'b0),
    .DLYSTEP(8'b0)
);

//25C

//104 bad
//96 pass 1.2ns
//64 pass 0.8ns
//48 pass 0.6ns
//32 pass 0.4ns
//0 pass  0ns

//0C
//96 pass
//0 pass

//50C
//96 bad
//80 pass
//64 pass
//32 pass
//16 pass
//0 bad

//143M
//80 pass
//64 pass
//48 bad

//100M
//80 pass
//48 pass
//16 pass

defparam sdram_clk_dly.C_STATIC_DLY=0;
defparam sdram_clk_dly.DYN_DLY_EN="TRUE";
defparam sdram_clk_dly.ADAPT_EN="TRUE";



SDRAM_CTRL SDRAM(
    .clk(clk_133M),
    .aux_clk(aux_clk),
    .rst_n(rst_n),

    .cmd_en(cmd_en),
    .cmd_wr_rd(cmd_wr_rd),
    .cmd_av(cmd_av),
    .cmd_len(cmd_len),
    .cmd_adr(cmd_adr),

    .wr_remain_space(wr_remain_space),
    .wr_en(wr_en),
    .wr_data(wr_data),
    .wr_mask(wr_mask),

    .rd_remain_space(rd_remain_space),
    .rd_av(rd_av),
    .rd_en(rd_en),
    .rd_data(rd_data),

    .cs(sdram_cs),
    .ras(sdram_ras),
    .cas(sdram_cas),
    .we(sdram_we),
    .adr(sdram_adr),
    .ba(sdram_ba),
    .dqm(sdram_dqm),
    .dq(sdram_dq),

    .init_fin(sdram_init_fin)
);


endmodule
