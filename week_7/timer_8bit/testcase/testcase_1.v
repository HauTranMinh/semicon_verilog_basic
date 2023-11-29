module testcase_1();
	reg [7:0] address, wdata, rdata;
	reg flag;
	integer i;

	timer_tb top();

	initial begin
		#100; // delay for transient time
			// case 1
			for(i = 1; i<3; i = i+1) begin //test reset 
				address = i;
				wdata = $random();
				top.cpu.write_CPU(address, wdata);
			end
			$display("Initialize 3 registers 1st case");
			// reset here
			top.system.reset();
			for(i = 0; i<2; i = i+1) begin 
				address = i;
				top.cpu.read_CPU(address, rdata);
				if (rdata == 8'h00) begin
					flag = 0;
					$display("at %0t wdata=%0d rdata=%0d", $time, wdata,rdata);
					$display("PASS");
				end
				else begin
					flag = 1;
					$display("at %0t wdata=%0d rdata=%0d", $time, wdata,rdata);
					$display("FAIL");
				end
			end

		//case 2
		#30;	
			for(i = 0; i<2; i = i+1) begin //test reset
				address = i;
				wdata = $random();
				top.cpu.write_CPU(address, wdata);
			end
			// reset here
			top.system.reset();
			$display("Initialize 3 registers 2nd case");
			for(i = 0; i<2; i = i+1) begin // write & read 2nd time
				address = i;
				wdata = $random();
				top.cpu.write_CPU(address, wdata);
				top.cpu.read_CPU(address, rdata);
				if (rdata == wdata) begin
					$display("at %0t wdata=%0d rdata=%0d", $time, wdata,rdata);
					flag = 0;
					$display("PASS");
				end
				else begin
					$display("at %0t wdata=%0d rdata=%0d", $time,wdata,rdata);
					flag = 1;
					$display("FAIL");
				end
			end

		#100;
			top.get_results(flag);
		#1000;
	$finish();
		
	end

endmodule
