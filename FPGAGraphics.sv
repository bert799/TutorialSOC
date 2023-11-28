
module FPGAGraphics (
	input wire logic clk_50,       // input clock (50 MHz)
	input wire logic rst
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