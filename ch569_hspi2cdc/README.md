# CH569_HSPI_USB

- Project source can be found in [HERE](https://github.com/sipeed/TangMega-138K-example/tree/main/ch569_hspi2cdc/CH569_HSPI_USB)
- WCHISPStudio is used to flash `CH569_HSPI_USB/obj/CH569_HSPI_USB.hex` to your CH569 onboard.


NOTE: must change these settings below

- Chip Memory Allocation: RAMX 96KB + ROM 32KB
- Download Cfg Pin: PA13

You can also use MounRiver Studio import this project and build by yourself.

# CH569_HSPI_FPGA

Gowin Programmer is used to program `CH569_HSPI_FPGA/impl/pnr/CH569_HSPI_FPGA.fs` to your 60k.

The botton `S1` on core board plays a role on reset.

NOTE: must boot FPGA first to avoid affect `HSPI` on CH569.

Please confirm that you have the following conditions:
- GOWIN IDE Version ≥ 1.9.10
- **DO NOT** use GOWIN Programmer version **1.9.10.02**, for this version contains many issues
- You can get a windows GOWIN Programmer version **1.9.10.03** Alpha for [HERE](https://api.dl.sipeed.com/shareURL/TANG/programmer)