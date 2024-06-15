module spaceship_movement(
    input up,            // Input signal to move up
    input down,          // Input signal to move down
    output reg [3:0] out // 4-bit output representing the current position
);

// Registers to track the state of up and down signals
reg count_up;   // Register to track up signal
reg count_down; // Register to track down signal

// Always block to update count_up register based on up and down signals
always @(negedge up or negedge down)
    if (!down) 
        count_up <= 1'b0;  // Set count_up to 0 when down is asserted
    else
        count_up <= 1'b1;  // Set count_up to 1 when down is not asserted

// Always block to update count_down register based on up and down signals
always @(negedge up or negedge down)
    if (!up) 
        count_down <= 1'b0; // Set count_down to 0 when up is asserted
    else 
        count_down <= 1'b1; // Set count_down to 1 when up is not asserted

// Generate a pulse when both up and down signals are high
wire count_pulse = up & down;

// Always block to update the output based on the count_pulse signal
always @(posedge count_pulse) begin
    if (count_up) 
        out <= out + 1'b1;       // Increment the output if count_up is high
    else if (count_down) 
        out <= out - 1'b1;       // Decrement the output if count_down is high
    else 
        out <= out;              // Keep the output unchanged otherwise
end

endmodule
