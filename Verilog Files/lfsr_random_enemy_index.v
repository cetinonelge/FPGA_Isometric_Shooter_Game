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

module lfsr_random_enemy_index(
	input clk,
	output [3:0] spawn_index
);

wire lfsr_time;

clock_divider u1(
    .clock(clk),
    .cout2(lfsr_time)
);

reg [31:0] state; // Internal state of the LFSR

// Initialize with a specific value
initial begin
    state = 32'hABCDE123; // Example initialization value
end

always @(posedge lfsr_time) begin
    // Feedback polynomial: x^32 + x^22 + x^2 + x^1 + 1
    // New state = (current_state << 1) ^ (current_state[32-22] ^ current_state[32-2] ^ current_state[32-1])
    state <= {state[30:0], state[31] ^ state[11] ^ state[1] ^ state[0]};
end

	 assign spawn_index = state % 16;
	 
endmodule
