
module FPGAGraphics (
	input wire logic clk_50,       // input clock (50 MHz)
	input wire logic rst
	input  wire logic clk_pix,   // pixel clock
	input  wire logic rst_pix,   // reset in pixel clock domain
	output      logic [11:0] sx, // horizontal screen position
	output      logic [11:0] sy, // vertical screen position
	output		logic VGA_CLK,
	output		logic VGA_BLANK_N,
	output      logic VGA_HS,     // horizontal sync
	output      logic VGA_VS,     // vertical sync
	output		logic [7:0] VGA_R,
	output		logic [7:0] VGA_G,
	output		logic [7:0] VGA_B,
	output      logic VGA_SYNC_N,
	output      logic de         // data enable (low in blanking interval)
);


wire clk_pxl_25;
wire clk_pxl_75;
wire clk_pix_locked;

PLL75_50 alt_clk_spd 
(
	.refclk(clk_50),
	.rst(rst),
S
	.outclk_1(clk_pix_75),
	.locked(clk_pix_locked)
);

endmodule