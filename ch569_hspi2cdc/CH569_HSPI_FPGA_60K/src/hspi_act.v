module  HSPI_trig(
   input  wire   hspi_clk   , 
   input  wire   rst_n      ,
   output reg    hspi_done  ,
   output reg    hspi_ready ,
   output wire   hspi_tx_trig,
   output wire   hspi_tx_act

);

    wire clk_15MHz;
    wire gw_gnd =1'b0;
    CLKDIV clkdiv_inst (
        .HCLKIN(hspi_clk ), //input  hspi_clk 120MHz 
        .RESETN(rst_n    ), //input  rst_n, active low
        .CALIB (gw_gnd   ),
        .CLKOUT(clk_15MHz)
    );
    defparam clkdiv_inst.DIV_MODE="8";

    reg [24:0] counter; // 2G
    always @(posedge clk_15MHz or negedge rst_n) begin
        if(~rst_n) begin
            counter <= 'b0;
        end else begin
            counter <= counter + 1'b1;
        end
    end

    //combinational logic
    //assign hspi_done  = counter[20]; // ~= 7
    //assign hspi_ready = counter[21]; // ~= 3

    always @(posedge hspi_clk or negedge rst_n) begin
        if(~rst_n) begin
            hspi_done  <= 1'b0;
            hspi_ready <= 1'b0;
        end else begin
            hspi_done  <= counter[20]; // ~= 7
            hspi_ready <= counter[21]; // ~= 3
        end
    end
    

    reg reg_counter_xx;
    reg reg_counter_xx_dly;
    always @(posedge hspi_clk or negedge rst_n) begin
        if(~rst_n) begin
            reg_counter_xx <= 'b0;
            reg_counter_xx_dly <= 'b0;
        end else begin
            reg_counter_xx <= counter[21];
            reg_counter_xx_dly <= reg_counter_xx;
        end
    end

    assign hspi_tx_act = reg_counter_xx & ~reg_counter_xx_dly;


    reg reg_tx_trig;
    always @(posedge counter[2] or negedge rst_n) begin
        if(~rst_n) begin
            reg_tx_trig <= 'b0;
        end else if(reg_counter_xx & ~reg_counter_xx_dly) begin
            reg_tx_trig<= 'b1;
        end else begin
            reg_tx_trig <= 'b0;
        end
    end

    assign  hspi_tx_trig = reg_tx_trig;

endmodule