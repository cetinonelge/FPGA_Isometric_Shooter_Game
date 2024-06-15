//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

/********************************************************************************************
 *                                                                                          *
 *      ██╗  ██╗ █████╗ ██╗     ██╗███████╗███╗   ██╗████████╗███████╗                      *
 *      ██║ ██╔╝██╔══██╗██║     ██║██╔════╝████╗  ██║╚══██╔══╝██╔════╝                      *
 *      █████╔╝ ███████║██║     ██║███████╗██╔██╗ ██║   ██║   █████╗                        *
 *      ██╔═██╗ ██╔══██║██║     ██║╚════██║██║╚██╗██║   ██║   ██╔══╝                        *
 *      ██║  ██╗██║  ██║███████╗██║███████║██║ ╚████║   ██║   ███████╗                      *
 *      ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝                      *
 *                                                                                          *
 *                                                                                          *
 *   JUNE 2024                                                                              *
 *                                                                                          *
 *                                                                                          *
 *   Authors:                                                                               *
 *      Çetincan Önelge                                                                     *
 *      Elif Ceren Yılmaz                                                                   *
 *                                                                                          *
 *                                                                                          *
 *******************************************************************************************/



module FPGA_Isometric_Shooter_Game(

	//////////// CLOCK //////////
	input 		          		CLOCK2_50,     // 50 MHz clock input 2
	input 		          		CLOCK3_50,     // 50 MHz clock input 3
	input 		          		CLOCK4_50,     // 50 MHz clock input 4
	input 		          		CLOCK_50,      // 50 MHz clock input

	//////////// SDRAM //////////
	output		    [12:0]		DRAM_ADDR,     // SDRAM address bus
	output		     [1:0]		DRAM_BA,       // SDRAM bank address
	output		          		DRAM_CAS_N,    // SDRAM column address strobe
	output		          		DRAM_CKE,      // SDRAM clock enable
	output		          		DRAM_CLK,      // SDRAM clock
	output		          		DRAM_CS_N,     // SDRAM chip select
	inout 		    [15:0]		DRAM_DQ,       // SDRAM data bus
	output		          		DRAM_LDQM,     // SDRAM lower byte data mask
	output		          		DRAM_RAS_N,    // SDRAM row address strobe
	output		          		DRAM_UDQM,     // SDRAM upper byte data mask
	output		          		DRAM_WE_N,     // SDRAM write enable

	//////////// SEG7 //////////
	output		     [6:0]		HEX0,          // 7-segment display 0
	output		     [6:0]		HEX1,          // 7-segment display 1
	output		     [6:0]		HEX2,          // 7-segment display 2
	output		     [6:0]		HEX3,          // 7-segment display 3
	output		     [6:0]		HEX4,          // 7-segment display 4
	output		     [6:0]		HEX5,          // 7-segment display 5

	//////////// KEY //////////
	input 		     [3:0]		KEY,           // Push buttons

	//////////// LED //////////
	output		     [9:0]		LEDR,          // LEDs

	//////////// SW //////////
	input 		     [9:0]		SW,            // Switches

	//////////// VGA //////////
	output		          		VGA_BLANK_N,   // VGA blank
	output		     [7:0]		VGA_B,         // VGA blue color data
	output		          		VGA_CLK,       // VGA clock
	output		     [7:0]		VGA_G,         // VGA green color data
	output		          		VGA_HS,        // VGA horizontal sync
	output		     [7:0]		VGA_R,         // VGA red color data
	output		          		VGA_SYNC_N,    // VGA sync
	output		          		VGA_VS         // VGA vertical sync
);


//=======================================================
//  REG/WIRE declarations
//=======================================================

wire [10:0] counth;             // Horizontal pixel count
wire [10:0] countv;             // Vertical pixel count
wire [7:0] spcsr;               // Spaceship red color data
wire [7:0] spcsg;               // Spaceship green color data
wire [7:0] spcsb;               // Spaceship blue color data
wire [7:0] backgroundr;         // Background red color data
wire [7:0] backgroundg;         // Background green color data
wire [7:0] backgroundb;         // Background blue color data
wire [3:0] angle_wire;          // Spaceship angle wire
wire [3:0] spawn_index;         // Enemy spawn index
wire game_over;                 // Game over flag
wire [12:0] score;              // Game score

//=======================================================
//  Module instantiations
//=======================================================

// Enemy mechanics module
gameplay_enemy_mechanics u2(
	.clk(CLOCK_50),              // Clock input
	.countv(countv),             // Vertical pixel count
	.counth(counth),             // Horizontal pixel count
	.backgroundr(backgroundr),   // Background red color data
	.backgroundg(backgroundg),   // Background green color data
	.backgroundb(backgroundb),   // Background blue color data
	.reset_game3(KEY[3]),        // Game reset key 3
	.reset_game2(KEY[2]),        // Game reset key 2
	.reset_game1(KEY[1]),        // Game reset key 1
	.reset_game0(KEY[0]),        // Game reset key 0
	.spaceship_aim(angle_wire),  // Spaceship aiming angle
	.active_shooting(KEY[3]),    // Active shooting key
	.spawn_index(spawn_index),   // Enemy spawn index
	.switch_mode(SW[0]),         // Switch mode
	.game_over(game_over),       // Game over flag
	.scoreout(score),            // Game score output
	.key2(KEY[2])                // Key 2 input
	);
	
// Spaceship generator module
spaceship_generator u1(
	.clk(CLOCK_50),              // Clock input
	.countv(countv),             // Vertical pixel count
	.counth(counth),             // Horizontal pixel count
	.shootingmode0(KEY[3]),      // Shooting mode key 0
	.shootingmode1(KEY[3]),      // Shooting mode key 1
	.switchmode(SW[0]),          // Switch mode
	.spcsr(spcsr),               // Spaceship red color data
	.spcsg(spcsg),               // Spaceship green color data
	.spcsb(spcsb),               // Spaceship blue color data
	.angle(angle_wire),          // Spaceship angle wire
	.game_over(game_over),       // Game over flag
	.key2(KEY[2])                // Key 2 input
	);
	
// Spaceship movement module
spaceship_movement u5(
	.up(KEY[1]),                 // Move up key
	.down(KEY[0]),               // Move down key
	.out(angle_wire)             // Spaceship angle output
	);

// VGA main control module
vga_main u3(
	.clk(CLOCK_50),              // Clock input
	.vga_clk(VGA_CLK),           // VGA clock
	.vga_vs(VGA_VS),             // VGA vertical sync
	.vga_hs(VGA_HS),             // VGA horizontal sync
	.vga_blank_n(VGA_BLANK_N),   // VGA blank
	.countv(countv),             // Vertical pixel count
	.counth(counth)              // Horizontal pixel count
	);
	
// VGA pixel generator module
vga_pixel_generator u4(
	.clk(CLOCK_50),              // Clock input
	.countv(countv),             // Vertical pixel count
	.counth(counth),             // Horizontal pixel count
	.spcsr(spcsr),               // Spaceship red color data
	.spcsg(spcsg),               // Spaceship green color data
	.spcsb(spcsb),               // Spaceship blue color data
	.backgroundr(backgroundr),   // Background red color data
	.backgroundg(backgroundg),   // Background green color data
	.backgroundb(backgroundb),   // Background blue color data
	.vga_r(VGA_R),               // VGA red color data
	.vga_g(VGA_G),               // VGA green color data
	.vga_b(VGA_B)                // VGA blue color data
	);

// LED game over indicator module
led_game_over u8(
	.clk(CLOCK_50),              // Clock input
	.game_over(game_over),       // Game over flag
	.leds(LEDR[9:0])             // LED output
	);
	
// Linear feedback shift register for random enemy spawn index
lfsr_random_enemy_index u6(
	.clk(CLOCK_50),              // Clock input
	.spawn_index(spawn_index)    // Random enemy spawn index output
	);
	
// Seven-segment display controller module
SSDCM u7(
	 .clk(CLOCK_50),             // Clock input
    .number(score),              // Score input
    .display0(HEX0),             // 7-segment display 0 output
    .display1(HEX1),             // 7-segment display 1 output
    .display2(HEX2),             // 7-segment display 2 output
    .display3(HEX3)              // 7-segment display 3 output
	);


//=======================================================
//  Structural coding
//=======================================================



endmodule