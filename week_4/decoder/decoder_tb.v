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

		pclk = 0;
		preset_n = 0;
		psel = 0;
		penable = 0;
		pwrite = 0;
		#5;
		paddr = 8'h00;
		pwdata = 8'haa;
		#30;

		pclk = 1;
		preset_n = 1;
		psel = 1;
		penable = 1;
		pwrite = 1;
		#5;
		paddr = 8'h01;
		pwdata = 8'hfa;
		#30;

		pclk = 1;
		preset_n = 1;
		psel = 1;
		penable = 1;
		pwrite = 1;
		#5;
		paddr = $random();
		pwdata = $random();
		#30;

		pclk = 1;
		preset_n = 1;
		psel = 1;
		penable = 1;
		pwrite = 1;
		#5;
		paddr = $random();
		pwdata = $random();
		#30;

		$finish;
	end
	
endmodule