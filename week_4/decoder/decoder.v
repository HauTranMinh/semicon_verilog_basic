module decoder (
	input pclk,
	input preset_n,
	input psel,
	input penable,
	input pwrite,
	input [7:0] paddr, pwdata,
	output pready,
	output psvlerr);
// INTERNAL CONNECTION //
	reg [7:0] select_reg;
	reg ready_reg;
	reg svlerr_reg;
//---------------------------------------------------------------//

//------------------------DECODER SUB----------------------------//
	decoder_sub sub_module(.paddr(paddr), .select_reg(select_reg));
// => return one hot code for memory register                   //
//--------------------------------------------------------------//
// REGSITOR //

	register memory_reg(
		.pclk(pclk),
		.preset_n(preset_n),
		.psel(psel),
		.penable(penable),
		.pwrite(pwrite),
		.select_reg(select_reg),
		.pwdata(pwdata),
		.pready(ready_reg),
		.psvlerr(svlerr_reg));

//================================================================//
	assign pready = ready_reg;
	assign psvlerr = svlerr_reg;
//  done  //

endmodule