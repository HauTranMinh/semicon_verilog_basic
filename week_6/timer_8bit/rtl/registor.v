module registor(
	input pclk, 
	input preset_n,
	input psel,
	input penable,
	input pwrite,
	input [2:0] select_reg, // memory reg address
	input [7:0] pwdata,		// data for transfer
	input pready,

	output [7:0] TDR,
	output [7:0] TCR,
	output [7:0] TSR,
	output pslverr);

//--------------------------------internal connector reg-------------------------------------------//
	reg [7:0] TDR_reg;
	reg [7:0] TCR_reg;
	reg [7:0] TSR_reg;
	reg pslverr_reg;
//--------------------------------------------------------------------------------------------------//
	assign TDR = TDR_reg;
	assign TCR = TCR_reg;
	assign TSR = TSR_reg;
	assign pslverr = pslverr_reg;
//--------------------------------------------------------------------------------------------------//
	always @(posedge pclk or posedge preset_n) begin
		if (~preset_n) begin
			// reset
			TDR_reg <= 8'h00;
			TCR_reg <= 8'h00;
			TSR_reg <= 8'h00;
			pslverr_reg <= 1'b0;
		end
		else if (psel && pwrite && penable && pready) begin
			case(select_reg)
				3'b001: TDR_reg <= pwdata;
				3'b010: TCR_reg <= pwdata;
				3'b100:	TSR_reg <= pwdata;
				default: pslverr_reg <= 1'b1;
			endcase
		end
		else begin
			TDR_reg <= TDR_reg;
			TCR_reg <= TCR_reg;
			TSR_reg <= TSR_reg;
			pslverr_reg <= 1'b0;
		end
	end

endmodule