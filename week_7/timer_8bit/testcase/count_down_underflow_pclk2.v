module count_down_underflow_pclk2();
	reg [7:0] address, wdata, rdata;
	reg flag;
	integer i;
	reg [7:0] mask_TCR_reg = 8'b1011_0011;
	reg [7:0] mask_TDR_reg = 8'b1111_1111;
	reg [7:0] mask_TSR_reg = 8'b0000_0011;

	timer_tb top();

	initial begin
		// reset system for 1st time
		top.system.reset();
		#100;
		$display("==============================================================================");
		$display("============Read_write_3Read_write_3_register_register_test_begin=============");
		$display("==============================================================================");
		$display("\n");

		
		$display("=====================load TDR to timer========================================");
		$display("\n");

		address = 8'h00; // TDR addess using APB protocol to write
		wdata = 8'h64; // Load 'd100 to TDR => Timer need to count down 100 internal clock to send out underflag
		
		// write to Timer 
		top.cpu.write_CPU(address, wdata);
		$display("write value to TDR at %0t", $time);

		#10;
		
		$display("\n");
		$display("=====================load TCR to timer========================================");
		$display("\n");

		
		address = 8'h01; // TCR addess using APB protocol to write
		wdata = 8'b10_11_00_00; // Load 8'b10_11_00_00 to TCR => set timer to count down with internal clock = 2T pclk 

		// load = TCR[7] = 1 => load to register
		// up/dw bit = 1 => count down
		// en bit => enable timer
		// cks [1:0] = 00 => internal clock = 2T Pclk external 
		// ====> timer need more than (100 * 2) + 1 signal clock to send out underflow flag;
		
		// write to Timer
		address = 8'h01;
		top.cpu.write_CPU(address, wdata);
		$display("write configuration %0d to TCR at %0t", wdata, $time);

		// T pclk = 10 DVTG => ((100*2) + 1) * 10 = 2010 DVTG 
		// timer need at least 2010 DVTG to send out underflag
		#2050 // make sure to capture underflow flag

		
		$display("read TSR=%0d register at %0t", rdata, $time);
		address = 8'h02;
		top.cpu.read_CPU(address, rdata);

		if (rdata[1] == 1'b1) begin
			flag = 0;
			$display("=======================================PASS==================================");
		end
		else begin
			flag = 1;
			$display("======================================FAIL===================================");

		end
		#100;
		top.get_results(flag);
		#100;
		$finish();
	end
endmodule
