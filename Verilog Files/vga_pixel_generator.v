module vga_pixel_generator(
    input clk,                    // Clock input
    input wire [10:0] counth,     // Horizontal counter input
    input wire [10:0] countv,     // Vertical counter input
    input wire [7:0] spcsr,       // Red component of spaceship color
    input wire [7:8] spcsg,       // Green component of spaceship color
    input wire [7:8] spcsb,       // Blue component of spaceship color
    input wire [7:0] backgroundr, // Red component of background color
    input wire [7:0] backgroundg, // Green component of background color
    input wire [7:0] backgroundb, // Blue component of background color
    output reg [7:0] vga_r,       // Red component of VGA output
    output reg [7:0] vga_g,       // Green component of VGA output
    output reg [7:0] vga_b        // Blue component of VGA output
);

// Always block triggered on the negative edge of the clock
always @(negedge clk) begin
    // Check if the current pixel is within the vertical range of the spaceship
    if (countv > 220 && countv < 260) begin 
        // Check if the current pixel is within the horizontal range of the spaceship
        if (counth > 300 && counth < 340) begin
            // Set VGA output to spaceship color if within the spaceship area
            vga_r <= spcsr;
            vga_g <= spcsg;
            vga_b <= spcsb;
        end else begin 
            // Set VGA output to background color if outside the spaceship area
            vga_r <= backgroundr;
            vga_g <= backgroundg;
            vga_b <= backgroundb;
        end
    end else begin 
        // Set VGA output to background color if outside the vertical range of the spaceship
        vga_r <= backgroundr;
        vga_g <= backgroundg;
        vga_b <= backgroundb;
    end
end

endmodule
