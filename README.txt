FPGA Isometric Shooter Game

Middle East Technical University
Electrical & Electronics Engineering

This project is done for the laboratory EE314 Term Project Spring 2024.
Project Overview
This project implements an Isometric Shooter Game on an FPGA platform. It utilizes various modules to handle game mechanics, user input, display output, and other functionalities.

Modules Explanation
1. FPGA_Isometric_Shooter_Game
This module instantiates and connects all other modules within the game. It handles clock inputs, SDRAM communication, 7-segment display outputs, user input from keys and switches, VGA display signals, and game-specific signals such as game over and score.

2. gameplay_enemy_mechanics
// Make sure gameplay_enemy_mechanics.v file HDL version: SystemVerilog_2005. Example image provided in the files.
Purpose: Controls enemy mechanics such as spawning and movement, also controls the whole gameplay features.
Inputs: Clock, pixel counts, background color, reset keys, spaceship angle, shooting activation, switch mode, game over flag, score, and key 2 input.

3. spaceship_generator
Purpose: Generates the player's spaceship with specified colors and manages its interaction.
Inputs: Clock, pixel counts, shooting mode keys, switch mode, game over flag, key 2 input.

4. spaceship_movement
Purpose: Manages spaceship movement based on user input.
Inputs: Move up/down keys.

5. vga_main
// This vga module is taken from Fred Aulich.
// If you have problems with VGA you should read the document "tutorial_DE1-SoC-v5.4_VGA_TUT" provided in the files. Page 38.
Purpose: Controls VGA main signals for display output.
Inputs: Clock, VGA clock, sync signals, pixel counts.

6. vga_pixel_generator
Purpose: Generates VGA pixel data based on spaceship and background colors.
Inputs: Clock, pixel counts, spaceship and background color data.

7. led_game_over
Purpose: Controls LEDs to indicate game over status.
Inputs: Clock, game over flag.

8. lfsr_random_enemy_index
Purpose: Generates a random index for enemy spawn using a Linear Feedback Shift Register (LFSR).
Inputs: Clock.

9. SSDCM (Seven-Segment Display Controller Module)
Purpose: Controls output to seven-segment displays to show game score.
Inputs: Clock, score.

Authors
Çetincan Önelge
Elif Ceren Yılmaz
