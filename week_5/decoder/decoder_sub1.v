module decoder_sub(
	input 	[7:0] paddr,
	output 	[7:0] select_reg);
	 
//--------------------------------internal registor----------------------------------------------//
	reg [7:0] internal_reg;

//-----------------------------------------------------------------------------------------------//
	always @(paddr) begin
		case (paddr)
			8'h00: internal_reg 	= 8'b0000_0001; // thanh A
			8'h01: internal_reg 	= 8'b0000_0010; // thanh B
			8'h02: internal_reg 	= 8'b0000_0100; // thanh C
			8'h03: internal_reg 	= 8'b0000_1000; // thanh D
			8'h04: internal_reg 	= 8'b0001_0000; // thanh E
			8'h05: internal_reg 	= 8'b0010_0000; // thanh F
			8'h06: internal_reg 	= 8'b0100_0000; // thanh G
			8'h07: internal_reg 	= 8'b1000_0000; // thanh H
			default: internal_reg 	= 8'b0000_0000; //reserved addr = 08 -> ff
		endcase
	end
//=================================================================================================//

	assign select_reg = internal_reg;
endmodule