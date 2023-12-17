module count_down_fake_condition_pclk8();
	reg [7:0] address, wdata, rdata;
	reg flag;
	integer i, random_val, wait_time, val1, val2;
	reg [7:0] mask_TCR_reg = 8'b1011_0011;
	reg [7:0] mask_TDR_reg = 8'b1111_1111;
	reg [7:0] mask_TSR_reg = 8'b0000_0011;

	timer_tb top();

	initial begin
		top.system.reset();
		#100;
		$display("==============================================================================");
		$display("===================COUNT DOWN AND RESET PCLK 8_test_begin=====================");
		$display("==============================================================================");
		$display("\n");


		$display("=============================LOAD 8'H00 AND TO TDR============================");
		$display("\n");

		address = 8'h00; // TDR addess using APB protocol to write
		wdata = 8'h00; // Load 'd255 to TDR => Timer need to count down 255 internal clock to send out underflag
		random_val = wdata;
		$display("random is %0d", random_val);
		wait_time =((random_val + 1) * 8 * 10);
		// write to TDR registor 
		top.cpu.write_CPU(address, wdata);

		address = 8'h01;
		wdata = 8'b10_00_00_00;
		$display("load value TDR at %0t to counter_reg", $time);
		top.cpu.write_CPU(address, wdata);

		#5; // DEPEND ON USER CLOCKS FREQUENCE

		$display("=============================LOAD 8'HFF AND TO TDR============================");
		$display("\n");

		address = 8'h00; // TDR addess using APB protocol to write
		wdata = 8'hff; // Load 'd255 to TDR => Timer need to count down 255 internal clock to send out underflag
		random_val = wdata;
		$display("random is %0d", random_val);
		wait_time =((random_val + 1) * 8 * 10);
		// write to TDR registor 
		top.cpu.write_CPU(address, wdata);

		address = 8'h01;
		wdata = 8'b10_00_00_10;
		$display("load value TDR at %0t to counter_reg", $time);
		top.cpu.write_CPU(address, wdata);

		address = 8'h01;
		wdata = 8'b00_11_00_10;
		$display("load value TDR at %0t to counter_reg", $time);
		top.cpu.write_CPU(address, wdata);

		$display("=============================check TSR============================");
		$display("\n");

		address = 8'h02;
		top.cpu.read_CPU(address, rdata);
		if (rdata[1] == 1'b0) begin
			flag = 1'b0;
			$display("PASS");
			$display("\n");
		end
		else begin
			flag = 1'b1;
			$display("FAIL");
			$display("\n");
		end


		#100;
		top.get_results(flag);
		#100;
		$finish();
	end

endmodule