module encoder(
	input pclk, 
	input psel,
	input penable,
	input pwrite,
	input [2:0] select_reg, // memory reg address
	input pready,
	input [7:0] TDR,
	input [7:0] TCR,
	input [7:0] TSR,

	output [7:0] prdata);		

//--------------------------------internal connector reg-------------------------------------------//
	reg [7:0] data_reg;

//-----------------------------------------------------------------------------------------------//
	assign prdata = data_reg;

	always @(psel or pclk or penable or pready or pwrite) begin
		if (psel && pready && penable && ~pwrite) begin
			case(select_reg)
				3'b001:  data_reg <= TDR;
				3'b010:  data_reg <= TCR;
				3'b100:	 data_reg <= TSR;
			endcase
		end
		else begin
			data_reg <= 8'hXX;
		end
	end

endmodule