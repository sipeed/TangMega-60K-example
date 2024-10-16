[![License: CC BY-SA 4.0](https://img.shields.io/badge/License-CC_BY--SA_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-sa/4.0/)

# sdram_neo_demo - a new sdram test demo for Sipeed Tang MEGA 60K FPGA Boards

This project is a basic function test on GOWIN GW5AT-60K, it base on Sipeed [Tang MEGA 60K](https://wiki.sipeed.com/hardware/en/tang/tang-mega-60k/mega-60k.html), it uses a [TANG_SDRAM_V1.3](https://wiki.sipeed.com/hardware/en/tang/tang-PMOD/FPGA_PMOD.html#TANG_SDRAM) and a [PMOD-LEDx8](https://wiki.sipeed.com/hardware/en/tang/tang-PMOD/FPGA_PMOD.html#PMOD_LEDx8) to run a sdram write & read test.

Main features

- Provied a specialized SDRAM controller, total available SDRAM size is 64MB or 512Mb
- Up to 133MHz SDRAM & Operating clock in default
- SDRAM write & read test, show the result via a Indicator LED or UART(baudrate is 115200)
- Maybe also simple a UART controller

This demo is forked form [LicheeTang25k_SDRAM](https://github.com/ZiyangYE/LicheeTang25k_SDRAM) by @ZiyangYE, and here is the orignal [README](https://github.com/ZiyangYE/LicheeTang25k_SDRAM/blob/133M/README.md).
And it now is tested on Sipeed [Tang MEGA 60k](https://wiki.sipeed.com/hardware/en/tang/tang-mega-60k/mega-60k.html), which mainchip is **GW5AT-LV60PGG464AC1/10** or **GW5AT-LV60PG484AES**. 

## Directory structure

```
|
| -- docs                         --> manuals and documentation 
|     `-- images                  --> picture resources  
|                         
|-- src                           --> project sources
|-- impl                          --> project config & implementation  
|
|`-- sdram_neo.fs.7z              --> prbuild bitstream(zipped)
|`-- sdram_neo.gprj.user          --> project conf.
|`-- sdram_neo.gprj               --> demo project
|

```
## Getting start
Please confirm that you have the following conditions:
- GOWIN IDE Version ≥ 1.9.10
- **DO NOT** use GOWIN Programmer version **1.9.10.02**, for this version contains many issues
- You can get a windows GOWIN Programmer version **1.9.10.03** Alpha for [HERE](https://api.dl.sipeed.com/shareURL/TANG/programmer)

## How to use
- Assemble a [PMOD-LEDx8](https://wiki.sipeed.com/hardware/en/tang/tang-PMOD/FPGA_PMOD.html#PMOD_LEDx8) module installed on the **LEFT SIDE** PMOD connector on the dock board, then install a [TANG_SDRAM_V1.3](https://wiki.sipeed.com/hardware/en/tang/tang-PMOD/FPGA_PMOD.html#TANG_SDRAM) module on the **BOTTOM SIDE** 2x20P connector on the dock board.

image TBD
<img src="docs/images/NEO_PMOD_LED.webp" width=400> 

- Download & Complie the project, then downloading the bitstream to you board.
- You can also try using the prebuilt bitstream, but remember to unzip it before downloading.
- Press KEY.2 to trigger SDRAM W/R test, then check if the indicator LED is on.
- You can also check the UART output the get the test result.

### UART Output(ehen test is passed)
```text
Write aaaa ffff 0000 to ram0. 
Write 5555 0000 ffff to ram1.
Read from ram0:
aaaaffff0000
Read from ram1:
55550000ffff
[OK][OK][OK][OK]
```

## LEDs & button
This demo uses a LED to indicate status, by default it is T18.
You need a PMOD_LED module to get the indicator LEDs, just plug the module into the **LEFT** connector near the board edge.  
1 button **(KEY.2)** use to trigger the SDRAM TEST.  

## Development
Please refer to the orignal [README](https://github.com/ZiyangYE/LicheeTang25k_SDRAM/blob/133M/README.md) first.
You can enable the rao file in the project to use the GAO for debug.