module count_up_reload_pclk2();
	reg [7:0] address, wdata, rdata;
	reg flag;
	integer i, random_val, wait_time, val1, val2;
	reg [7:0] mask_TCR_reg = 8'b1011_0011;
	reg [7:0] mask_TDR_reg = 8'b1111_1111;
	reg [7:0] mask_TSR_reg = 8'b0000_0011;

	timer_tb top();

	initial begin
		// reset system for 1st time
		top.system.reset();
		#100;
		$display("==============================================================================");
		$display("===================COUNT UP AND RELOAD PCLK 2_test_begin======================");
		$display("==============================================================================");
		$display("\n");	

		$display("=====================load TDR to timer========================================");
		$display("\n");

		address = 8'h00; // TDR addess using APB protocol to write
		wdata = $random(); // Load 'd255 to TDR => Timer need to count down 255 internal clock to send out underflag
		random_val = wdata;
		$display("random is %0d", random_val);
		wait_time =((255 - (random_val) + 1) * 2 * 10);
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

		$display("\n");
		$display("==========================START timer=========================================");
		$display("\n");
	
		address = 8'h01;
		wdata = 8'b00_01_00_00; // Load 8'b00_11_00_00 to TCR => set timer to count down with internal clock = 2T pclk 
		// load = TCR[7] = 1 => load to register
		// up/dw bit = 1 => count down
		// en bit => enable timer
		// cks [1:0] = 00 => internal clock = 2T Pclk external 
		// ====> timer need more than ((255-random_val) * 2) + 1 signal clock to send out underflow flag;
		// write to Timer
		top.cpu.write_CPU(address, wdata);
		val1 = wait_time/2;
		// count for half wait time and then pause 
		#val1;
		$display("count for %0d", val1);

		$display("\n");
		$display("==========================DISABLE timer=====================================");
		$display("\n");

		address = 8'h01;
		wdata = 8'b00_00_00_00; //disable timer
		top.cpu.write_CPU(address, wdata);
		$display("ad %0t timer is disable for reload", $time);	
		
		$display("\n");
		$display("==========================check flag before reload=========================");
		$display("\n");


		address = 8'h02;
		top.cpu.read_CPU(address, rdata);
		$display("ad %0t TSR is 'h=%0d", $time, rdata);
		if (rdata[0] == 1'b0) begin
			flag = 1'b0;
			$display("PASS");
		end
		else begin
			flag = 1'b1;
			wdata = 8'h00;
			top.cpu.write_CPU(address, wdata);
			$display("FAIL");
			$display("=========================== FLAG HAS BEEN CLEAR==================================");
		end


		$display("=====================Reload TDR to timer======================================");
		$display("\n");

		address = 8'h00; // TDR addess using APB protocol to write
		wdata = $random(); // Load 'd255 to TDR => Timer need to count down 255 internal clock to send out underflag
		random_val = wdata;
		$display("random is %0d", random_val);
		wait_time =((255 - (random_val) + 1) * 2 * 10);
		// write to TDR registor 
		top.cpu.write_CPU(address, wdata);

		address = 8'h01;
		wdata = 8'b10_00_00_00;
		$display("load value TDR at %0t to counter_reg", $time);
		top.cpu.write_CPU(address, wdata);

		$display("\n");
		$display("=====================configurate TCR to timer=================================");
		$display("\n");

		$display("\n");
		$display("==========================START timer=========================================");
		$display("\n");
	
		address = 8'h01;
		wdata = 8'b00_01_00_00; // Load 8'b00_11_00_00 to TCR => set timer to count down with internal clock = 2T pclk 
		// load = TCR[7] = 1 => load to register
		// up/dw bit = 1 => count down
		// en bit => enable timer
		// cks [1:0] = 00 => internal clock = 2T Pclk external 
		// ====> timer need more than ((255-random_val) * 2) + 1 signal clock to send out underflow flag;
		// write to Timer
		top.cpu.write_CPU(address, wdata);

		val2 = wait_time + 1;
		#val2;
		
		$display("\n");
		$display("==========================FINAL CHECK timer====================================");
		$display("\n");

		address = 8'h02;
		top.cpu.read_CPU(address, rdata);
		$display("ad %0t TSR is 'h=%0d", $time, rdata);
		if (rdata[0] == 1'b1) begin
			flag = 1'b0;
			$display("PASS");
		end
		else begin
			flag = 1'b1;
			//wdata = 8'h00;
			//top.cpu.write_CPU(address, wdata);
			$display("FAIL");
			//$display("=======================================UNDERFLOW FLAG HAS BEEN CLEAR==================================");
		end
		
		$display("\n");
		$display("==========================CLEAR FLAG =========================================");
		$display("\n");

		address = 8'h02;
		top.cpu.read_CPU(address, rdata);
		$display("ad %0t TSR is 'h=%0d", $time, rdata);
		if (rdata[0] == 1'b0) begin
			flag = 1'b0;
			$display("PASS");
		end
		else begin
			flag = 1'b1;
			//wdata = 8'h00;
			//top.cpu.write_CPU(address, wdata);
			$display("FAIL");
			//$display("=======================================UNDERFLOW FLAG HAS BEEN CLEAR==================================");
		end
		#100;
		top.get_results(flag);
		#100;
		$finish();

	end

endmodule
