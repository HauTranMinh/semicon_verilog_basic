module registor_control(
	input pclk,
	input preset_n,
	input psel,
	input pwrite,
	input penable,
	input [7:0] paddr,
	input [7:0] pwdata,
	input overflow_flag,
	input underflow_flag,

	output [7:0] TDR,
	output [7:0] TCR,
	output [7:0] TSR,
	output [7:0] prdata,
	output [1:0] clear_flag,
	output pready,
	output pslverr);

//--------------------------------internal connector wire-------------------------------------------//
	wire [2:0] select_reg;
//--------------------------------SUB module--------------------------------------------------------//
	decoder decoder(
		.paddr(paddr),
		.select_reg(select_reg));

	registor registor(
		.pclk(pclk),
		.preset_n(preset_n),
		.psel(psel),
		.penable(penable),
		.pwrite(pwrite),
		.select_reg(select_reg),
		.pwdata(pwdata),
		.pready(pready),
		.overflow_flag(overflow_flag),
		.underflow_flag(underflow_flag),

		.clear_flag(clear_flag),
		.TDR(TDR),
		.TSR(TSR),
		.TCR(TCR),
		.pslverr(pslverr));

	encoder encoder(
		.pclk(pclk),
		.psel(psel),
		.penable(penable),
		.pwrite(pwrite),
		.select_reg(select_reg),
		.pready(pready),
		.TDR(TDR),
		.TCR(TCR),
		.TSR(TSR),
		.prdata(prdata));

	timer_pready pready_signal(
		.psel(psel),
		.pclk(pclk),
		.preset_n(preset_n),
		.penable(penable),
		.pready(pready));




endmodule