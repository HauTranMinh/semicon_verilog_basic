module decoder_tb();
// declare net datatype for testing signal //
	reg pclk;
	reg preset_n;
	reg psel;
	reg penable;
	reg pwrite;
	reg [7:0] paddr, pwdata;
	wire pready, psvlerr;

	decoder dut(
		.pclk(pclk),
		.preset_n(preset_n),
		.psel(psel),
		.penable(penable),
		.pwrite(pwrite),
		.pwdata(pwdata),
		.paddr(paddr),
		.pready(pready),
		.psvlerr(psvlerr));
// Pclock generator //
	initial begin
		pclk = 0;
		forever #5 pclk = ~pclk;
	end

// test case //
	initial begin
		pclk = 0;
		preset_n = 0;
		#50;
	end
	
endmodule