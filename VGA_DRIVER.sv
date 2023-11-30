module VGA_DRIVER (
	input wire 	logic clk_pix,   // pixel clock
	input wire 	logic clk_locked,
	output		logic VGA_BLANK_N,
	output		logic VGA_SYNC_N,
	output 		reg VGA_HS,     // horizontal sync
	output 		reg VGA_VS,     // vertical sync
	output		logic [7:0] VGA_R,
	output		logic [7:0] VGA_G,
	output		logic [7:0] VGA_B,
	output reg		[10:0]	H_Cont,
	output reg		[10:0]	V_Cont
	//output		logic VGA_SYNC_N
	//output		logic de         // data enable (low in blanking interval)
);

//	Internal Registers
	//output reg		[10:0]	H_Cont;
	//output reg		[10:0]	V_Cont;
	reg		[21:0]	Address;
	reg		[10:0]	Current_X;
	reg		[10:0]	Current_Y;

////////////////////////////////////////////////////////////
//	Horizontal	Parameter
	parameter	H_FRONT	=	16;
	parameter	H_SYNC	=	96;
	parameter	H_BACK	=	48;
	parameter	H_ACT	=	640;
	parameter	H_BLANK	=	H_FRONT+H_SYNC+H_BACK;
	parameter	H_TOTAL	=	H_FRONT+H_SYNC+H_BACK+H_ACT;
////////////////////////////////////////////////////////////
//	Vertical Parameter
	parameter	V_FRONT	=	10;
	parameter	V_SYNC	=	2;
	parameter	V_BACK	=	33;
	parameter	V_ACT	=	480;
	parameter	V_BLANK	=	V_FRONT+V_SYNC+V_BACK;
	parameter	V_TOTAL	=	V_FRONT+V_SYNC+V_BACK+V_ACT;
////////////////////////////////////////////////////////////
	assign 	VGA_SYNC_N  =  1'b1;			//	This pin is unused.
	assign	VGA_BLANK_N	=	~((H_Cont<H_BLANK)||(V_Cont<V_BLANK));

	assign	Address	=	Current_Y*H_ACT+Current_X;
	assign	Current_X	=	(H_Cont>=H_BLANK)	?	H_Cont-H_BLANK	:	11'h0	;
	assign	Current_Y	=	(V_Cont>=V_BLANK)	?	V_Cont-V_BLANK	:	11'h0	;

	//	Horizontal Generator: Refer to the pixel clock
	always_ff@(posedge clk_pix)
	begin
		if(H_Cont<H_TOTAL)
		H_Cont	<=	H_Cont+1'b1;
		else
		H_Cont	<=	0;
		//	Horizontal Sync
		if(H_Cont==H_FRONT-1)			//	Front porch end
		VGA_HS	<=	1'b0;
		if(H_Cont==H_FRONT+H_SYNC-1)	//	Sync pulse end
		VGA_HS	<=	1'b1;
	end
	
	//	Vertical Generator: Refer to the horizontal sync
	always_ff@(posedge VGA_HS)
	begin
		if(V_Cont<V_TOTAL)
		V_Cont	<=	V_Cont+1'b1;
		else
		V_Cont	<=	0;
		//	Vertical Sync
		if(V_Cont==V_FRONT-1)			//	Front porch end
		VGA_VS	<=	1'b0;
		if(V_Cont==V_FRONT+V_SYNC-1)	//	Sync pulse end
		VGA_VS	<=	1'b1;
	end

	// paint colour: based on screen position
	logic [7:0] paint_r, paint_g, paint_b;
	always_comb begin
		if (H_Cont < 256 && V_Cont < 256) begin  // colour square in top-left 256x256 pixels
			paint_r = H_Cont[7:4];  // 16 horizontal pixels of each red level
			paint_g = V_Cont[7:4];  // 16 vertical pixels of each green level
			paint_b = 4'h4;     // constant blue level
		end else begin  // background colour
			paint_r = 4'h0;
			paint_g = 4'h1;
			paint_b = 4'h3;
		end
	end

	// display colour: paint colour but black in blanking interval
	logic [7:0] display_r, display_g, display_b;
	always_comb begin
		display_r = (VGA_BLANK_N) ? paint_r : 4'h0;
		display_g = (VGA_BLANK_N) ? paint_g : 4'h0;
		display_b = (VGA_BLANK_N) ? paint_b : 4'h0;
	end

	// VGA Pmod output
	always_ff @(posedge clk_pix) begin
		VGA_R <= display_r;
		VGA_G <= display_g;
		VGA_B <= display_b;
	end

endmodule