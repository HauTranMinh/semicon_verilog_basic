module read_write_control(
	input pclk,
	input preset_n,
	input psel,
	input pwrite,
	input penable,
	input [7:0] paddr,
	input [7:0] pwdata,

	output [7:0] TDR,
	output [7:0] TCR,
	output [7:0] TSR,
	output [7:0] prdata,
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