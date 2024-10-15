module top_module(
    /* Sys */
	input 		    sys_clk,
    input           sys_rst_n,


    /* SDRAM */
    output          sdram_clk,
    output          sdram_cs,
    output          sdram_ras,
    output          sdram_cas,
    output          sdram_we,
    output [12:0]   sdram_adr,
    output [1:0]    sdram_ba,
    output [1:0]    sdram_dqm,
    inout  [15:0]   sdram_dq,

    /* UART */
    output          txp,
    input           rxp,

    /* PMOD0 LED */
    output          LED

);

    // Status signal
    wire SDRAM_init_done;

    // SDRAM RW Test
    sdram_top sdram_inst(
        .clk_50M(sys_clk),
        .rst_n(sys_rst_n),

        .sdram_clk(sdram_clk),
        .sdram_cs(sdram_cs),
        .sdram_ras(sdram_ras),
        .sdram_cas(sdram_cas),
        .sdram_we(sdram_we),
        .sdram_adr(sdram_adr),
        .sdram_ba(sdram_ba),
        .sdram_dqm(sdram_dqm),
        .sdram_dq(sdram_dq),
        .txp(txp),   //UART TX
        .rxp(rxp),   //UART RX
        .SDRAM_init_done(SDRAM_init_done)
    );

    assign LED = SDRAM_init_done;

endmodule