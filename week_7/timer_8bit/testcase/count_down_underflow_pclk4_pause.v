module count_down_underflow_pclk4_pause();
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
	$display("===================COUNT DOWN WITH PAUSE PCLK 2_test_begin====================");
	$display("==============================================================================");
	$display("\n");

	
	$display("=====================load TDR to timer========================================");
	$display("\n");
	
	address = 8'h00; // TDR addess using APB protocol to write
	wdata = $random(); // Load 'd255 to TDR => Timer need to count down 255 internal clock to send out underflag
	random_val = wdata;
	wait_time =((random_val) * 40) + 1;
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
	wdata = 8'b00_11_00_01; // Load 8'b00_11_00_00 to TCR => set timer to count down with internal clock = 2T pclk 
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
	$display("=============================wait for random time=================================");
	$display("\n");

	
	// pause timer for 12345 
	address = 8'h01;
	wdata = 8'b00_10_00_01;
	top.cpu.write_CPU(address, wdata);
	#val1;
	$display("random value for wait time is %0d", val1);


	$display("\n");
	$display("=====================check flag before continue=============================");
	$display("\n");


	// check flag before continue
	address = 8'h02;
	top.cpu.read_CPU(address, rdata);
	if (rdata[1] == 1'b0) begin
		flag = 1'b0;
		$display("PASS");
	end
	else begin
		flag = 1'b1;
		$display("FAIL");
	end

	$display("\n");
	$display("======================== continue to count=================================");
	$display("\n");


	// enable timer again
	address = 8'h01;
	wdata = 8'b00_11_00_01;
	top.cpu.write_CPU(address, wdata);

	$display("\n");
	$display("===================check flag after pause time=============================");
	$display("\n");

	
	val2 = (wait_time / 2) + 1;
	#val2; // make sure for capture the flag

	// check flag before continue
	address = 8'h02;
	top.cpu.read_CPU(address, rdata);
	if (rdata[1] == 1'b1) begin
		flag = 1'b0;
		$display("PASS");
	end
	else begin
		flag = 1'b1;
		$display("FAIL");
	end


	address = 8'h02;
	wdata = 8'b0000_0001;
	top.cpu.write_CPU(address, wdata);
	$display("=================================CLEAR TSR================================\n");
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

	


	#100;
	top.get_results(flag);
	#100;
	$finish();


	end


endmodule
