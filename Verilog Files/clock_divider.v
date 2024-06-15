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

module clock_divider(
    input clock, // 50MHz
    output cout0,
	 output cout1,
	 output cout2,
	 output cout3,
	 output cout4,
	 output cout5,
	 output cout6
	 );
 
    reg [32:0] count0; 
	 reg [32:0] count1;
	 reg [32:0] count2;
	 reg [32:0] count3;
	 reg [32:0] count4;
	 reg [32:0] count5;
	 reg [32:0] count6;
	 reg clock0;
	 reg clock1;
	 reg clock2;
	 reg clock3;
	 reg clock4;
	 reg clock5;
	 reg clock6;
	 
	 // ALL CLOCKS CALCULATED ASSUMING INPUT clock 50 MHz

	 //1SEC CLOCK 1hz
always @(posedge clock) begin 
	if(count0 == 25000000) begin
		clock0 = ~clock0;
      count0 <= 0;
   end else begin
      count0 <= count0 + 1;
   end
 end
 
 
	//0.5SEC CLOCK 2hz
 always @(posedge clock) begin 
	if(count1 == 12500000) begin
		clock1 = ~clock1;
      count1 <= 0;
   end else begin
      count1 <= count1 + 1;
   end
 end
 
 	//0.25SEC CLOCK 4hz
 always @(posedge clock) begin 
	if(count2 == 6250000) begin
		clock2 = ~clock2;
      count2 <= 0;
   end else begin
      count2 <= count2 + 1;
   end
 end
 
 //8 Hz
 always @(posedge clock) begin 
	if(count3 == 3125000) begin
		clock3 = ~clock3;
      count3 <= 0;
   end else begin
      count3 <= count3 + 1;
   end
 end
 
 //4SEC CLOCK
 always @(posedge clock) begin 
	if(count4 == 100000000) begin
		clock4 = ~clock4;
      count4 <= 0;
   end else begin
      count4 <= count4 + 1;
   end
 end
 
 //32Hz
  always @(posedge clock) begin 
	if(count5 == 390625) begin
		clock5 = ~clock5;
      count5 <= 0;
   end else begin
      count5 <= count5 + 1;
   end
 end
 
 //128Hz
  always @(posedge clock) begin 
	if(count6 == 97656) begin
		clock6 = ~clock6;
      count6 <= 0;
   end else begin
      count6 <= count6 + 1;
   end
 end
 
 assign cout0 = clock0;
 assign cout1 = clock1;
 assign cout2 = clock2;
 assign cout3 = clock3;
 assign cout4 = clock4;
 assign cout5 = clock5;
 assign cout6 = clock6;
 
endmodule
