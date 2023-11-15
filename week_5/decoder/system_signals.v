module system_signal(
	// I/O ports declare
	output sys_clk,
	output sys_resetn);
	
	initial begin
		sys_clk = 0;
		forever #5 sys_clk = ~sys_clk;
	end

	initial begin
		sys_resetn = 1'b1;
		#30;
		sys_resetn = 1'b0;
		#50;
		sys_resetn = 1'b1;
	end
	
endmodule