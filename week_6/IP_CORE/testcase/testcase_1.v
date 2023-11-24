module testcase_1();
	reg [7:0] address, wdata, rdata;
	reg flag;
	integer i;
	// reg [7:0] rdata_1;
	// reg [7:0] rdata_2;
	// reg [7:0] rdata_3;
	// reg [7:0] rdata_4;
	// reg [7:0] rdata_5;
	// reg [7:0] rdata_6;
	// reg [7:0] rdata_7;
	// reg [7:0] rdata_0;
	// reg [7:0] rdata, wdata;
	// reg [7:0] addr;
	

	decoder_tb top();

	initial begin
		#100; // delay for transient time
			// case 1
			for(i = 0; i<8; i = i+1) begin //test reset 
				address = i;
				wdata = $random();
				top.cpu.write_CPU(address, wdata);
			end
			$display("Initialize 8 registers");
			// reset here
			top.system.reset();
			for(i = 0; i<8; i = i+1) begin 
				address = i;
				top.cpu.read_CPU(address, rdata);
				if (rdata == 8'h00) begin
					flag = 0;
					$display("at %0t", $time);
					$display("PASS");
				end
				else begin
					flag = 1;
					$display("at %0t", $time);
					$display("FAIL");
				end
			end

		//case 2
		#30;	
			for(i = 0; i<8; i = i+1) begin //test reset
				address = i;
				wdata = $random();
				top.cpu.write_CPU(address, wdata);
			end
			// reset here
			top.system.reset();
			$display("Initialize 8 registers");
			for(i = 0; i<8; i = i+1) begin // write & read 2nd time
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
