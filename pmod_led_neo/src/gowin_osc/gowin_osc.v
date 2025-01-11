//Copyright (C)2014-2024 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: IP file
//Tool Version: V1.9.10.01 (64-bit)
//Part Number: GW5AT-LV60PG484AC1/I0
//Device: GW5AT-60
//Device Version: B
//Created Time: Tue Oct 15 18:45:26 2024

module Gowin_OSC (oscout, oscen);

output oscout;
input oscen;

OSCA osc_inst (
    .OSCOUT(oscout),
    .OSCEN(oscen)
);

defparam osc_inst.FREQ_DIV = 4;

endmodule //Gowin_OSC
