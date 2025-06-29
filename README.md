# FPGA Isometric Shooter Game  
*EE314 Term Project – Spring 2024*  
Middle East Technical University, Department of Electrical & Electronics Engineering

---

## Project Overview
This project implements a real-time **isometric shooter** on an **Altera DE1-SoC** development board (Cyclone V 5CSEMA5).  
Game logic, graphics, user input, and score display are handled entirely in hardware with Verilog / SystemVerilog modules.

* **Playable demo:** <https://youtu.be/P4vIjceiqJQ>
  
## Hardware & Tools

| Item | Details |
|------|---------|
| FPGA board | **Terasic DE1-SoC** (Cyclone V 5CSEMA5F31C6) |
| Display | VGA output @ 640 × 480 @ 60 Hz |
| Inputs | On-board KEY\[3:0] push-buttons & SW\[9:0] switches |
| Clocks | 50 MHz base; VGA pixel clock derived inside `vga_main` |
| Toolchain | *Intel Quartus Prime* Lite v22.1 • *ModelSim-Intel FPGA Edition* |

## Module Descriptions

| # | Module | Purpose | Key Inputs |
|---|--------|---------|------------|
| 1 | **`FPGA_Isometric_Shooter_Game`** | Top-level wrapper connecting every sub-module, clocks, SDRAM, seven-segment displays, VGA, and I/O. | `CLOCK_50`, `KEY`, `SW`, SDRAM signals |
| 2 | **`gameplay_enemy_mechanics`**<br><sub>(SystemVerilog 2005)</sub> | Spawns enemies, updates their movement, detects collisions; overall gameplay FSM. Example usage shown in included image. | clock, pixel x/y, background RGB, reset, ship angle, shoot_enable, mode switch, `game_over`, `score`, `KEY[2]` |
| 3 | **`spaceship_generator`** | Draws the player ship, handles ship-to-background occlusion & colour. | clock, pixel x/y, shoot keys, mode switch, `game_over`, `KEY[2]` |
| 4 | **`spaceship_movement`** | Reads push-buttons to update ship position. | `KEY[1]` (UP), `KEY[0]` (DOWN) |
| 5 | **`vga_main`** ★ | Generates 25 MHz VGA pixel clock, HS/VS, and active-video region – see page 38 of the tutorial. | 50 MHz clk |
| 6 | **`vga_pixel_generator`** | Combines ship, enemies, and background into final RGB for each pixel. | clock, pixel x/y, colour buses |
| 7 | **`led_game_over`** | Flashes on-board LEDs when the player loses. | clock, `game_over` |
| 8 | **`lfsr_random_enemy_index`** | 15-bit LFSR used for pseudo-random enemy spawn columns. | clock |
| 9 | **`SSDCM`** | Scans four seven-segment displays to show the current score. | clock, `score[15:0]` |

★ If VGA timing issues arise, consult **“tutorial_DE1-SoC-v5.4_VGA_TUT.pdf”** (p. 38).
