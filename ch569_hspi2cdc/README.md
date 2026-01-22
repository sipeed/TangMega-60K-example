[![License: CC BY-SA 4.0](https://img.shields.io/badge/License-CC_BY--SA_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-sa/4.0/)

# CH569_HSPI_USB

> All **Sipeed [Tang MEGA 60K](https://wiki.sipeed.com/hardware/en/tang/tang-mega-138k/mega-138k.html)** boards have been pre-burned with this firmware before leaving the factory.
> 
> ⚠ Unless you need secondary development or verification of the burning process, please do not try to burn this firmware at will.

- Project source can be found in [HERE](https://github.com/sipeed/TangMega-138K-example/tree/main/ch569_hspi2cdc/CH569_HSPI_USB)
- WCHISPStudio is used to flash `CH569_HSPI_USB/obj/CH569_HSPI_USB.hex` to your CH569 onboard.


NOTE: **MUST** change these settings below

- Chip Memory Allocation: `RAMX 96KB` + `ROM 32KB`
- Download CFG Pin: `PA13`

You can also use MounRiver Studio import this project and build by yourself.

# CH569_HSPI_FPGA

Gowin Programmer is used to program `CH569_HSPI_FPGA_60K/impl/pnr/CH569_HSPI_FPGA.fs` to your 60k.

Here is a pre-built bitstream in the root directory of the FPGA project, which is compressed and stored in 7z format called **`CH569_HSPI_FPGA.fs.7z`**. Just decompress it then burn it to your FPGA by **Gowin Programmer**.

The botton `KEY.0` (AA13) on SOM board is used to reset. The **`AA13`** is in the same bank of DDR3 on the SOM, so it should be contrainsted to **`IO_TYPE=LVCMOS15`** **`PULL_MODE=UP`** **`BANK_VCCIO=1.5`** 

NOTE: must boot FPGA first to avoid affect `HSPI` on CH569. To achieve this, press and hold the CH569 reset button during power-up your FPGA dock board.

Please confirm that you have the following conditions:
- GOWIN IDE Version ≥ 1.9.11.03
