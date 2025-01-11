//Copyright (C)2014-2024 GOWIN Semiconductor Corporation.
//All rights reserved.
//File Title: Timing Constraints file
//Tool Version: V1.9.10.01 (64-bit) 
//Created Time: 2024-10-16 02:20:10
create_clock -name clk50m -period 20 -waveform {0 10} [get_ports {sys_clk}]
create_generated_clock -name clk133m -source [get_ports {sys_clk}] -master_clock clk50m -divide_by 3 -multiply_by 8 -duty_cycle 50 [get_nets {sdram_inst/sdram_clk_p sdram_inst/aux_clk sdram_inst/clk_133M}]
set_false_path -from [get_pins {sdram_inst/tx_cnt_*_s*/Q sdram_inst/print*_s*/Q sdram_inst/SDRAM/fsm_state_*_s*/Q 	sdram_inst/test_status_*_s*/Q sdram_inst/SDRAM/init_fin_r_s*/Q 	sdram_inst/tx/tx_p_s*/CE}]  -setup
set_false_path -to [get_pins {sdram_inst/tx/tx_p_s*/CE sdram_inst/result_s*/D}]  -setup
