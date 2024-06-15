// video module for the DE1-SoC board
// Jan 2016
// by Fred Aulich
// Monitor counters and sync pulses


module vga_main(

	input clk, // 50 Mhz clock
	output reg vga_clk,
	output reg vga_blank_n,
	output reg vga_vs,
	output reg vga_hs,
	output reg [10:0] countv,
	output reg [10:0] counth
	
);

// internal counters

reg[10:0]	contvidv; // vertical counter 
reg[10:0]	contvidh; // horizontal counter
reg[2:0]		framev;   // frame counter
reg[4:0]	   clkcount; // clock divider
/////////////////////////////
////    control values  /////   
/////////////////////////////
reg 			vid_clk;

wire			vsync = ((contvidv >= 491) & (contvidv < 493))? 1'b0 : 1'b1;
wire			hsync = ((contvidh >= 664) & (contvidh < 760))? 1'b0 : 1'b1;
wire			vid_blank = ((contvidv >= 0) & (contvidv <  480) &(contvidh >= 0) & (contvidh < 640))? 1'b1 : 1'b0;
wire			clrvidh = (contvidh <= 800) ? 1'b0 : 1'b1;
wire  		clrvidv = (contvidv <= 525) ? 1'b0 : 1'b1;

////////////////////////////////////////
/// general clock divider 
/////////////////////////////////////////

 
 always @ (posedge clk )

begin 
		
		clkcount <= clkcount + 1;
		
end

///////////////////////////
///  25 Mhz clock    //////
///////////////////////////

always vid_clk <= clkcount[0]; 

///////////////////////////
/// frame counter    //////
///////////////////////////

always @ (posedge vsync)

begin

		framev <= framev + 1;
		
		end
		
/////////////////////////////////
// horizontal counter       /////
/////////////////////////////////

always @ (posedge vid_clk )

begin 

		if(clrvidh)
		begin
		contvidh <= 0;
		end
		
		else
		begin
		contvidh <= contvidh + 1;
		end
end

////////////////////////////////////////
//vertical counter when clrvidv is low /
////////////////////////////////////////

always @ (posedge vid_clk)

begin 

		if (clrvidv)
		begin
		contvidv <= 0;
		end
		
		else
		begin
			if
			(contvidh == 798)
			begin
			contvidv <= contvidv + 1; 
			end
		end
end


///////////////////////////////////////////////
/// assign required outputs                  //
///////////////////////////////////////////////

always vga_clk <= vid_clk;
always vga_vs <= vsync;
always vga_hs <= hsync;
always vga_blank_n <= vid_blank;
always counth <= contvidh;
always countv <= contvidv;

endmodule