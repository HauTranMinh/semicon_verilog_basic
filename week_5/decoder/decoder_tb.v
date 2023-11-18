module decoder_tb();
// declare net datatype for testing signal //
	wire pclk;
	wire preset_n;
	wire psel;
	wire penable;
	wire pwrite;
	wire [7:0] paddr, pwdata, prdata;
	wire pready, psvlerr;

	decoder dut(
		.pclk(pclk),
		.preset_n(preset_n),
		.psel(psel),
		.penable(penable),
		.pwrite(pwrite),
		.pwdata(pwdata),
		.prdata(prdata),
		.paddr(paddr),
		.pready(pready),
		.psvlerr(psvlerr));

	system_signal system(
		.sys_clk(pclk),
		.sys_resetn(preset_n));


	cpu_model cpu(
		.cpu_clk(pclk),
		.cpu_presetn(preset_n),
		.cpu_pready(pready),
		.cpu_pslverr(psvlerr),
		.cpu_prdata(prdata),

		.cpu_paddr(paddr),
		.cpu_pwdata(pwdata),
		.cpu_psel(psel),
		.cpu_penable(penable),
		.cpu_pwrite(pwrite));

	task get_results(input flag);
		begin
			if (flag) begin
				$display("===================================");
				$display("================FAIL===============");
				$display("===================================");
			end
			else begin
				$display("===================================");
				$display("================PASS===============");
				$display("===================================");
			end
		end

	endtask
	
endmodule