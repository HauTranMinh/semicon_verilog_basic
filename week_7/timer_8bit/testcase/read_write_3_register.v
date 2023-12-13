module read_write_3_register();
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
		#100;
		$display("==============================================================================");
		$display("===========================Read_write_3_register_test_begin===================");
		$display("==============================================================================");
		$display("\n");
		
		$display("==============================================================================");
		$display("=========================Read_write_TDR_register_test_begin===================");
		$display("==============================================================================");
		$display("\n");
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
			
		$display("==============================================================================");
		$display("=========================Read_write_TCR_register_test_begin===================");
		$display("==============================================================================");
		$display("\n");
		address = 8'h01; // write to TDR
		wdata = $random(); // random value to write
		top.cpu.write_CPU(address, wdata); // using APB to write
		$display("write random value to TCR at %0t", $time);
		top.cpu.read_CPU(address, rdata); // using APB to read
		

		// compare without mask
		if (rdata == wdata) begin
				flag = 0;
				$display("at %0t wdata=%0d rdata=%0d", $time, wdata,rdata);
				$display("====================================PASS=============================");
			end
		// compare with mask
		else if ((wdata & mask_TCR_reg) == rdata) begin
				flag = 0;
				$display("at %0t wdata=%0d rdata=%0d", $time, wdata,rdata);
				$display("====================================PASS=============================");
			end
		else begin
				flag = 1;
				$display("at %0t wdata=%0d rdata=%0d", $time, wdata,rdata);
				$display("====================================FAIL=============================");
			end

		$display("==============================================================================");
		$display("=========================Read_write_TDR_register_test_begin===================");
		$display("==============================================================================");
		$display("\n");
		top.system.reset();
		#100; // delay for transient time
		$display("==============================================================================");
		$display("============================TSR_read_write_test_begin=========================");
		$display("==============================================================================");


		address = 8'h02;
		$display("TEST NO .01\n"); // ghi 0 vào thanh ghi ở vị trí số [0] và [1]
		wdata = 8'b1111_1100; // data want to write
		top.cpu.write_CPU(address, wdata); // using APB to write

		$display("write 8'b1111_1100 to TSR at %0t", $time);
		#10;
		top.cpu.read_CPU(address, rdata); // using APB to read

		if ((rdata[1] == 1'b0) && (rdata[0] == 1'b0)) begin
				flag = 0;
				$display("at %0t wdata=%0d rdata=%0d", $time, wdata, rdata);
				$display("====================================PASS=============================");
			end
		// compare with mask
		// else if (((wdata & mask_TDR_reg)[0] == 1'b0) && ((wdata & mask_TDR_reg)[1] == 1'b0)) begin
		// 		flag = 0;
		// 		$display("at %0t wdata=%0d rdata=%0d", $time, wdata, rdata);
		// 		$display("====================================PASS=============================");
		// 	end
		else begin
				flag = 1;
				$display("at %0t wdata=%0d rdata=%0d", $time, wdata, rdata);
				$display("====================================FAIL=============================");
			end



		top.system.reset();
		#100;
		$display("TEST NO .02\n"); // ghi 0 vào thanh ghi ở vị trí số [1] 
		wdata = 8'b1111_1101; // an  message want to send for verification
		top.cpu.write_CPU(address, wdata); // using APB to write
		$display("write 8'b1111_1101 to TSR at %0t", $time);
		#10;
		top.cpu.read_CPU(address, rdata); // using APB to read

		if ((rdata[1] == 1'b0) && (rdata[0] == 1'b0)) begin
				flag = 0;
				$display("at %0t wdata=%0d rdata=%0d", $time, wdata, rdata);
				$display("====================================PASS=============================");
			end
		// compare with mask
		// else if (((wdata & mask_TDR_reg)[0] == 1'b0) && ((wdata & mask_TDR_reg)[1] == 1'b0)) begin
		// 		flag = 0;
		// 		$display("at %0t wdata=%0d rdata=%0d", $time, wdata, rdata);
		// 		$display("====================================PASS=============================");
		// 	end
		else begin
				flag = 1;
				$display("at %0t wdata=%0d rdata=%0d", $time, wdata, rdata);
				$display("====================================FAIL=============================");
			end


		top.system.reset();
		#100;
		$display("TEST NO .03\n"); // ghi 0 vào thanh ghi ở vị trí số [0] 
		wdata = 8'b1111_1110; // an message want to send for verification
		top.cpu.write_CPU(address, wdata); // using APB to write
		$display("write 8'b1111_1110 to TSR at %0t", $time);
		#10;
		top.cpu.read_CPU(address, rdata); // using APB to read

		if ((rdata[1] == 1'b0) && (rdata[0] == 1'b0)) begin
				flag = 0;
				$display("at %0t wdata=%0d rdata=%0d", $time, wdata, rdata);
				$display("====================================PASS=============================");
			end
		// compare with mask
		// else if (((wdata & mask_TDR_reg)[0] == 1'b0) && ((wdata & mask_TDR_reg)[1] == 1'b0)) begin
		// 		flag = 0;
		// 		$display("at %0t wdata=%0d rdata=%0d", $time, wdata, rdata);
		// 		$display("====================================PASS=============================");
		// 	end
		else begin
				flag = 1;
				$display("at %0t wdata=%0d rdata=%0d", $time, wdata, rdata);
				$display("====================================FAIL=============================");
			end

		top.system.reset();
		#100;
		$display("TEST NO .04\n"); // ghi 1 vào thanh ghi ở vị trí số [0] [1]
		wdata = 8'b1111_1111; // an message want to send for verification
		top.cpu.write_CPU(address, wdata); // using APB to write
		$display("write 8'b1111_1111 to TSR at %0t", $time);
		#10;
		top.cpu.read_CPU(address, rdata); // using APB to read

		if ((rdata[1] == 1'b0) && (rdata[0] == 1'b0)) begin
				flag = 0;
				$display("at %0t wdata=%0d rdata=%0d", $time, wdata, rdata);
				$display("====================================PASS=============================");
			end
		// compare with mask
		// else if (((wdata & mask_TDR_reg)[0] == 1'b0) && ((wdata & mask_TDR_reg)[1] == 1'b0)) begin
		// 		flag = 0;
		// 		$display("at %0t wdata=%0d rdata=%0d", $time, wdata, rdata);
		// 		$display("====================================PASS=============================");
		// 	end
		else begin
				flag = 1;
				$display("at %0t wdata=%0d rdata=%0d", $time, wdata, rdata);
				$display("====================================FAIL=============================");
			end


		#100;
		top.get_results(flag);
		#1000;
		$finish();
	end
endmodule
