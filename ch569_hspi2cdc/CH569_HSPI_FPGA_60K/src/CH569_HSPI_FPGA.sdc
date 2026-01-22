//Copyright (C)2014-2026 GOWIN Semiconductor Corporation.
//All rights reserved.
//File Title: Timing Constraints file
//Tool Version: V1.9.12.01 (64-bit) 
//Created Time: 2026-01-22 17:24:38
create_clock -name clk_in -period 20 -waveform {0 10} [get_ports {pad_i_clk_50MHz}]
create_clock -name hspi_clk -period 8.333 -waveform {0 4.167} [get_nets {clk_sys}]
create_clock -name slow_clk -period 66.667 -waveform {0 33.334} [get_nets {u_HSPI_trig/clk_15MHz}]
set_clock_groups -asynchronous -group [get_clocks {clk_in}] -group [get_clocks {hspi_clk}] -group [get_clocks {slow_clk}]
