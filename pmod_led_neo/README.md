# pmod_led_demo - a basic led test demo for Sipeed Tang MEGA 60K FPGA Boards

This project is a basic function test on GOWIN GW5AT-60K, it base on Sipeed [Tang MEGA 60K](https://wiki.sipeed.com/hardware/en/tang/tang-mega-60k/mega-60k.html), and uses the **left side** PMOD interfaces on the edge of board for transcIO LED on/off testing.

Main features,

- Working with PMOD-LEDx8 module
- Sequentially illuminated 8 LEDs
- 3 different clock source inputs can be selected: Internal_OSC, Onboard_OSC or MS5351
- 3 different keys to switch LEDs blink status

image TBD
<img src="docs/images/NEO_PMOD_LED.webp" width=400> 

This demo is forked from the pcie demo of Sipeed [Tang MEGA 138K](https://wiki.sipeed.com/hardware/en/tang/tang-mega-138k/mega-138k.html), which mainchip is **GW5AST-LV138PGG464AC1/10** or **GW5AST-LV138PG484AES**.  
And it now is tested on Sipeed [Tang MEGA 60k](https://wiki.sipeed.com/hardware/en/tang/tang-mega-60k/mega-60k.html), which mainchip is **GW5AT-LV60PGG464AC1/10** or **GW5AT-LV60PG484AES**. 

## Directory structure

```
|
| -- docs                         --> manuals and documentation
|    |`-- UG306E.pdf              --> official Clock resource guide（en） 
|    |`-- UG306_zh.pdf            --> official Clock resource guide(zh) 
|     `-- images                  --> picture resources                           
|-- src                           --> project sources
|-- impl                          --> project config & implementation  
|
|`-- pmod_led.fs.7z               --> prbuild bitstream(zipped)
|`-- pmod_led.gprj.user           --> project conf.
|`-- pmod_led.gprj                --> demo project
|

```
## Getting start
Please confirm that you have the following conditions:
- GOWIN IDE Version ≥ 1.9.10
- **DO NOT** use GOWIN Programmer version **1.9.10.02**, for this version contains many issues
- You can get a windows GOWIN Programmer version **1.9.10.03** Alpha for [HERE](https://api.dl.sipeed.com/shareURL/TANG/programmer)
- You should set the *CPU as regular IO* in **IDE-Project-Configuration-Place & route-Dual Purpose Pin**, otherwise you will get a **ERROR** from IDE like *The constrained location is useless in current package* when running placement.

## How to use
- Assemble a PMOD-LEDx8 module installed on the **left side** PMOD connector on the dock board.
- Download & Complie the project, then downloading the bitstream to you board.
- You can also try using the prebuilt bitstream, but remember to unzip it before downloading.
- Observe whether 8 LEDs lighting up one by one from one side to the other side, then turn off one by one.
- Press button key1 or key0 to change the blink status of LEDs.

## LEDs & button
This demo uses 8 LEDs to indicate status
You need a PMOD_LED module to get the indicator LEDs, just plug the module into the **LEFT** connector near the board edge.   
Here are the details for buttons:(key2 is on the far left)
| buttons   | Description                     | Expected situation|
| ----------| --------------------------------|-------------------|
| key2      |  pressed reset key              | ALL LEDs OFF      |
| key1      |  Pressed kye1                   | ALL LEDs BLINK    |
| key0      |  Pressed kye0                   | ALL LEDs OFF      |
| none      |  No keys were pressed           | ALL LEDs MARQUEE  |

## Development
If you want to modify the change the speed of flashing, Please refer to the comments in the top file and the cst file.
When using CKO2 of MS5351 as the system clock input, you can refer to [SET_5351](https://github.com/sipeed/TangMega-138KPro-example/blob/main/sfp%2B/docs/SET_5351.md) to change the frequency of its output clock.

