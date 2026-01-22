module top(
	input  wire                         pad_i_clk_50MHz,    // E2
    inout  wire                         pad_io_ready,       // E8
    inout  wire                         pad_io_done,        // D7
    
    inout  wire           [31:0]        pad_io_HSPI_HD,
    output wire                         pad_o_HSPI_HTCLK,
    output wire                         pad_o_HSPI_HTREQ,
    input  wire                         pad_i_HSPI_HTRDY,
    output wire                         pad_o_HSPI_HTVLD,

	input  wire                         pad_i_s1_n
);
    
    wire   clk       ;
    wire   ec_spi_cs1;
    wire   ec_spi_cs2;
    wire   reset     ;

    assign clk        = pad_i_clk_50MHz;
    assign ec_spi_cs1 = pad_io_done    ;
    assign ec_spi_cs2 = pad_io_ready   ;

    wire   rst_n, clk_sys, pll_locked;

    assign rst_n      = ~reset | pll_locked;
    assign reset      = ~pad_i_s1_n        ;

    Gowin_PLL u_Gowin_PLL(
        .clkin       (clk            ), //input   clkin 50MHz
        .mdclk       (clk            ), //input   mdclk 50MHz
        .reset       (reset          ), //input   reset, active high
        .clkout0     (clk_sys        ), //output  clk_sys 120MHz 
        .lock        (pll_locked     )  //output  pll lock
    );  

    wire hspi_tx_act;
    HSPI_trig u_HSPI_trig(
        .hspi_clk    (clk_sys       ),
        .rst_n       (rst_n         ),
        .hspi_done   (pad_io_done   ),
        .hspi_ready  (pad_io_ready  ),
        .hspi_tx_trig(              ),
        .hspi_tx_act (hspi_tx_act   )
    );

    wire [15:0] resv    ;
    wire [31:0] hrd_resv = 'bz;
    wire [8:0]  ram_addr;
    //HSPI instance
    EXM_HSPI #(
        .TX_LEN(12'd512 - 1),
        .HSPI_UDF(26'h000ffff)
    ) M_HSPI (
    	//tx signal
    	.HTCLK          (pad_o_HSPI_HTCLK),
    	.HTREQ          (pad_o_HSPI_HTREQ),
    	.HTRDY          (pad_i_HSPI_HTRDY),
    	.HTVLD          (pad_o_HSPI_HTVLD),
    	.HTD            ({resv, pad_io_HSPI_HD[15:0]}),
    	.HTOE           (),
    	.tx_act         (hspi_tx_act     ),
    	//rx signal
    	.HRCLK          ('b0),
    	.HRACT          ('b0),
    	.HTACK          (),
    	.HRVLD          ('b0),
    	.HRD            (hrd_resv),
    	//global signal
    	.rstn           (rst_n),
    	.clk            (clk_sys),
    	.dat_mod        (2'b01), //HSPI data mode, 00 - 8bits, 01 - 16bits, 1x - 32bits
    	//RAM signal
    	.ram_clk        (),
    	.ram_csn        (),
    	.ram_wen        (),
    	.ram_addr       (ram_addr),
    	.ram_rdata      ({23'h000000, ram_addr}),
    	.ram_wdata      ()
    );
endmodule