[![License: CC BY-SA 4.0](https://img.shields.io/badge/License-CC_BY--SA_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-sa/4.0/)

# Cam2DVI - a DVP Camera DVI(HDMI) demo for Sipeed Tang MEGA 60K FPGA Boards

This project is a demo to test the DVP Camera, DDR3 memory & HDMI on GOWIN GW5AT-60K, it base on Sipeed [Tang MEGA 60K](https://wiki.sipeed.com/hardware/en/tang/tang-mega-60k/mega-60k.html), it uses the DDR3 memory as framebuffer on the board for video capture & output testing.

Main features,

- 720P@60/30Hz TMDS video output via HDMI connector.
- 720P@60/30Hz RGB565 video capture via DVP Camera OV5640.
- Use on board DDR3 memory as framebuffer .

This demo now is only test on Sipeed [Tang MEGA 60K](https://wiki.sipeed.com/hardware/en/tang/tang-mega-60k/mega-60k.html), which mainchip is **GW5AT-LV60PGG464AC1/10** or **GW5AT-LV60PG484AES**.   

## Directory structure

```
| -- docs                         --> manuals and documentation
|    |`-- images				  --> picture resources  
| -- cam2dvi 
|    |	`-- cam2dvi.fs.zst		  --> prbuild bitstream(zipped)                       
|    |	`-- cam2dvi.gprj		  --> demo project
|    |	`-- cam2dvi.gprj.user	  --> project conf.
|    |-- src                      --> project sources 
|    |-- impl                     --> project config & implementation 

```

## Getting start

Please confirm that you have the following conditions:
- GOWIN IDE Version ≥ 1.9.10.01
- **DO NOT** use GOWIN Programmer version **1.9.10.02**, for this version contains many issues
- Sipeed [Tang MEGA 60K](https://wiki.sipeed.com/hardware/en/tang/tang-mega-60k/mega-60k.html)
- An OV5640 Sensor, a HDMI/DVI Monitor and a HDMI cable
- USB-C date cable, use to connect the board to PC.  

## Attention

The VCCX should be set to 1.8V due to hardware design of **Sipeed [Tang MEGA 60K](https://wiki.sipeed.com/hardware/en/tang/tang-mega-60k/mega-60k.html)**
In GOWIN IDE, this configuration item is located in the **project(menu)-Configuration-Place & Route-Voltage-VCCX**

<img src="../.assets/images/set_vccx.png" width=400>

## How to use

Here are quick instructions for the more experienced,
- Assemble your sensor and board, then connect it to your monitor via a HDMI cable.
- Download & Complie the project, then downloading the bitstream to you board.
- You can also try using the prebuilt bitstream, but remember to unzip it before downloading.
- Observe whether the monitor is show the screen captured by the sensor correctly.
- If your monitor says there is no signal input, you may need to manually pull up the HPD signal on the HDMI connector. On this board, K13 is responsible for controlling the HPD signal.

## LEDs & button

This demo uses 4 LEDs to indicate status
You need a PMOD_LED module to get the indicator LEDs, just plug the module into the outer connector.   
Here are the details for LEDs:(LED0 is on the far right)
| LEDs      | Description                     | Expected situation|
| ----------| --------------------------------|-------------------|
| LED0      |  DDR3 initialization            | ON                |
| LED1      |  DDR3_pll_lock                  | ON                |
| LED2      |  TMDS_DDR_pll_lock              | ON                |
| LED3      |  cmos_vs_cnt                    | Blink             |
| LED4      |  cmos_i2c_done                  | ON                |

1 button **(KEY.0)** use to reset the transmission.  

## Development
If you want to modify the video resolution output, Please refer to the comments in the top file.
Changing the resolution requires changing the output of TMDS_PLL. For specific frequency values, please refer to the relevant VESA documents.