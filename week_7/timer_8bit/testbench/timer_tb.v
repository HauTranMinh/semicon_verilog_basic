module timer_tb();
  	wire pclk;
	wire preset_n;
	wire psel;
	wire pwrite;
	wire penable;
	wire [7:0] pwdata;
	wire [7:0] paddr;
	wire pready;
	wire pslverr;

	wire [7:0] prdata;
	wire overflow_flag;	
	wire underflow_flag;

	timer dut(
		.pclk(pclk),
		.preset_n(preset_n),
		.psel(psel),
		.penable(penable),
		.pwrite(pwrite),
		.pwdata(pwdata),
		.paddr(paddr),

		.pready(pready),
		.pslverr(pslverr),
		.prdata(prdata),
		.overflow_flag(overflow_flag),
		.underflow_flag(underflow_flag));

	CPU_model cpu(
	    .cpu_pclk(pclk),
	    .cpu_presetn(preset_n),
	    .cpu_pready(pready),
	    .cpu_pslverr(pslverr),
	    .cpu_prdata(prdata),

	    .cpu_paddr(paddr),
	    .cpu_pwdata(pwdata),
	    .cpu_psel(psel),
	    .cpu_penable(penable),
	    .cpu_pwrite(pwrite));

  	system_signal system(
	    .sys_clk(pclk),
	    .sys_resetn(preset_n));

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