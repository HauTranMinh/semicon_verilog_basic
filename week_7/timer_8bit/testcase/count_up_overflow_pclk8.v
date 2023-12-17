module count_up_overflow_pclk8();
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
		$display("=======================COUNT UP PCLK 2__test_begin============================");
		$display("==============================================================================");
		$display("\n");
		
		for(i = 0; i<10; i = i+1) begin
		
		$display("=====================load TDR to timer========================================");
		$display("\n");
		
		top.system.reset();
		#100;

		address = 8'h00; // TDR addess using APB protocol to write
		wdata = 8'h00; // Load 'd00 to TDR => Timer need to count down 255 internal clock to send out overflowflag
		// write to TDR registor 
		top.cpu.write_CPU(address, wdata);

		address = 8'h01;
		wdata = 8'b10_00_00_00;
		$display("load value TDR at %0t to counter_reg", $time);
		top.cpu.write_CPU(address, wdata);

		#10;
		
		$display("\n");
		$display("=====================configurate TCR to timer=================================");
		$display("\n");

		
		address = 8'h01; // TCR addess using APB protocol to write
		wdata = 8'b00_01_00_10; // Load 8'b00_11_00_00 to TCR => set timer to count down with internal clock = 2T pclk 

		// load = TCR[7] = 1 => load to register
		// up/dw bit = 0 => count up
		// en bit => enable timer
		// cks [1:0] = 00 => internal clock = 2T Pclk external 
		// ====> timer need more than (255 * 2) + 1 signal clock to send out underflow flag;
		
		// write to Timer
		top.cpu.write_CPU(address, wdata);
		$display("write configuration %0d to TCR at %0t", wdata, $time);

		// T pclk = 10 DVTG => ((255*2) * 10) + 1 = 5111 DVTG ==> depend on check flow code  
		// timer need at least 2010 DVTG to send out underflag
		#20481; // make sure to capture underflow flag

		address = 8'h02;
		top.cpu.read_CPU(address, rdata);
		$display("read TSR=%0d register at %0t", rdata, $time);
		if (rdata[0] == 1'b1) begin
			flag = 0;
			$display("=======================================PASS==================================\n");
		end
		else begin
			flag = 1;
			$display("======================================FAIL===================================\n");
		end
		
		address = 8'h02;
		wdata = 8'b0000_0010;
		top.cpu.write_CPU(address, wdata);
		$display("===========================CLEAR TSR================================\n");
		#100;
		top.cpu.read_CPU(address, rdata);
		if (rdata[1] == 1'b0) begin
			flag = 0;
			$display("=======================================PASS==================================\n");
		end
		else begin
			flag = 1;
			$display("======================================FAIL===================================\n");
		end
		end


		#100;
		top.get_results(flag);
		#100;
		$finish();
	end
endmodule