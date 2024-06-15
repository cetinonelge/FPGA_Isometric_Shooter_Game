module SSDCM(
    input clk,
    input [12:0] number,
    output reg [6:0] display0,
    output reg [6:0] display1,
    output reg [6:0] display2,
    output reg [6:0] display3
);
/*
SSDCM MODULE
CONTROL SEVEN SEGMENT DISPLAY TO DISPLAY THE SCORE
*/
reg [3:0] digit0;
reg [3:0] digit1;
reg [3:0] digit2;
reg [3:0] digit3;

always @(posedge clk) begin
    // Extract digits
    digit0 = number % 10; // Ones
    digit1 = (number / 10) % 10; // Tens
    digit2 = (number / 100) % 10; // Hundreds
    digit3 = (number / 1000) % 10; // Thousands

    // Decode each digit to seven-segment display
    case(digit0)
        4'b0000: display0 = 7'b1000000; 
        4'b0001: display0 = 7'b1111001; 
        4'b0010: display0 = 7'b0100100; 
        4'b0011: display0 = 7'b0110000; 
        4'b0100: display0 = 7'b0011001; 
        4'b0101: display0 = 7'b0010010; 
        4'b0110: display0 = 7'b0000010; 
        4'b0111: display0 = 7'b1111000; 
        4'b1000: display0 = 7'b0000000; 
        4'b1001: display0 = 7'b0010000; 
        default: display0 = 7'b1111111; 
    endcase
    
    case(digit1)
        4'b0000: display1 = 7'b1000000; 
        4'b0001: display1 = 7'b1111001; 
        4'b0010: display1 = 7'b0100100; 
        4'b0011: display1 = 7'b0110000; 
        4'b0100: display1 = 7'b0011001; 
        4'b0101: display1 = 7'b0010010; 
        4'b0110: display1 = 7'b0000010; 
        4'b0111: display1 = 7'b1111000; 
        4'b1000: display1 = 7'b0000000; 
        4'b1001: display1 = 7'b0010000; 
        default: display1 = 7'b1111111; 
    endcase

    case(digit2)
        4'b0000: display2 = 7'b1000000; 
        4'b0001: display2 = 7'b1111001; 
        4'b0010: display2 = 7'b0100100; 
        4'b0011: display2 = 7'b0110000; 
        4'b0100: display2 = 7'b0011001; 
        4'b0101: display2 = 7'b0010010; 
        4'b0110: display2 = 7'b0000010; 
        4'b0111: display2 = 7'b1111000; 
        4'b1000: display2 = 7'b0000000; 
        4'b1001: display2 = 7'b0010000; 
        default: display2 = 7'b1111111; 
    endcase

    case(digit3)
        4'b0000: display3 = 7'b1000000; 
        4'b0001: display3 = 7'b1111001; 
        4'b0010: display3 = 7'b0100100; 
        4'b0011: display3 = 7'b0110000; 
        4'b0100: display3 = 7'b0011001; 
        4'b0101: display3 = 7'b0010010; 
        4'b0110: display3 = 7'b0000010; 
        4'b0111: display3 = 7'b1111000; 
        4'b1000: display3 = 7'b0000000; 
        4'b1001: display3 = 7'b0010000; 
        default: display3 = 7'b1111111; 
    endcase
end

endmodule
