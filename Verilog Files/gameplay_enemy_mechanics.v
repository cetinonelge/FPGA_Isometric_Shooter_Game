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

module gameplay_enemy_mechanics(
    input clk,
    input [10:0] countv,
    input [10:0] counth,
	 input [3:0] spaceship_aim,
	 input active_shooting,
	 input switch_mode,
	 input key2,
	 input [3:0] spawn_index,
	 input reset_game0,
	 input reset_game1,
	 input reset_game2,
	 input reset_game3,
	 output game_over,
    output reg [7:0] backgroundr,
    output reg [7:0] backgroundg,
    output reg [7:0] backgroundb,
	 output reg [12:0] scoreout
);

parameter ENEMY_SIZE = 20;
parameter ENEMY_COUNT = 16;

parameter ENEMY_TYPE_1 = 1;
parameter ENEMY_TYPE_2 = 2;
parameter ENEMY_TYPE_3 = 3;

parameter ENEMY_TYPE_1_COLOR_R = 255;
parameter ENEMY_TYPE_1_COLOR_G = 0;
parameter ENEMY_TYPE_1_COLOR_B = 0;

parameter ENEMY_TYPE_2_COLOR_R = 0;
parameter ENEMY_TYPE_2_COLOR_G = 255;
parameter ENEMY_TYPE_2_COLOR_B = 0;

parameter ENEMY_TYPE_3_COLOR_R = 0;
parameter ENEMY_TYPE_3_COLOR_G = 0;
parameter ENEMY_TYPE_3_COLOR_B = 255;

parameter enemy_position_start_v0 = 240;
parameter enemy_position_start_h0 = 640;  // 640 - 20

parameter enemy_position_start_v1 = 120;
parameter enemy_position_start_h1 = 640;  // 640 - 20

parameter enemy_position_start_v2 = 0;   // 0 + 20
parameter enemy_position_start_h2 = 640;  // 640 - 20

parameter enemy_position_start_v3 = 0;   // 0 + 20
parameter enemy_position_start_h3 = 480;  // 480 - 20

parameter enemy_position_start_v4 = 0;   // 0 + 20
parameter enemy_position_start_h4 = 320;  // 320 - 20

parameter enemy_position_start_v5 = 0;   // 0 + 20
parameter enemy_position_start_h5 = 160;  // 160 - 20

parameter enemy_position_start_v6 = 0;   // 0 + 20
parameter enemy_position_start_h6 = 0;   // 0 + 20

parameter enemy_position_start_v7 = 120;  // 120 + 20
parameter enemy_position_start_h7 = 0;   // 0 + 20

parameter enemy_position_start_v8 = 240;  // 240 + 20
parameter enemy_position_start_h8 = 0;   // 0 + 20

parameter enemy_position_start_v9 = 360;  // 360 + 20
parameter enemy_position_start_h9 = 0;   // 0 + 20

parameter enemy_position_start_v10 = 480; // 480 - 20
parameter enemy_position_start_h10 = 0;  // 0 + 20

parameter enemy_position_start_v11 = 480; // 480 - 20
parameter enemy_position_start_h11 = 160; // 160 - 20

parameter enemy_position_start_v12 = 480; // 480 - 20
parameter enemy_position_start_h12 = 320; // 320 - 20

parameter enemy_position_start_v13 = 480; // 480 - 20
parameter enemy_position_start_h13 = 480; // 480 - 20

parameter enemy_position_start_v14 = 480; // 480 - 20
parameter enemy_position_start_h14 = 640; // 640 - 20

parameter enemy_position_start_v15 = 360; // 360 + 20
parameter enemy_position_start_h15 = 640; // 640 - 20


reg [1:0] enemy_type [0:ENEMY_COUNT-1];
reg [10:0] enemy_position_v [0:ENEMY_COUNT-1];
reg [10:0] enemy_position_h [0:ENEMY_COUNT-1];

wire clock_1hz;
wire clock_2hz;
wire clock_4hz;
wire clock_8hz;
wire clock_32hz;
wire clock_128hz;

clock_divider u1(
    .clock(clk),
    .cout0(clock_1hz),
	 .cout1(clock_2hz),
	 .cout2(clock_4hz),
	 .cout3(clock_8hz),
	 .cout5(clock_32hz),
	 .cout6(clock_128hz)
);

// Manually defined initial positions for the enemies
initial begin
    // Define enemy types
    enemy_type[0] <= ENEMY_TYPE_1;
    enemy_type[1] <= ENEMY_TYPE_2;
    enemy_type[2] <= ENEMY_TYPE_3;
    enemy_type[3] <= ENEMY_TYPE_1;
    enemy_type[4] <= ENEMY_TYPE_2;
    enemy_type[5] <= ENEMY_TYPE_3;
    enemy_type[6] <= ENEMY_TYPE_1;
    enemy_type[7] <= ENEMY_TYPE_2;
    enemy_type[8] <= ENEMY_TYPE_3;
    enemy_type[9] <= ENEMY_TYPE_1;
    enemy_type[10] <= ENEMY_TYPE_2;
    enemy_type[11] <= ENEMY_TYPE_3;
    enemy_type[12] <= ENEMY_TYPE_1;
    enemy_type[13] <= ENEMY_TYPE_2;
    enemy_type[14] <= ENEMY_TYPE_3;
    enemy_type[15] <= ENEMY_TYPE_1;
    
    // Define enemy initial positions
	enemy_position_v[0] = 240;   // unchanged
	enemy_position_h[0] = 640;   // 640 - 20
	enemy_position_v[1] = 120;   // unchanged
	enemy_position_h[1] = 640;   // 640 - 20
	enemy_position_v[2] = 0;    // 0 + 20
	enemy_position_h[2] = 640;   // 640 - 20
	enemy_position_v[3] = 0;    // 0 + 20
	enemy_position_h[3] = 480;   // 480 - 20
	enemy_position_v[4] = 0;    // 0 + 20
	enemy_position_h[4] = 320;   // 320 - 20
	enemy_position_v[5] = 0;    // 0 + 20
	enemy_position_h[5] = 160;   // 160 - 20
	enemy_position_v[6] = 0;    // 0 + 20
	enemy_position_h[6] = 0;    // 0 + 20
	enemy_position_v[7] = 120;   // 120 + 20
	enemy_position_h[7] = 0;    // 0 + 20
	enemy_position_v[8] = 240;   // 240 + 20
	enemy_position_h[8] = 0;    // 0 + 20
	enemy_position_v[9] = 360;   // 360 + 20
	enemy_position_h[9] = 0;    // 0 + 20
	enemy_position_v[10] = 480;  // 480 - 20
	enemy_position_h[10] = 0;   // 0 + 20
	enemy_position_v[11] = 480;  // 480 - 20
	enemy_position_h[11] = 160;  // 160 - 20
	enemy_position_v[12] = 480;  // 480 - 20
	enemy_position_h[12] = 320;  // 320 - 20
	enemy_position_v[13] = 480;  // 480 - 20
	enemy_position_h[13] = 480;  // 480 - 20
	enemy_position_v[14] = 480;  // 480 - 20
	enemy_position_h[14] = 640;  // 640 - 20
	enemy_position_v[15] = 360;  // 360 + 20
	enemy_position_h[15] = 640;  // 640 - 20
end

reg [15:0] active_enemies = 16'b0101010101010101;
reg [3:0] bling [15:0];
reg [3:0] counter_hp [15:0];
reg [3:0] hp_types [2:0];
reg [15:0] flag_hp;
always hp_types[0] = 3'd2;
always hp_types[1] = 3'd4;
always hp_types[2] = 3'd6;

reg flag_gameover = 0;
reg raise_gameover = 0;
assign game_over = flag_gameover;

// RESET THE GAME !WAIT A BIT FOR SCORE RESET
always @(posedge clock_1hz) begin
	if(flag_gameover && !reset_game0 && !reset_game1 && !reset_game2 && !reset_game3) begin
	raise_gameover = 1; end
	if(!flag_gameover && reset_game0 && reset_game1 && reset_game2 && reset_game3) begin
	raise_gameover = 0;
	end
end

// SHOOTING MECHANICS OF THE GAME
always @(*) begin
	 integer j;
    integer i;
	 integer k;
 // First, check and reset counter_hp if it reaches the maximum value
	   if(reset_game0 && reset_game1 && reset_game2 && reset_game3) scoreout <= 0;
	  
	  for (j = 0; j < 16; j = j + 1) begin
			if (counter_hp[j] >= hp_types[j % 3]) begin
				counter_hp[j] <= 0;
				bling[j] <= 0;
				flag_hp[j] <= 1;
			end
			case (j)
            0: begin if((enemy_position_v[j] == enemy_position_start_v0) && (enemy_position_h[j] == enemy_position_start_h0)) begin flag_hp[j] <= 0; end end
            1: begin if((enemy_position_v[j] == enemy_position_start_v1) && (enemy_position_h[j] == enemy_position_start_h1)) begin flag_hp[j] <= 0; end end
            2: begin if((enemy_position_v[j] == enemy_position_start_v2) && (enemy_position_h[j] == enemy_position_start_h2)) begin flag_hp[j] <= 0; end end
            3: begin if((enemy_position_v[j] == enemy_position_start_v3) && (enemy_position_h[j] == enemy_position_start_h3)) begin flag_hp[j] <= 0; end end
            4: begin if((enemy_position_v[j] == enemy_position_start_v4) && (enemy_position_h[j] == enemy_position_start_h4)) begin flag_hp[j] <= 0; end end
            5: begin if((enemy_position_v[j] == enemy_position_start_v5) && (enemy_position_h[j] == enemy_position_start_h5)) begin flag_hp[j] <= 0; end end
            6: begin if((enemy_position_v[j] == enemy_position_start_v6) && (enemy_position_h[j] == enemy_position_start_h6)) begin flag_hp[j] <= 0; end end
            7: begin if((enemy_position_v[j] == enemy_position_start_v7) && (enemy_position_h[j] == enemy_position_start_h7)) begin flag_hp[j] <= 0; end end
            8: begin if((enemy_position_v[j] == enemy_position_start_v8) && (enemy_position_h[j] == enemy_position_start_h8)) begin flag_hp[j] <= 0; end end
            9: begin if((enemy_position_v[j] == enemy_position_start_v9) && (enemy_position_h[j] == enemy_position_start_h9)) begin flag_hp[j] <= 0; end end
            10: begin if((enemy_position_v[j] == enemy_position_start_v10) && (enemy_position_h[j] == enemy_position_start_h10)) begin flag_hp[j] <= 0; end end
            11: begin if((enemy_position_v[j] == enemy_position_start_v11) && (enemy_position_h[j] == enemy_position_start_h11)) begin flag_hp[j] <= 0; end end
            12: begin if((enemy_position_v[j] == enemy_position_start_v12) && (enemy_position_h[j] == enemy_position_start_h12)) begin flag_hp[j] <= 0; end end
            13: begin if((enemy_position_v[j] == enemy_position_start_v13) && (enemy_position_h[j] == enemy_position_start_h13)) begin flag_hp[j] <= 0; end end
            14: begin if((enemy_position_v[j] == enemy_position_start_v14) && (enemy_position_h[j] == enemy_position_start_h14)) begin flag_hp[j] <= 0; end end
            15: begin if((enemy_position_v[j] == enemy_position_start_v15) && (enemy_position_h[j] == enemy_position_start_h15)) begin flag_hp[j] <= 0; end end
        endcase
	  end
	 @(posedge active_shooting) begin
    if (switch_mode == 1'b0 && key2 == 1'b1) begin
        case (spaceship_aim)
            default: begin
			i = spaceship_aim;	
				for (k = -1; k < 2; k = k + 1) begin
					if (active_enemies[(i+16+k)%16] && !flag_hp[(i+16+k)%16]) begin
						counter_hp[(i+16+k)%16] <= counter_hp[(i+16+k)%16] + 2;
						if (flag_gameover == 0) begin scoreout <= scoreout + 2; end
						bling[(i+16+k)%16] <= bling[(i+16+k)%16] + 2;
               end
					end
					end
        endcase
end
	else if (switch_mode == 1'b1 && key2 == 1'b1) begin
        case (spaceship_aim)
            default: begin
			i = spaceship_aim;	
				for (k = -2; k < 3; k = k + 1) begin
					if (active_enemies[(i+16+k)%16] && !flag_hp[(i+16+k)%16]) begin
						counter_hp[(i+16+k)%16] <= counter_hp[(i+16+k)%16] + 1;
						if (flag_gameover == 0) begin scoreout <= scoreout + 1; end
						bling[(i+16+k)%16] <= bling[(i+16+k)%16] + 1;
               end
					end
					end
        endcase
		 end
	 else if (key2 == 1'b0) begin
			case (spaceship_aim)
            default: begin
			i = spaceship_aim;	
					if (active_enemies[i]) begin
						if (hp_types[i % 3] == 2) begin
							counter_hp[i] <= counter_hp[i] + 2;
							if (flag_gameover == 0) begin scoreout <= scoreout + 10; end
							bling[i] <= bling[i] + 2;
						end else if (hp_types[i % 3] == 4) begin
							counter_hp[i] <= counter_hp[i] + 4;
							if (flag_gameover == 0) begin scoreout <= scoreout + 10; end
							bling[i] <= bling[i] + 4;
						end else if (hp_types[i % 3] == 6) begin
							counter_hp[i] <= counter_hp[i] + 6;
							if (flag_gameover == 0) begin scoreout <= scoreout + 10; end
							bling[i] <= bling[i] + 6;
						end
               end
					end
        endcase
	 end
end
end


// COUNT THE TOTAL ENEMY ALL THE TIME
reg [3:0] total_enemy;
always @(*) begin
    integer i;
    total_enemy = 4'd0;

    // Iterate through each bit of the 16-bit input
    for (i = 0; i < 16; i = i + 1) begin
        if (active_enemies[i] == 1'b1) begin
            total_enemy = total_enemy + 1; // Increment count if the bit is 1
        end
    end
end

	// ACTIVATE AND DEACTIVATE ENEMIES
always @(posedge clock_32hz) begin
    integer i;
    for (i = 0; i < 16; i = i + 1) begin
        if (flag_hp[i] && active_enemies[i]) begin
				active_enemies[i] <= !active_enemies[i];
		  end
        if (total_enemy < 8 && !active_enemies[spawn_index] && clock_2hz && !flag_hp[i]) 
				active_enemies[spawn_index] <= !active_enemies[spawn_index];
	 end
end
	
	 // MOVEMENT & POSITION HANDLE 
always @(*) begin
    integer i;
    integer move_h;
    integer move_v;
    reg [9:0] new_position_v[15:0]; // Temporary storage for new vertical positions
    reg [9:0] new_position_h[15:0]; // Temporary storage for new horizontal positions
	 
	 if(raise_gameover) begin
		flag_gameover = 0;
	 end
	 
    // ENEMY MOVEMENT 
	 @(posedge clock_2hz) begin
    for (i = 0; i < 16; i = i + 1) begin
        new_position_v[i] = enemy_position_v[i];
        new_position_h[i] = enemy_position_h[i];
		  if(active_enemies[i] && !flag_gameover) begin
			if (scoreout < 200) begin
				case (i)
					0: begin move_h = -8; move_v = 0; end
					1: begin move_h = -8; move_v = 3; end
					2: begin move_h = -8; move_v = 6; end
					3: begin move_h = -4; move_v = 6; end
					4: begin move_h = 0; move_v = 6; end
					5: begin move_h = 4; move_v = 6; end
					6: begin move_h = 8; move_v = 6; end
					7: begin move_h = 8; move_v = 3; end
					8: begin move_h = 8; move_v = 0; end
					9: begin move_h = 8; move_v = -3; end
					10: begin move_h = 8; move_v = -6; end
					11: begin move_h = 4; move_v = -6; end
					12: begin move_h = 0; move_v = -6; end
					13: begin move_h = -4; move_v = -6; end
					14: begin move_h = -8; move_v = -6; end
					15: begin move_h = -8; move_v = -3; end
			  endcase
			 end else if ((scoreout >= 200) && (scoreout < 500)) begin
			 case (i)
					0: begin move_h = -12; move_v = 0; end
					1: begin move_h = -12; move_v = 5; end
					2: begin move_h = -12; move_v = 9; end
					3: begin move_h = -6; move_v = 9; end
					4: begin move_h = 0; move_v = 9; end
					5: begin move_h = 6; move_v = 9; end
					6: begin move_h = 12; move_v = 9; end
					7: begin move_h = 12; move_v = 5; end
					8: begin move_h = 12; move_v = 0; end
					9: begin move_h = 12; move_v = -5; end
					10: begin move_h = 12; move_v = -9; end
					11: begin move_h = 6; move_v = -9; end
					12: begin move_h = 0; move_v = -9; end
					13: begin move_h = -6; move_v = -9; end
					14: begin move_h = -12; move_v = -9; end
					15: begin move_h = -12; move_v = -5; end
			  endcase
			  end else begin
			 case (i)
					0: begin move_h = -16; move_v = 0; end
					1: begin move_h = -16; move_v = 6; end
					2: begin move_h = -16; move_v = 12; end
					3: begin move_h = -8; move_v = 12; end
					4: begin move_h = 0; move_v = 12; end
					5: begin move_h = 8; move_v = 12; end
					6: begin move_h = 16; move_v = 12; end
					7: begin move_h = 16; move_v = 6; end
					8: begin move_h = 16; move_v = 0; end
					9: begin move_h = 16; move_v = -6; end
					10: begin move_h = 16; move_v = -12; end
					11: begin move_h = 8; move_v = -12; end
					12: begin move_h = 0; move_v = -12; end
					13: begin move_h = -8; move_v = -12; end
					14: begin move_h = -16; move_v = -12; end
					15: begin move_h = -16; move_v = -6; end
			  endcase
			  end
		  new_position_v[i] = enemy_position_v[i] + move_v;
        new_position_h[i] = enemy_position_h[i] + move_h;
		  end
		  end
		  
		  // GAME OVER CONDITION
		  for (i = 0; i < 16; i = i + 1) begin
		  if (((new_position_h[i] >= 291 && new_position_h[i] <= 329) && 
        (new_position_v[i] >= 211 && new_position_v[i] <= 249)) && !raise_gameover) begin
			flag_gameover = 1;
    end
		 // ENEMY POSITION RESET CONDITION
		  if (flag_hp[i] || flag_gameover) begin
        case (i)
				0: begin new_position_v[i] = enemy_position_start_v0; new_position_h[i] = enemy_position_start_h0; end
            1: begin new_position_v[i] = enemy_position_start_v1; new_position_h[i] = enemy_position_start_h1; end
            2: begin new_position_v[i] = enemy_position_start_v2; new_position_h[i] = enemy_position_start_h2; end
            3: begin new_position_v[i] = enemy_position_start_v3; new_position_h[i] = enemy_position_start_h3; end
            4: begin new_position_v[i] = enemy_position_start_v4; new_position_h[i] = enemy_position_start_h4; end
            5: begin new_position_v[i] = enemy_position_start_v5; new_position_h[i] = enemy_position_start_h5; end
            6: begin new_position_v[i] = enemy_position_start_v6; new_position_h[i] = enemy_position_start_h6; end
            7: begin new_position_v[i] = enemy_position_start_v7; new_position_h[i] = enemy_position_start_h7; end
            8: begin new_position_v[i] = enemy_position_start_v8; new_position_h[i] = enemy_position_start_h8; end
            9: begin new_position_v[i] = enemy_position_start_v9; new_position_h[i] = enemy_position_start_h9; end
            10: begin new_position_v[i] = enemy_position_start_v10; new_position_h[i] = enemy_position_start_h10; end
            11: begin new_position_v[i] = enemy_position_start_v11; new_position_h[i] = enemy_position_start_h11; end
            12: begin new_position_v[i] = enemy_position_start_v12; new_position_h[i] = enemy_position_start_h12; end
            13: begin new_position_v[i] = enemy_position_start_v13; new_position_h[i] = enemy_position_start_h13; end
            14: begin new_position_v[i] = enemy_position_start_v14; new_position_h[i] = enemy_position_start_h14; end
            15: begin new_position_v[i] = enemy_position_start_v15; new_position_h[i] = enemy_position_start_h15; end
        endcase
	 end
        enemy_position_v[i] <= new_position_v[i];
		  enemy_position_h[i] <= new_position_h[i];
    end
	 end
	 end

// Logic to determine enemy type and color based on position
always @(*) begin
	 
	 // Define the top-left corner of the letter "G"
    parameter G_x_start1 = 270;
    parameter G_y_start1 = 100;
	 parameter G_x_start2 = 330;
    parameter G_y_start2 = 100;
    // Define the width and height of the letter "G"
    parameter G_width = 40;
    parameter G_height = 60;
    // Define the thickness of the stroke
    parameter stroke_thickness = 5;

	 if (scoreout < 200) begin
	 backgroundr <= 0;
    backgroundg <= 0;
    backgroundb <= 0;
	 end
	 else if ((scoreout >= 200) && (scoreout < 500)) begin
	 // Default background color
	 backgroundr <= 84;
    backgroundg <= 84;
    backgroundb <= 84;
	end else begin
	 backgroundr <= 169;
    backgroundg <= 169;
    backgroundb <= 169;
	end

    if (flag_gameover) begin
            // Default background color (red for game over)
            backgroundr <= 255;
            backgroundg <= 0;
            backgroundb <= 0;

            // Check if the current pixel is within the bounds of the first letter "G"
            if ((counth >= G_x_start1 && counth < G_x_start1 + G_width) &&
                (countv >= G_y_start1 && countv < G_y_start1 + G_height)) begin
                
                // Top horizontal stroke
                if (countv >= G_y_start1 && countv < G_y_start1 + stroke_thickness) begin
                    backgroundr <= 255;
                    backgroundg <= 255;
                    backgroundb <= 255;  // White color
                end
                // Bottom horizontal stroke
                else if (countv >= G_y_start1 + G_height - stroke_thickness && countv < G_y_start1 + G_height) begin
                    backgroundr <= 255;
                    backgroundg <= 255;
                    backgroundb <= 255;  // White color
                end
                // Left vertical stroke
                else if (counth >= G_x_start1 && counth < G_x_start1 + stroke_thickness) begin
                    backgroundr <= 255;
                    backgroundg <= 255;
                    backgroundb <= 255;  // White color
                end
                // Right vertical stroke (only in the bottom half)
                else if (counth >= G_x_start1 + G_width - stroke_thickness && counth < G_x_start1 + G_width &&
                         countv >= G_y_start1 + G_height/2) begin
                    backgroundr <= 255;
                    backgroundg <= 255;
                    backgroundb <= 255;  // White color
                end
                // Inner horizontal stroke of G
                else if (countv >= G_y_start1 + G_height/2 - stroke_thickness/2 && countv < G_y_start1 + G_height/2 + stroke_thickness/2 &&
                         counth >= G_x_start1 + G_width/2) begin
                    backgroundr <= 255;
                    backgroundg <= 255;
                    backgroundb <= 255;  // White color
                end
            end

            // Check if the current pixel is within the bounds of the second letter "G"
            else if ((counth >= G_x_start2 && counth < G_x_start2 + G_width) &&
                     (countv >= G_y_start2 && countv < G_y_start2 + G_height)) begin
                
                // Top horizontal stroke
                if (countv >= G_y_start2 && countv < G_y_start2 + stroke_thickness) begin
                    backgroundr <= 255;
                    backgroundg <= 255;
                    backgroundb <= 255;  // White color
                end
                // Bottom horizontal stroke
                else if (countv >= G_y_start2 + G_height - stroke_thickness && countv < G_y_start2 + G_height) begin
                    backgroundr <= 255;
                    backgroundg <= 255;
                    backgroundb <= 255;  // White color
                end
                // Left vertical stroke
                else if (counth >= G_x_start2 && counth < G_x_start2 + stroke_thickness) begin
                    backgroundr <= 255;
                    backgroundg <= 255;
                    backgroundb <= 255;  // White color
                end
                // Right vertical stroke (only in the bottom half)
                else if (counth >= G_x_start2 + G_width - stroke_thickness && counth < G_x_start2 + G_width &&
                         countv >= G_y_start2 + G_height/2) begin
                    backgroundr <= 255;
                    backgroundg <= 255;
                    backgroundb <= 255;  // White color
                end
                // Inner horizontal stroke of G
                else if (countv >= G_y_start2 + G_height/2 - stroke_thickness/2 && countv < G_y_start2 + G_height/2 + stroke_thickness/2 &&
                         counth >= G_x_start2 + G_width/2) begin
                    backgroundr <= 255;
                    backgroundg <= 255;
                    backgroundb <= 255;  // White color
                end
            end
        end
    else begin
        // Draw enemies
        for (integer i = 0; i < ENEMY_COUNT; i = i + 1) begin
            if (active_enemies[i] && !flag_hp[i]) begin
                case (enemy_type[i])
                    ENEMY_TYPE_1: begin
                        // Enemy Type 1 (+ shape)
                        if (((countv > enemy_position_v[i] && countv < enemy_position_v[i] + ENEMY_SIZE) &&
                             (counth == enemy_position_h[i] + ENEMY_SIZE / 2)) ||
                            ((counth > enemy_position_h[i] && counth < enemy_position_h[i] + ENEMY_SIZE) &&
                             (countv == enemy_position_v[i] + ENEMY_SIZE / 2))) begin
									if (bling[i] == 0) begin
                            backgroundr <= ENEMY_TYPE_1_COLOR_R;
                            backgroundg <= ENEMY_TYPE_1_COLOR_G;
                            backgroundb <= ENEMY_TYPE_1_COLOR_B;
									 end else if (bling[i] == 1) begin
									 backgroundr <= 255;
                            backgroundg <= 192;
                            backgroundb <= 203;
									 end
                        end
                    end
                    ENEMY_TYPE_2: begin
                        // Enemy Type 2 (X shape)
                        if ((countv - enemy_position_v[i] == counth - enemy_position_h[i] ||
                             countv - enemy_position_v[i] == ENEMY_SIZE - 1 - (counth - enemy_position_h[i])) &&
                             (countv >= enemy_position_v[i] && countv < enemy_position_v[i] + ENEMY_SIZE) &&
                             (counth >= enemy_position_h[i] && counth < enemy_position_h[i] + ENEMY_SIZE)) begin
                            if (bling[i] == 0) begin
                            backgroundr <= 46;
                            backgroundg <= 139;
                            backgroundb <= 87;
									 end else if (bling[i] == 1) begin
									 backgroundr <= 50;
                            backgroundg <= 205;
                            backgroundb <= 50;
									 end else if (bling[i] == 2) begin
									 backgroundr <= ENEMY_TYPE_2_COLOR_R;
                            backgroundg <= ENEMY_TYPE_2_COLOR_G;
                            backgroundb <= ENEMY_TYPE_2_COLOR_B;
									 end else if (bling[i] == 3) begin
									 backgroundr <= 0;
                            backgroundg <= 255;
                            backgroundb <= 0;
									 end
                        end
                    end
                    ENEMY_TYPE_3: begin
                        // Enemy Type 3 (Square shape)
                        if ((countv >= enemy_position_v[i] && countv < enemy_position_v[i] + ENEMY_SIZE) &&
                             (counth >= enemy_position_h[i] && counth < enemy_position_h[i] + ENEMY_SIZE)) begin
                            if (bling[i] == 0) begin
                            backgroundr <= 25;
                            backgroundg <= 25;
                            backgroundb <= 112;
									 end else if (bling[i] == 1) begin
									 backgroundr <= 0;
                            backgroundg <= 0;
                            backgroundb <= 205;
									 end else if (bling[i] == 2) begin
									 backgroundr <= 30;
                            backgroundg <= 144;
                            backgroundb <= 255;
									 end else if (bling[i] == 3) begin
									 backgroundr <= 0;
                            backgroundg <= 191;
                            backgroundb <= 255;
									 end else if (bling[i] == 4) begin
									 backgroundr <= 64;
                            backgroundg <= 224;
                            backgroundb <= 208;
									 end else if (bling[i] == 5) begin
									 backgroundr <= 127;
                            backgroundg <= 255;
                            backgroundb <= 212;
									 end
                        end
                    end
                endcase
            end
        end
    end
end


endmodule
