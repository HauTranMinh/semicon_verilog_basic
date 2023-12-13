module non_exist_address();
	reg [7:0] address, wdata, rdata;
	reg flag;
	integer i;
	reg [7:0] mask_TCR_reg = 8'b1011_0011;
	reg [7:0] mask_TDR_reg = 8'b1111_1111;
	reg [7:0] mask_TSR_reg = 8'b0000_0011;

	timer_tb top();

	initial begin
		// reset system 1st
		top.system.reset();
		#100; // delay for transient time
		$display("==============================================================================");
		$display("============================TCR_read_write_test_begin=========================");
		$display("==============================================================================");
		for(i = 4; i<12; i = i+1) begin
			$display("TEST NO .%3d\n", i-3);
			address = i; // write to all registor 
			wdata = $random(); // random value to write
			top.cpu.write_CPU(address, wdata); // using APB to write
			$display("write random value to register at %0t", $time);
			top.cpu.read_CPU(address, rdata); // using APB to read
			

			// compare without mask
			if (rdata === 8'hxx) begin 
					// this means that the read data value must be equally in logic with the value 8'hxx
					// because a value will equal to X if at least once of them been X  no matter the other
					flag = 0;
					$display("at %0t wdata=%0d rdata=%0d", $time, wdata, rdata);
					$display("====================================PASS=============================");
				end
			// compare with mask (don't need to use in this case)
			// else if ((wdata & mask_TCR_reg) == 8'hxx) begin
			// 		flag = 0;
			// 		$display("at %0t wdata=%0d rdata=%0d", $time, wdata,rdata);
			// 		$display("====================================PASS=============================");
			// 	end
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