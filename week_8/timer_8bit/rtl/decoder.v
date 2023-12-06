module decoder(
	input [7:0] paddr,
	output [2:0] select_reg);

//--------------------------------internal registor----------------------------------------------//
	reg [2:0] internal_reg;
//-----------------------------------------------------------------------------------------------//

	always @(paddr) begin
		case(paddr) // need to review documents
			8'h00: internal_reg = 3'b001;
			8'h01: internal_reg = 3'b010;
			8'h02: internal_reg = 3'b100;
			default: internal_reg = 3'b000;
		endcase
	end

	assign select_reg = internal_reg;
endmodule