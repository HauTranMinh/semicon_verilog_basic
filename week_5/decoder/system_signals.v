module system_signal(
	// I/O ports declare
	output sys_clk,
	output sys_resetn);
	
	reg clk;
	reg reset_n;

	initial begin
		clk = 1'b0;
		forever #10 clk = ~clk;
	end

	initial begin
		reset_n = 1'b1;
		#30;
		reset_n = 1'b0;
		#50;
		reset_n = 1'b1;
	end
	
	assign sys_clk = clk;
	assign sys_resetn = reset_n;

endmodule