# FPGA Traffic Light Controller (Verilog | Basys 3 Artix-7)

## Overview

This project implements a real-time traffic light controller on FPGA using Verilog HDL.
The system controls a 4-way intersection through a synchronous finite state machine (FSM) driven entirely by hardware timers (no software delays).

The design is implemented and tested on a Xilinx Artix-7 FPGA and verified using simulation waveforms.

**Objectives**

* Practice synchronous digital design
* Implement timing using clock division
* Design a Moore FSM controller
* Perform functional verification using testbench

---

## Repository Structure

```
Traffic_Light/
 ├── Diagram_Picture/   # Block diagram and FSM diagram
 ├── RTL/               # Synthesizable Verilog modules
 ├── testbench/         # Simulation testbench
 ├── wave/              # Simulation waveform results
 └── README.md
```

---

## Hardware Platform

* FPGA: Xilinx Artix-7 (Basys 3)
* Clock: 50 MHz onboard oscillator
* Outputs: LEDs simulate traffic lamps
* Toolchain: Vivado + ModelSim

---

## Design Architecture

The system is divided into 5 main blocks:

1. **Clock Divider**

   * Converts 50 MHz system clock → 1 Hz tick

2. **Light Counter**

   * Counts duration of each traffic state

3. **Light Controller**

   * Controls traffic signal transitions

4. **7-segment Led BCD**

   * Drives traffic LEDs
   
5. **Artithmetic Unit**

   *Separate the tens and units digits.

## Block diagram
block diagram availabe in: 
```
/Diagram_Picture
```
High level block diagram is presented in this below: 
<p align="center">
  <img src="Traffic_Light/Diagram_Picture/High_Level_Block.png" width="400">
</p>
---
<p align="center">
  <img src="Traffic_Light/Diagram_Picture/High_Level_Block_Discription.png" width="600">
</p>

Low level block diagram of Traffic Light: 

<p align="center">
  <img src="Traffic_Light/Diagram_Picture/low_level_block.png" width="600">
</p>  

The details of each block are illustrated below:

<p align="center">
  <img src="Traffic_Light/Diagram_Picture/low_level_block_discription.png" width="600">
</p>

We also draw expected waveform which is represented below : 

<p align="center">
  <img src="Traffic_Light/wave/Expected_Waveform.png" width="800">
</p>

### Second Counter ( Clock Divider ) 

The second Counter converts 50MHz of system clock in FPGA to 1Hz tick : 

$$
f_{clk} = 50 (MHz) \Longrightarrow T = 20 (ns) 
$$

Thus, we have that : 

$$
1 (second ) = \frac{1}{20 (ns)} = 50,000,000\cdot T_{clock} 
$$

A modulo-50,000,000 counter is implemented to generate a 1 Hz tick. Because the simulation for mod-50,000,000 takes a lot of time, we will use mod-100 counter to check our design. The block diagram of this counter is illustated below: 

<p align="center">
  <img src="Traffic_Light/Diagram_Picture/second_counter.png" width="400">
</p>

The architecture of the second counter is shown below:

<p align="center">
  <img src="Traffic_Light/Diagram_Picture/second_counter_details.png" width="600">
</p>

### Light Counter 

<p align="center">
  <img src="Traffic_Light/Diagram_Picture/light_counter.png" width="400">
</p>
During each state transition, load_cnt_val is reloaded to match the duration of the next traffic light state. The architecture of this block is presented below: 
<p align="center">
  <img src="Traffic_Light/Diagram_Picture/arch_light_counter.png" width="600">
</p>

### Arithematic Unit

To drive the 7-segment display, the value is split into tens and units digits. Although division operators exist in Verilog, the modulo operation is not efficiently synthesizable in hardware. Here we will try to build a hardware that can seperate these parts, one noticeable points is that this hardawre is used for a counter couting from 0 to 19. We also give another solution to seperate unit and ten digit instead of using this block which is represented in second version. 
<p align="center">
  <img src="Traffic_Light/Diagram_Picture/arch_arithmetic_unit.png" width="400">
</p>

## FSM Description

The controller follows a Moore FSM architecture.


State transitions occur only when the hardware timer expires.

FSM diagram:

```
/Diagram_Picture
```

---

## Timing Configuration

Timing is parameterized inside the design:

```verilog
parameter GREEN_TIME  = 10;
parameter YELLOW_TIME = 3;
```

The durations are generated using a 1-second tick derived from the 100 MHz FPGA clock.

---

## Simulation & Verification

Simulation performed using ModelSim.

Testbench verifies:

* Correct state transitions
* Correct timing duration
* Proper reset behavior
* No glitching outputs

Testbench location:

```
/testbench
```

Waveform results:

```
/wave
```

---

## How to Run

1. Open Vivado
2. Create project
3. Add files from `/RTL`
4. Add constraint file
5. Run synthesis → implementation → bitstream
6. Program FPGA

Simulation:

* Run testbench in ModelSim using files in `/testbench`

---

## Learning Outcomes

Through this project I learned:

* Designing synchronous FSM in Verilog
* Implementing precise timing using hardware counters
* Avoiding combinational timing hazards
* Writing verification testbench
* Understanding difference between software delay and hardware timing

---

## Future Improvements

* Pedestrian button
* Adaptive traffic based on sensors
* UART configurable timing
* AXI interface (for SoC FPGA)

---
## Demo Video
<p align="center">
  <a href="https://youtu.be/5_QmPrGeohA?si=5fdSRW5tt40ME-Mn">
        <img src="https://img.youtube.com/vi/ABC123XYZ/maxresdefault.jpg" width="600">
  </a>
</p>


## Author

**Thang Tran**
FPGA / Digital Design Enthusiast
