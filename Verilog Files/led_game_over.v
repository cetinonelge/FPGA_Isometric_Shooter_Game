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

module led_game_over(
    input wire clk,          // Clock input
    input wire game_over,    // Game over condition input
    output reg [9:0] leds    // Output LEDs
);

/*
MODULE LED_GAME_OVER
LEDS BLINK WHEN THE GAME IS OVER
*/
    reg [3:0] state = 4'b00; // State variable to control LED patterns
		reg [24:0] counter = 0; // Counter to divide clock frequency
	reg [32:0] cout;
    always @(posedge clk) begin
        // Increment counter on every positive edge of clk_50MHz
        counter <= counter + 1;

        // Divide 50 MHz input clock to get 2 Hz output clock
        if (counter == 12500000) begin
            cout <= ~cout; // Toggle 2 Hz clock
            counter <= 0;        // Reset counter
        end
    end
    always @(posedge cout) begin
        if (game_over == 1'b1) begin
            case(state)
                4'b00: begin // LEDs 0, 2, 4, 6, 8 are on, LEDs 1, 3, 5, 7, 9 are off
                    leds <= 10'b0101010100;
                    state <= 4'b01;
                end
                4'b01: begin // LEDs 1, 3, 5, 7, 9 are on, LEDs 0, 2, 4, 6, 8 are off
                    leds <= 10'b1010101010;
                    state <= 4'b00;
                end
                default: begin
                    leds <= 10'b0000000000; // Default case, should not occur
                    state <= 4'b00; // Reset state to initial state
                end
            endcase
        end else begin
            leds <= 10'b0000000000; // When game_over is 0, turn off all LEDs
            state <= 4'b00; // Reset state to initial state
        end
    end

endmodule

