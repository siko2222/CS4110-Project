# CS4110-Project
Project assignment in the CS4110 course at USN Fall 2023

## Assignment spec

Design predefined behaviours for a car platform comprising 4 dc motors (one motor for each wheel) with the following fuctionality as a minimum:

* The car starts by moving in front until an obstacle is detected at $\leq$ X cm
* When that happens the car should move back Y cm, make a 90º left turn, and continue moving in front

The functionality shall be implemented in four different ways:

* A HW-only (FSMD) solution using Vivado, running in the Basys-3 or Zybo boards
* An ASIP solution using Vivado (based on a given minimal RISC-V type architecture), running in the Basys-3 or Zybo boards
* A codesign solution created using HLS, running in the Zybo board
* A SW-only solution, running in the Zybo board