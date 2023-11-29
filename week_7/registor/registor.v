//=======================registor sub model===============================//
// sub module of registor with an 8 bits input and output an 8 bits registor
// active by rising edge clk signal
// for later reuse

// Name: Hau Tran
// date: 11_27_2023
//=======================================================================//
// need to modify depend on which protocol that is using
module registor(
	input clk,
	input reset_n,
	input write_data,

	output [7:0] registor);
//=======================internal registor===============================// 
	reg [7:0] internal_reg;
//=======================================================================// 
	assign registor = internal_reg;
//=======================================================================// 
	always @(posedge clk or negedge reset_n) begin
		if (~reset_n) begin
			// reset
			internal_reg <= 8'h00;
		end
		else begin
			internal_reg <= write_data;
		end
	end

endmodule