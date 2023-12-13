module timer(
	// I/O ports declare
	input pclk,
	input preset_n,
	input psel,
	input pwrite,
	input penable,
	input [7:0] pwdata,
	input [7:0] paddr,
	// input [1:0] cks,
	
	output pready,
	output pslverr,
	output [7:0] prdata,
	output overflow_flag, 			// for FPGA demo 
	output underflow_flag);			// for FPGA demo

//===========================internal wire==================================//
	wire internal_clock; // define by user by cks input 
	wire [7:0] TDR;
	wire [7:0] TCR;
	wire [7:0] TSR;
	wire [7:0] counter_wire;
	wire [7:0] last_counter_wire;
	wire [1:0] clear_flag;
//=============================SUB module===================================//

	registor_control reg_control(
		.pclk(pclk),
		.preset_n(preset_n),
		.psel(psel),
		.penable(penable),
		.pwrite(pwrite),
		.paddr(paddr),
		.pwdata(pwdata),
		.overflow_flag(overflow_flag),
		.underflow_flag(underflow_flag),

		.TDR(TDR),
		.TCR(TCR),
		.TSR(TSR),
		.prdata(prdata),
		.clear_flag(clear_flag),
		.pready(pready),
		.pslverr(pslverr));

	select_clock select_clock(
		.pclk(pclk),
		.preset_n(preset_n),
		.cks(TCR[1:0]),
		.int_clk(internal_clock));

	counter counter_module(
		.pclk(pclk),
		.preset_n(preset_n),
		.clk_in(internal_clock),
		.TDR(TDR),
		.TCR(TCR),

		.counter_signal(counter_wire),
		.last_counter(last_counter_wire));

	overflow_detect ovf_detect(
		.pclk(pclk),
		.preset_n(preset_n),
		.counter(counter_wire),
		.last_counter(last_counter_wire),
		.up_down(TCR[5]),
		.load(TCR[7]),
		.enable(TCR[4]),
		.clear_overflow(clear_flag[0]),

		.overflow_flag(overflow_flag));

	underflow_detect udf_detect(
		.pclk(pclk),
		.preset_n(preset_n),
		.counter(counter_wire),
		.last_counter(last_counter_wire),
		.up_down(TCR[5]),
		.load(TCR[7]),
		.enable(TCR[4]),
		.clear_underflow(clear_flag[1]),

		.underflow_flag(underflow_flag));
endmodule
