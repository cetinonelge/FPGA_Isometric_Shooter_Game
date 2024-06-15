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

module spaceship_generator(
    input clk,              // Clock input
    input [3:0] angle,      // Angle input to determine marker position
    input [10:0] counth,    // Horizontal counter input
    input [10:0] countv,    // Vertical counter input
    input shootingmode0,    // Shooting mode 0 input
    input shootingmode1,    // Shooting mode 1 input
    input switchmode,       // Mode switch input
    input key2,             // Key2 input
    input game_over,        // Game over input
    output reg [7:0] arear, // Red component of marker color
    output reg [7:0] areag, // Green component of marker color
    output reg [7:8] areab, // Blue component of marker color
    output reg [7:0] spcsr, // Red component of spaceship color
    output reg [7:0] spcsg, // Green component of spaceship color
    output reg [7:0] spcsb  // Blue component of spaceship color
);

// Parameters for the spaceship and marker positioning
localparam h_center = 320;         // Center of the spaceship in the horizontal direction
localparam v_center = 240;         // Center of the spaceship in the vertical direction
localparam radius = 14;            // Radius of the spaceship circle
localparam marker_radius = 6;      // Radius of the marker

// Registers for the marker's center position
reg [10:0] marker_h_center;        // Center of the marker in the horizontal direction
reg [10:0] marker_v_center;        // Center of the marker in the vertical direction

// Always block to calculate the marker position based on the angle
always @(negedge clk) begin
    // Determine the marker's center based on the angle
    case (angle)
        4'd0: begin
            marker_h_center = h_center + radius - marker_radius / 4;
            marker_v_center = v_center;
        end
        4'd1: begin
            marker_h_center = h_center + (radius - marker_radius / 4) * 0.923;
            marker_v_center = v_center - (radius - marker_radius / 4) * 0.383;
        end
        4'd2: begin
            marker_h_center = h_center + (radius - marker_radius / 4) * 0.707;
            marker_v_center = v_center - (radius - marker_radius / 4) * 0.707;
        end
        4'd3: begin
            marker_h_center = h_center + (radius - marker_radius / 4) * 0.383;
            marker_v_center = v_center - (radius - marker_radius / 4) * 0.923;
        end
        4'd4: begin
            marker_h_center = h_center;
            marker_v_center = v_center - radius + marker_radius / 4;
        end
        4'd5: begin
            marker_h_center = h_center - (radius - marker_radius / 4) * 0.383;
            marker_v_center = v_center - (radius - marker_radius / 4) * 0.923;
        end
        4'd6: begin
            marker_h_center = h_center - (radius - marker_radius / 4) * 0.707;
            marker_v_center = v_center - (radius - marker_radius / 4) * 0.707;
        end
        4'd7: begin
            marker_h_center = h_center - (radius - marker_radius / 4) * 0.923;
            marker_v_center = v_center - (radius - marker_radius / 4) * 0.383;
        end
        4'd8: begin
            marker_h_center = h_center - radius + marker_radius / 4;
            marker_v_center = v_center;
        end
        4'd9: begin
            marker_h_center = h_center - (radius - marker_radius / 4) * 0.923;
            marker_v_center = v_center + (radius - marker_radius / 4) * 0.383;
        end
        4'd10: begin
            marker_h_center = h_center - (radius - marker_radius / 4) * 0.707;
            marker_v_center = v_center + (radius - marker_radius / 4) * 0.707;
        end
        4'd11: begin
            marker_h_center = h_center - (radius - marker_radius / 4) * 0.383;
            marker_v_center = v_center + (radius - marker_radius / 4) * 0.923;
        end
        4'd12: begin
            marker_h_center = h_center;
            marker_v_center = v_center + radius - marker_radius / 4;
        end
        4'd13: begin
            marker_h_center = h_center + (radius - marker_radius / 4) * 0.383;
            marker_v_center = v_center + (radius - marker_radius / 4) * 0.923;
        end
        4'd14: begin
            marker_h_center = h_center + (radius - marker_radius / 4) * 0.707;
            marker_v_center = v_center + (radius - marker_radius / 4) * 0.707;
        end
        4'd15: begin
            marker_h_center = h_center + (radius - marker_radius / 4) * 0.923;
            marker_v_center = v_center + (radius - marker_radius / 4) * 0.383;
        end
        default: begin
            marker_h_center = h_center;
            marker_v_center = v_center;
        end
    endcase

    // Game over state: set marker color to red
    if(game_over) begin
        arear <= 8'd255;    // Red color
        areag <= 8'd0;
        areab <= 8'd0;
    end else begin
        // Check if the current pixel is within the marker circle
        if (((counth - marker_h_center) * (counth - marker_h_center) + 
             (countv - marker_v_center) * (countv - marker_v_center)) <= marker_radius * marker_radius) begin
            // Determine marker color based on shooting mode and key2 state
            if (shootingmode0 == 0 && switchmode == 0  && key2 == 1) begin
                arear <= 8'd255;  // Yellow color
                areag <= 8'd255;
                areab <= 8'd0;
            end else if (shootingmode1 == 0 && switchmode == 1 && key2 == 1) begin
                arear <= 8'd127;  // Red color
                areag <= 8'd0;
                areab <= 8'd255;
            end else if (key2 == 0) begin
                arear <= 8'd255;  // Pink color
                areag <= 8'd192;
                areab <= 8'd203;
            end else begin
                arear <= 8'd0;    // Default color
                areag <= 8'd255;
                areab <= 8'd255;
            end
        end else begin
            // Set marker color outside the marker area
            arear <= 8'd255;
            areag <= 8'd0;
            areab <= 8'd0;
        end

        // Check if the current pixel is within the spaceship circle
        if (((counth - h_center) * (counth - h_center) + 
             (countv - v_center) * (countv - v_center)) <= radius * radius) begin
            spcsr <= 8'd0;      // Cyan color
            spcsg <= 8'd255;
            spcsb <= 8'd255;
        end else begin
            // Set spaceship color outside the spaceship area to match marker color
            spcsr <= arear;
            spcsg <= areag;
            spcsb <= areab;
        end
    end
end

endmodule
