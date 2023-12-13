module read_write_TDR();
	reg [7:0] address, wdata, rdata;
	reg flag;
	integer i;
	reg [7:0] mask_TDR_reg = 8'hff;

	timer_tb top();


	initial begin
		// reset system 1st
		top.system.reset();
		#100; // delay for transient time
		$display("==============================================================================");
		$display("============================TDR_read_write_test_begin=========================");
		$display("=============================================================================="); 
		for(i = 0; i<50; i = i+1) begin
			$display("TEST NO .%3d\n", i);
			address = 8'h00; // write to TDR
			wdata = $random(); // random value to write
			top.cpu.write_CPU(address, wdata); // using APB to write
			$display("write random value to TDR at %0t", $time);
			top.cpu.read_CPU(address, rdata); // using APB to read
			

			// compare without mask
			if (rdata == wdata) begin
					flag = 0;
					$display("at %0t wdata=%0d rdata=%0d", $time, wdata,rdata);
					$display("====================================PASS=============================");
				end
			// compare with mask
			else if ((wdata & mask_TDR_reg) == rdata) begin
					flag = 0;
					$display("at %0t wdata=%0d rdata=%0d", $time, wdata,rdata);
					$display("====================================PASS=============================");
				end
			else begin
					flag = 1;
					$display("at %0t wdata=%0d rdata=%0d", $time, wdata,rdata);
					$display("====================================FAIL=============================");
				end
		end	


		#100;
			top.get_results(flag);
		#1000;
	$finish();
	end	
endmodule
