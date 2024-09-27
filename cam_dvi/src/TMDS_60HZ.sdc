
create_clock -name clk -period 20 -waveform {0 10} [get_ports {clk}] -add

// PLL1
create_generated_clock -name cam_xclk -source [get_ports {clk}] -master_clock clk -divide_by 50  -multiply_by 24 [get_pins {Gowin_PLL_m0/PLLA_inst/CLKOUT0}]
create_generated_clock -name caux_clk -source [get_ports {clk}] -master_clock clk -divide_by 127 -multiply_by 24 [get_pins {Gowin_PLL_m0/PLLA_inst/CLKOUT1}]
create_generated_clock -name mem_clk  -source [get_ports {clk}] -master_clock clk -divide_by 3   -multiply_by 24 [get_pins {Gowin_PLL_m0/PLLA_inst/CLKOUT2}]

//PLL2
create_generated_clock -name clk_tmds_5x -source [get_ports {clk}] -master_clock clk -divide_by 40  -multiply_by 297 [get_pins {u_tmds_pll/PLLA_inst/CLKOUT0}]
create_generated_clock -name clk_74_25   -source [get_ports {clk}] -master_clock clk -divide_by 200 -multiply_by 297 [get_pins {u_tmds_pll/PLLA_inst/CLKOUT1}]

//ddr pll
//create_generated_clock -name clk_x1 -source [get_nets {memory_clk}] -master_clock mem_clk -divide_by 4 -multiply_by 1 [get_pins {u_ddr3/gw3_top/u_ddr_phy_top/fclkdiv/CLKOUT}]
create_generated_clock -name clk_x1 -source [get_pins {Gowin_PLL_m0/PLLA_inst/CLKOUT2}] -master_clock mem_clk -divide_by 4 -multiply_by 1 [get_pins {u_ddr3/gw3_top/u_ddr_phy_top/fclkdiv/CLKOUT}]


//camera pclk
create_clock -name cmos_pclk -period 5.88 -waveform {0 2.94} [get_ports {cmos_pclk}]
create_generated_clock -name cmos_pclk_div2 -source [get_ports {cmos_pclk}] -master_clock cmos_pclk -divide_by 2 -multiply_by 1 [get_nets {cmos_16bit_clk}]
create_clock -name cmos_vsync -period 10000 -waveform {0 5000} [get_ports {cmos_vsync}]

set_clock_groups -asynchronous -group [get_clocks {clk_tmds_5x}] 
                               -group [get_clocks {clk_74_25}] 
                               -group [get_clocks {clk_x1}] 
                               -group [get_clocks {cam_xclk}] 
                               -group [get_clocks {caux_clk}] 
                               -group [get_clocks {mem_clk}] 
                               -group [get_clocks {cmos_pclk}] 
                               -group [get_clocks {cmos_vsync}] 
                               -group [get_clocks {clk}]
                               -group [get_clocks {cmos_pclk_div2}] 


//report_timing -hold -from_clock [get_clocks {clk*}] -to_clock [get_clocks {clk*}] -max_paths 25 -max_common_paths 1
//report_timing -setup -from_clock [get_clocks {clk*}] -to_clock [get_clocks {clk*}] -max_paths 25 -max_common_paths 1
