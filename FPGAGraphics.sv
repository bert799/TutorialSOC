
module FPGAGraphics (
	input wire logic CLOCK_50,       // input clock (50 MHz)
	input wire logic rst,
	output		logic VGA_CLK,
	output		logic VGA_BLANK_N,
	output      logic VGA_SYNC_N,
	output      logic VGA_HS,     // horizontal sync
	output      logic VGA_VS,     // vertical sync
	output		logic [7:0] VGA_R,
	output		logic [7:0] VGA_G,
	output		logic [7:0] VGA_B,
	
	output 		logic [8:0] LEDR,
	
	output logic [10:0]H_Cont,
	output logic [10:0]V_Cont
);

assign VGA_CLK = clk_pix_25;

logic clk_pix_25;
wire clk_pix_75;
wire clk_pix_locked;

	always_ff @(posedge CLOCK_50) begin
		if(clk_pix_25==1)
			clk_pix_25 = 0;
		else
			clk_pix_25 = 1;
	end
/*
//	For VGA Controller
wire	[9:0]	mRed;
wire	[9:0]	mGreen;
wire	[9:0]	mBlue;
wire	[10:0]	VGA_X;
wire	[10:0]	VGA_Y;
wire			VGA_Read;	//	VGA data request
wire			m1VGA_Read;	//	Read odd field
wire			m2VGA_Read;	//	Read even field

assign	LEDR[8:0]	=	VGA_Y[8:0];

assign	m1VGA_Read	=	VGA_Y[0]		?	1'b0		:	VGA_Read	;
assign	m2VGA_Read	=	VGA_Y[0]		?	VGA_Read	:	1'b0		; */

/*PLL75_50 alt_clk_spd 
(
	.refclk(CLOCK_50),
	.rst(rst),
	.outclk_0(clk_pix_25),
	.outclk_1(clk_pix_75),
	.locked(clk_pix_locked)
); */

VGA_DRIVER vga_inst
(
	.clk_pix(clk_pix_25),   // pixel clock
	.clk_locked(clk_pix_locked),
	.VGA_BLANK_N,
	.VGA_SYNC_N,
	.VGA_HS(VGA_HS),     // horizontal sync
	.VGA_VS(VGA_VS),     // vertical sync
	.VGA_R(VGA_R),
	.VGA_G(VGA_G),
	.VGA_B(VGA_B),
	.H_Cont(H_Cont),
	.V_Cont(V_Cont)
);
/*
//	VGA Controller
wire [9:0] vga_r10;
wire [9:0] vga_g10;
wire [9:0] vga_b10;
assign VGA_R = vga_r10[9:2];
assign VGA_G = vga_g10[9:2];
assign VGA_B = vga_b10[9:2];

VGA_Ctrl vga_inst
(
	//	Host Side
	.iRed(mRed),
	.iGreen(mGreen),
	.iBlue(mBlue),
	.oCurrent_X(VGA_X),
	.oCurrent_Y(VGA_Y),
	.oRequest(VGA_Read),
	//	VGA Side
	.oVGA_R(vga_r10),
	.oVGA_G(vga_g10),
	.oVGA_B(vga_b10),
	.oVGA_HS(VGA_HS),
	.oVGA_VS(VGA_VS),
	.oVGA_SYNC(VGA_SYNC_N),
	.oVGA_BLANK(VGA_BLANK_N),
	.oVGA_CLOCK(VGA_CLK),
	//	Control Signal
	.iCLK(clk_pix_25),
	.iRST_N(clk_pix_locked)
);
*/
	always_ff @(posedge CLOCK_50) begin
		LEDR[0] <= VGA_BLANK_N;
		LEDR[1] <= VGA_HS;
		LEDR[2] <= VGA_VS;
	end 

endmodule